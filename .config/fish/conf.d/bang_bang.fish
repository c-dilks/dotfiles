function bang_bang
  echo $history[1]
end
function slash_slash
  echo $history[1]/
end
abbr -a !! --position anywhere --function bang_bang
abbr -a // --position anywhere --function slash_slash
