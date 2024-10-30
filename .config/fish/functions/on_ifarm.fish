function on_ifarm --description 'determine if we are on ifarm'
  string match --quiet --regex "ifarm" (hostname)
end
