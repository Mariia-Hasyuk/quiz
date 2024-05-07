module Quiz
  class Engine
    def initialize
      @question_data = QuestionData.new(yaml_dir: Config.instance.yaml_dir)
      @input_reader = InputReader.new
      @writer = FileWriter.new('a+', generate_filename)
      @statistics = Statistics.new(@writer)
      user_name = @input_reader.read(welcome_message: "Enter your name:", error_message: "The name cannot be empty!", validator: ->(input) { !input.empty? })
      current_time = Time.now.strftime("%Y-%m-%d %H:%M:%S")
      @writer.write("Test #{user_name}'s start at #{current_time}")
    end

    def run
      start_time = Time.now
      shuffled_questions = @question_data.collection.shuffle
      shuffled_questions.each do |question|
        puts question.to_s
        puts question.display_answers
        value, user_answer = get_answer_by_char(question)
        correct_answer = question.question_correct_answer
        check(user_answer, correct_answer)
        @writer.write("Question: #{question.to_s}, Your answer: #{user_answer}, Correct answer: #{correct_answer}")
      end
      end_time = Time.now
      elapsed_time = end_time - start_time
      @statistics.print_report
      puts "The test is completed by #{elapsed_time.round(2)} sec."
      @writer.write("The test is completed at #{end_time.strftime('%Y-%m-%d %H:%M:%S')}")
    end

    def check(user_answer, correct_answer)
      if user_answer == correct_answer
        @statistics.correct_answer
      else
        @statistics.incorrect_answer
      end
    end

    def get_answer_by_char(question)
      answer = nil
      until answer
        char = @input_reader.read(welcome_message: "Enter your answer [A, B, C, D, E]:", error_message: "Please enter a valid letter.", validator: ->(input) { ('A'..'E').include?(input.upcase) && !input.empty? }).upcase
        answer = question.find_answer_by_char(char)
      end
      [answer, char]
    end

    private

    def generate_filename
      count = 1
      filename = ''
      loop do
        filename = "user_answer_#{Time.now.strftime('%Y%m%d%H%M%S')}_#{count}.txt"
        break unless File.exist?(filename)

        count += 1
      end
      filename
    end
  end
end
