require 'exercise.rb'

module MyExerciseGenerator
    OPERATION_TYPE ||= Hash["1" => "addition", "2" => "subtraction", "3" => "division", "4" => "multiplication"]

    class ExerciseGenerator
        def initialize(count)
            @count = count
        end

        def get_random_operation
            return OPERATION_TYPE[rand(1..4).to_s]
        end

        def first_num_greater
            if rand(1) == 0
                return true
            else
                return false
            end
        end

        def generate
            ex_array = Array.new()
            for index in 0 .. @count-1
                operation = get_random_operation
                first = 0
                second = 0
                case operation
                when "addition"
                    if first_num_greater
                        first = rand(2..99)
                        second = rand(1..100-first)
                    else
                        second = rand(2..99)
                        first = rand(1..100-second)
                    end
                    ex_array[index] = MyExercise::Exercise.new("%d + %d = ?" % [first, second], first + second, index+1)
                when "subtraction"
                    first = rand(2..99)
                    second = rand(1..first-1)
                    ex_array[index] = MyExercise::Exercise.new("%d - %d = ?" % [first, second], first - second, index+1)
                when "division"
                    second = rand(2..10)
                    first = second * rand(2..9)
                    ex_array[index] = MyExercise::Exercise.new("%d / %d = ?" % [first, second], first / second, index+1)
                when "multiplication"
                    if first_num_greater
                        first = rand(2..9)
                        second = rand(1..first-1)
                    else
                        second = rand(2..9)
                        first = rand(1..second-1)
                    end
                    ex_array[index] = MyExercise::Exercise.new("%d * %d = ?" % [first, second], first * second, index+1)
                end
            end
            return ex_array
        end
    end
end