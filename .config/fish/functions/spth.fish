function spth --description 'preferred number of threads for things like compilation'
  switch (hostname)
    case 'altair'
      echo 8
      return
    case 'procyon'
      echo 6
      return
    case 'eltanin'
      echo 4
      return
  end
  if on_ifarm
    echo 8
    return
  end
  echo 1
end
