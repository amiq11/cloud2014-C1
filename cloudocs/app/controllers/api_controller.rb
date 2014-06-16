require 'json'

class ApiController < ActionController::Base
  def payload    
    if request.post?
      push = JSON.parse(params[:payload], quirks_mode: true)
      puts "I got some JSON"
    else
    end  
  end

  def get_file
  end
  protect_from_forgery with: :null_session
end
