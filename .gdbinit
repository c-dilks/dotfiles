# do not ask to auto-download data from $DEBUGINFOD_URLS
set debuginfod enabled off

# do not require confirmation for quitting
define hook-quit
    set confirm off
end
