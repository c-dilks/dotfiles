-- general settings
vim.o.number         = true  -- line numbers
vim.o.relativenumber = true  -- relative line numbers
vim.o.title          = true  -- show filename in title
vim.o.autoread       = true  -- detect changes and auto-reload
vim.o.wrap           = false -- enable sidescrolling
vim.o.sidescroll     = 1     -- smooth sidescrolling
vim.o.scrolloff      = 5     -- don't let the cursor be less than this many lines away from the top or bottom
vim.o.mouse          = 'a'   -- enable mouse in all modes

-- indentation
vim.o.autoindent  = true -- copy indent from current line when starting a new line
vim.o.expandtab   = true -- enter spaces when tab is pressed
vim.o.tabstop     = 8    -- use 2 spaces to represent tab
vim.o.shiftwidth  = 2    -- number of spaces to use for auto-indent
vim.o.softtabstop = 2
vim.o.smarttab    = true -- insert tabs at beginning of line
vim.o.smartindent = true -- C-like auto indentaion

-- diffopt
vim.opt.diffopt:append("internal")
vim.opt.diffopt:append("algorithm:histogram")

-- make the clipboard work when in apptainer container
-- Clipboard provider setup: real X11/Wayland tools when actually reachable,
-- OSC52 fallback otherwise (e.g. SSH with no forwarding, or a stale $DISPLAY).
local function x11_available()
  if vim.fn.executable("xsel") ~= 1 or not vim.env.DISPLAY then
    return false
  end
  -- $DISPLAY can be set but stale (e.g. leftover from a previous local
  -- session, or defensively set by SSH). Actually probe the socket.
  local ok = vim.fn.system("xset q 2>/dev/null"):find("Screen Saver") ~= nil
  return ok
end
local function wayland_available()
  if vim.fn.executable("wl-copy") ~= 1 or not vim.env.WAYLAND_DISPLAY then
    return false
  end
  -- wl-copy has no cheap "ping" equivalent to xset, but checking the
  -- runtime dir socket file existing is a reasonable proxy.
  local runtime_dir = vim.env.XDG_RUNTIME_DIR
  if not runtime_dir then
    return false
  end
  local sock = runtime_dir .. "/" .. vim.env.WAYLAND_DISPLAY
  return vim.uv.fs_stat(sock) ~= nil
end
if wayland_available() then
  -- let nvim's built-in detection handle it; wl-copy/wl-paste just work
  -- once WAYLAND_DISPLAY + XDG_RUNTIME_DIR are valid, no need to set g.clipboard
elseif x11_available() then
  -- same: nvim's built-in xsel detection is fine once the socket is real
else
  vim.g.clipboard = {
    name = "OSC 52",
    copy = {
      ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
      ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
    },
    paste = {
      ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
      ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
    },
  }
end
