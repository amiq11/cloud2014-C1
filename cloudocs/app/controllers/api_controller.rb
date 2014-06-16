require 'json'

class ApiController < ActionController::Base
  def payload
    is_master = 1
    is_pusher = 0
    if request.post?
      #push = params[:api] ? JSON.parse(params[:api]) : nil
      params.each do |key, value|
        if key == "ref"
          if value == "/ref/heads/master"
            is_master = 1
          end
        end
        if key == "pusher"
          is_pusher = 1
        end
      end
    end
    if is_pusher == 1 && is_master == 1
      #pull 
      p "We gonna pull!!!"
      result = system("pull")
    end
  end

  def get_file
  end

  
  protect_from_forgery with: :null_session
end
