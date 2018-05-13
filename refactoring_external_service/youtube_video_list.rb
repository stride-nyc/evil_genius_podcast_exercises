 class VideoRepo
    def videos
      video_list_json = File.read('videos.json')
      JSON.parse(video_list_json)
    end
 end

 class YoutubeVideoClient
    def video_stats(youtube_ids)
      client = GoogleAuthorizer.new(
        token_key: 'api-youtube',
        application_name: 'Gateway Youtube Example',
        application_version: '0.1'
        ).api_client

      youtube = client.discovered_api('youtube', 'v3')
      request = {
        api_method: youtube.videos.list,
        parameters: {
          id: youtube_ids.join(","),
          part: 'snippet, contentDetails, statistics',
        }
      }
      
      response = JSON.parse(client.execute!(request).body)
    end
 end
 
 class VideoService
    attr_reader :video_repo
  def initialize(video_repo:)
    @video_repo = video_repo
  end

  def video_list
    @video_list = video_repo.videos
    ids = @video_list.map{|v| v['youtubeID']}
    response = get_youtube_stats_on_videos(ids)
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

  def get_youtube_stats_on_videos(youtube_ids)
    YoutubeVideoClient.new.video_stats(youtube_ids)
  end
end
