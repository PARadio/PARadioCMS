module ApplicationHelper
  def error_messages_for(object)
    render(:partial=> 'shared/error_messages',:locals => {:object => object})
  end

  def echoGlyphicon (name)
    return "<span class='glyphicon glyphicon-#{name}' aria-hidden='true'></span>".html_safe
  end
end
