class ApplicationController < ActionController::Base
  BUCKET = 'hugolnxbucket'

  def bucket_name
    BUCKET
  end
  helper_method :bucket_name

  protect_from_forgery
end
