 class VideoService
  def video_list
    @video_list = get_current_video_list
    ids = @video_list.map{|v| v['youtubeID']}
    # NOTE: External Service
    client = GoogleAuthorizer.new(
      token_key: 'api-youtube',
      application_name: 'Gateway Youtube Example',
      application_version: '0.1'
      ).api_client
    # NOTE: External Service
    youtube = client.discovered_api('youtube', 'v3')
    request = {
      api_method: youtube.videos.list,# NOTE: External Service
      parameters: {
        id: ids.join(","),
        part: 'snippet, contentDetails, statistics',
      }
    }
    # NOTE: External Service 
    response = JSON.parse(client.execute!(request).body)
    ids.each do |id|
      video = @video_list.find{|v| id == v['youtubeID']}
      youtube_record = response['items'].find{|v| id == v['id']}
      video['views'] = youtube_record['statistics']['viewCount'].to_i
      days_available = Date.today - Date.parse(youtube_record['snippet']['publishedAt'])
      video['monthlyViews'] = video['views'] * 365.0 / days_available / 12
    end
    return JSON.dump(@video_list)
  end

  private
  def get_current_video_list
    video_list_json = File.read('videos.json')
    JSON.parse(video_list_json)
  end
end
