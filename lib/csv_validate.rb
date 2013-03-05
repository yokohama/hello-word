#encoding: utf-8
require "csv"

class CsvValidate
  def self.validate(data)
    csv = CSV.new(data)

    line = 0
    error_count = 0
    records = []
    csv.each do |c|
      r = {}
      r[:word] = c[0]
      r[:answer] = c[1]
      if c.size != 2 || r[:word].blank? || r[:answer].blank?
        r[:error_line_no] = line
        error_count += 1
      end
      records << r
      line += 1
    end
    return records, error_count
  end
end
