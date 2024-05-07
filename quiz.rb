require 'singleton'

module Quiz
  class Config
    include Singleton

    attr_accessor :yaml_dir, :in_ext, :answers_dir

    def initialize
      @yaml_dir = nil
      @in_ext = nil
      @answers_dir = nil
    end

    def self.configure
      yield instance if block_given?
    end

    def print_config
      puts "Quiz Config:"
      puts "yaml_dir: #{@yaml_dir}"
      puts "answers_dir: #{@answers_dir}"
      puts "in_ext: #{@in_ext}"
    end
  end
end
