class SamplesController < ApplicationController
  def update
    files = [];
    f = params[:file]
    #f.original_filename  # => ファイル名
    #f.content_type       # => Content-Type
    p ">>>>>> #{f.size}"
    p Base64.decode64(f)
    #p csv
  end
end
