#encoding: utf-8
require "csv"

class CsvValidate
  attr_accessor :line, :error_count, :records

  def initialize(data)
    @csv = CSV.new(data)
    @line = 0
    @error_count = 0
    @records = []
  end

  def validate
    @csv.each do |c|
      r = {}
      if !format_check(c)
        r[:error_line_no] = line
        @error_count += 1
      else
        r[:word] = c[0]
        r[:answer] = c[1]
      end
      @records << r
      @line += 1
    end
  end

  def to_words(user)
    words = []
    @csv.each do |c|
      next unless format_check(c)
      words << Word.new(:word => c[0], :answer => c[1], :user_id => user.id)
    end
    words
  end

  def format_check(line)
    (line.size == 2 && line[0].present? && line[1].present?) ? true : false
  end
end
