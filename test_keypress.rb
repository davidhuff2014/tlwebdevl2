def yesno
  begin
    # Puts "Press y to play game, n to end"
    system("stty raw -echo")
    str = STDIN.getc
  ensure
    system("stty -raw echo")
  end
  if str == "y"
    puts "Play Game!"
    true
  elsif str == "n"
    puts "Thank you for playing!"
    false
  else
    puts "Please press y to play game or n to end"
    yesno
  end
end

yesno