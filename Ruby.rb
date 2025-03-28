def first_task(line, subline)
  return false if line.length != subline.length
  (line * 2).include?(subline)
end

def second_task(line)
  alphabet = ('a'..'z').to_a.join('')
  alphabet += ' ' if line.include?(' ')
  alphabet.chars.all? { |c| line.include?(c) }
end

def main
  puts "Введите модуль:\n1 - 1.3\n2 - 2.9\n3 - 3.19"
  menu = gets.chomp.to_i
  move = true
  case menu
  when 1
    puts "Введите строку"
    line = gets.chomp
    puts "Введите подстроку"
    subline = gets.chomp
    puts first_task(line, subline) ? "Yes" : "No"

  when 2
    puts "Введите строку"
    valid_chars = ('a'..'z').to_a << ' '
    loop do
      line = gets.chomp.downcase
      if line.chars.all? { |c| valid_chars.include?(c) }
        puts second_task(line) ? "Yes" : "No"
        break
      else
        invalid = line.chars.reject { |c| valid_chars.include?(c) }.uniq
        puts "Ошибка! Недопустимые символы: #{invalid.join(', ')}. Повторите ввод:"
      end
    end

  when 3
    puts "Введите целые числа через пробел:"
    input = gets.chomp
    begin
      numbers = input.split.map { |n| Integer(n) }
    rescue ArgumentError
      puts "Неккоректный ввод"
      move=false
      main()
    end

    if numbers.empty?
      puts "Ошибка! Пустой ввод."
      move = false
      main()
    end
    count = numbers.each_cons(2).count { |a, b| a.abs == b.abs }
    puts "Количество чисел равных предыдущему: #{count}"

  else
    puts "Некорректный ввод"
    move = false
    main()
  end
  while move
    puts "\nЖелаете выйти в меню выбора языка?\n1 - Yes\n2 - No"
    choice = gets.chomp.to_i
    if choice == 1
      system('code /home/nomask776/Laboratory_work_second/main.cpp')
      move = false
    elsif choice == 2
      main()
    else
      puts "Неккоректный ввод" 
    end
  end 
end   

main