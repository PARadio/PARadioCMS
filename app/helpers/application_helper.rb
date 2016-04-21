module ApplicationHelper
  def error_messages_for(object)
    render(:partial=> 'shared/error_messages',:locals => {:object => object})
  end

  def echoGlyphicon(name)
    return "<span class='glyphicon glyphicon-#{name}' aria-hidden='true'></span>".html_safe
  end

  def setCols(size)
    columns=["xs","sm","md","lg"]
    colString=""
    columns.each do |col|
      colString+="col-#{col}-#{size} "
    end
    return colString
  end
end
