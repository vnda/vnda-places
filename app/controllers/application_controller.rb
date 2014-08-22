class ApplicationController < ActionController::Base
  def status
    render text: 'OK'
  end
end
