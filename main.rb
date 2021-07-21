load './auth.rb'
load './session.rb'
load './exercise.rb'

def age_input
    loop do
        puts 'Пожалуйста, введите ваш возраст:'
        user_input = gets.chomp.to_i
        if user_input > 0
            return user_input
        else
            puts 'Вы ввели некорректный возраст'
        end
    end
end

def name_input
    loop do
        puts 'Введите ваше имя:'
        user_input = gets.chomp
        if user_input.length > 1
            return user_input
        else
            puts 'Вы ввели некорректное имя'
        end
    end
end

def tasks_input
    loop do
        puts 'Введите желаемое количество примеров (от 10 до 100):'
        user_input = gets.chomp.to_i
        if user_input >= 10 && user_input <= 100
            return user_input
        else
            puts 'Вы ввели некорректное количество примеров'
        end
    end
end

def password_input
    loop do
        puts 'Введите пароль:'
        user_input = gets.chomp
        if user_input.length >= 1
            return user_input
        else
            puts 'Ваш пароль должен состоять как минимум из одного символа'
        end
    end
end

auth = MyAuth::Auth.new()
current_user = nil
loop do
    instructions = "\nНажмите 'n' для регистрации, 'l' для входа, или 'x' для выхода: -> "
    75.times { print '-' }
    puts instructions
    75.times { print '-' }
    puts "\n"
  
    valid_input = %w[n l x]
    user_input = gets.chomp
    if !valid_input.include? user_input
      puts 'Недопустимый ввод!'
    elsif user_input == 'n'
        name = name_input
        age = age_input
        password = password_input
        user = auth.register(name, age, password)
        if user
            current_user = user
            puts "Регистрация прошла успешно!"
        else
            puts "Данное имя пользователя уже занято"
        end
    elsif user_input == 'l'
        name = name_input
        password = password_input
        user = auth.login(name, password)
        if user
            current_user = user
            puts "Добро пожаловать, %s!" % [user.name]
        else
            puts "Неверное имя пользователя или пароль"
        end
    elsif user_input == 'x'
      exit_loop = true
    end
    break if exit_loop || current_user
end

if current_user
    loop do
        instructions = "\nНажмите 'n' для решения примеров, 's' для просмотра статистики, 'x' для выхода: -> "
        75.times { print '-' }
        puts instructions
        75.times { print '-' }
        puts "\n"
        valid_input = %w[n s x]
        user_input = gets.chomp
        if !valid_input.include? user_input
          puts 'Недопустимый ввод!'
        elsif user_input == 'n'
            session = MySession::Session.new(current_user, tasks_input)
            session.start
        elsif user_input == 's'
            sessionViewer = MySession::SessionViewer.new(current_user.sessions)
            sessionViewer.print_last_n(10)
        elsif user_input == 'x'
          exit_loop = true
        end
        break if exit_loop
    end
end