module ApplicationHelper

  def error_messages(model)
    html = ''
    #raise model.errors.messages.inspect
    if model.errors && model.errors.messages
      html += '<div class="alert alert-error">'
      model.errors.messages.each do |k, v|
        html += "<p>#{k} #{v[0]}</p>"
      end
      html += '</div>'
    end
    raw html
  end

end
