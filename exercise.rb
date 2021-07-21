module MyExercise
    class Exercise
        def initialize(text, answer, number, is_correct=false, time=0)
            @text = text
            @answer = answer
            @number = number
            @is_correct = is_correct
            @time = time
        end

        attr_accessor :is_correct
        attr_accessor :time

        def print
            puts "%d) %s" % [@number, @text]
        end

        def execute
            print
            date1 = Time.now.to_f
            user_input = gets.chomp.to_i
            if user_input == @answer
                @is_correct = true
            else
                @is_correct = false
            end
            date2 = Time.now.to_f
            @time = (date2 - date1).truncate(2)
        end
    end
end