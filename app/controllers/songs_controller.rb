class SongsController < ApplicationController
  def index
    @songs = AWS::S3::Bucket.find(BUCKET).objects.find_all do |obj|
      obj.path.start_with?("/#{BUCKET}/#{current_user.email}/")
    end
  end

  def upload
    begin
      filename = sanitize_filename(params[:mp3file].original_filename)

      path = File.join(current_user.email, filename)
      AWS::S3::S3Object.store(path, params[:mp3file].tempfile, BUCKET)
      redirect_to root_path
    rescue Exception => e
      render :text => "Couldn't complete the upload"
      puts e.backtrace
    end
  end

  def delete
    if (params[:song])
      AWS::S3::S3Object.find(params[:song], BUCKET).delete
      redirect_to root_path
    else
      render :text => "No song was found to delete!"
    end
  end


  private
  def sanitize_filename(file_name)
    just_filename = File.basename(file_name)
    just_filename.sub(/[^\w\.\-]/,'_')
  end
end
