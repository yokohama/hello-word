#encoding: utf-8
require "csv"

class SamplesController < ApplicationController
  def update
    a = params[:files].split(",")
    p 'hogehogehogoehgoehgoe'
    p a.last.encoding
    p Base64.decode64(a.last)
  end

  def update
    files = [];
    f = params[:file]
    g = Base64.decode64(f)
    p g
    p g.encoding
=begin
    csv = CSV.parse_line(g)
    csv.each do |c|
      p c
    end
=end
  end
end
