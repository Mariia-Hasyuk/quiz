module Quiz
    class Statistics
        def initialize(writer)
            @correct_answers = 0
            @incorrect_answers = 0
            @writer = writer
        end

        def correct_answer
            @correct_answers += 1
        end

        def incorrect_answer
            @incorrect_answers += 1
        end

        def print_report
            correct_percentage = (@correct_answers.to_f / @correct_answers + @incorrect_answers).round(2)

            report = "Results:\n"
            report += "Correct answers: #{@correct_answers}\n"
            report += "Incorrect answers: #{@incorrect_answers}\n"
            report += "Percentage of correct answers: #{correct_percentage}%\n"

            @writer.write(report)
        end
    end
end
