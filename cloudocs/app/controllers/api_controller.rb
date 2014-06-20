require 'json'

class ApiController < ActionController::Base
  # handling webhook
  def payload
    if request.post? #### POST REQUEST
      # get secret from environment variables
      secret = ENV['SECRET_TOKEN']
      # verify signature
      if verify_signature(request.body.read, secret) == 500 
        render :text => "invalid signature", :status => 403
        return 
      end
      # parse payload
      push = request.body.read ? JSON.parse(request.body.read) : nil
 
      # validate json parameters
      if !defined?(push["ref"])
        render :text => "ref is not set", :status => 403
        return 
      end
      if !defined?(push["pusher"])
        render :text => "pusher is not set", :status => 403
        return
      end
      if !defined?(push["repository"]) || !defined?(push["repository"]["url"]) || push["repository"]["url"] != "https://github.com/amiq11/cloud2014-C1"
        render :text => "repository is not set, or invalid repository url", :status => 403
        return 
      end
      # ignore push notification not by master branch
      if push["ref"] != "refs/heads/master"
        render :text => "ignored because not pushed into master branch", :status => 200
        return 
      end
      # pull 
      result = system("git pull")
      if result
        r = system("touch tmp/restart.txt")
        txt = (r) ? "SUCCEEDED" : "FAILED"
        render :text => "DEPLOY SUCCEEDED and SERVER RESTART #{txt}", :status => 200
      else
        render :text => "INTERNAL SERVER ERROR (DEPLOY FAILED)", :status => 500
      end
      return 
    else 
      render :text => "GET REQUEST IS NOT ALLOWED", :status => 403
    end
  end


  def get_file
  end





  private 
  def verify_signature(payload_body, secret)
    signature = 'sha1=' + OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha1'), secret, payload_body)
    return 500 unless Rack::Utils.secure_compare(signature, request.env['HTTP_X_HUB_SIGNATURE'])
  end
  
  protect_from_forgery with: :null_session
end
