module ApplicationHelper

  def error_messages(model)
    html = ''
    #if model.errors && model.errors.messages
    if model.errors.messages.count > 0
      html += '<div class="alert alert-error">'
      model.errors.messages.each do |k, v|
        html += "<p>#{k} #{v[0]}</p>"
      end
      html += '</div>'
    end
    raw html
  end

end
