module ApplicationHelper
  def download_url_for(song_key)
    AWS::S3::S3Object.url_for(song_key, bucket_name, :authenticated => false)
  end

  def pretty_song_name(song)
    song.key.gsub("#{current_user.email}/", "")
  end
end
