load './exercise_generator.rb'

module MySession
    class Session
        def initialize(user, count, exercises=[])
            @count = count
            @user = user
        end
    
        attr_accessor :exercises
    
        def start
            e_gen = MyExerciseGenerator::ExerciseGenerator.new(@count)
            @exercises = e_gen.generate
            @exercises.each{ |x| x.execute}
            return check
        end
    
        def check
            total_correct = 0
            total_time = 0
            @exercises.each{ |x| 
                if x.is_correct == true
                    total_correct+=1
                end
                total_time += x.time
            }
            avg_time = (total_time / @count).truncate(2)
            print_results(total_correct, avg_time, total_time)
            @user.add_session(total_time: total_time, total_correct: total_correct, total_exercises: @count, avg_time: avg_time)
            puts @user.sessions.first.created_at.to_s
            return [total_correct, @count, avg_time, total_time]
        end
    
        def print_results(total_correct, avg_time, total_time)
            puts "\nРезультат: \nКоличество правильно решённых примеров: %d \nОбщее количество примеров: %d\
                \nСреднеее время решения одного примера: %0.2f \nОбщее время решения: %0.2f" % 
                [total_correct, @count, avg_time, total_time]
        end
    end

    class SessionViewer
        def initialize(sessions=[])
            @sessions = sessions
        end

        attr_accessor :sessions

        def print_last_n(n)
            statistic = Hash["total_correct" => 1, "total_exercises" => 1, "total_time" => 1]
            puts statistic
            if @sessions.length >= n
                for index in 0 .. @n-1
                    tmp = @sessions[index]
                    statistic["total_correct"] = statistic["total_correct"] + tmp.total_correct
                    statistic["total_exercises"] = statistic["total_exercises"] + tmp.total_exercises.to_i
                    statistic["total_time"] = statistic["total_time"] + tmp.total_time

                    75.times { print '-' }
                    puts "\nСессия (%s) \nКоличество правильно решённых примеров: %d \nОбщее количество примеров: %d\
                    \nСреднеее время решения одного примера: %0.2f \nОбщее время решения: %0.2f \n" % 
                    [tmp.created_at, tmp.total_correct, tmp.total_exercises, tmp.avg_time, tmp.total_time]
                    75.times { print '-' }
                end
            else
                @sessions.each do |session|
                    statistic["total_correct"] = statistic["total_correct"] + session.total_correct
                    statistic["total_exercises"] = statistic["total_exercises"] + session.total_exercises.to_i
                    statistic["total_time"] = statistic["total_time"] + session.total_time

                    75.times { print '-' }
                    puts "\nСессия (%s) \nКоличество правильно решённых примеров: %d \nОбщее количество примеров: %d\
                    \nСреднеее время решения одного примера: %0.2f \nОбщее время решения: %0.2f \n" % 
                    [session.created_at, session.total_correct, session.total_exercises, 
                        session.avg_time, session.total_time]
                    75.times { print '-' }
                end
            end
            puts "\nРезультат за всё время \nКоличество правильно решённых примеров: %d \nОбщее количество примеров: %d\
            \nСреднеее время решения одного примера: %0.2f \nОбщее время решения: %0.2f \n" % 
            [statistic["total_correct"], statistic["total_exercises"],
                statistic["total_time"]/statistic["total_exercises"], statistic["total_time"]]
        end
    end
end