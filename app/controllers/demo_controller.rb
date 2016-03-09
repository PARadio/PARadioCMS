class DemoController < ApplicationController

  layout false

  def index
  #loads demo/index by default
  end

  def hello
    # render lets you load a template specifically
    render('hello')
    # this is shorthand for render(:template => 'demo/hello')
    # render assumes that the text is an existing template, and that it belongs within demo.
  end

  def other_hello
    # This is a redirect. It tells the browser ro redirect to a different page using a provided :controller and :action
    redirect_to(:controller => 'demo', :action => 'index')
  end

  def lynda
    # This redirects by url to another site
    redirect_to("http://lynda.com")
  end
end
