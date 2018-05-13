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
    attr_reader :video_repo, :video_client
  def initialize(video_repo:, video_client:)
    @video_repo = video_repo
    @video_client = video_client
  end

  def video_list
    @video_list = video_repo.videos
    ids = @video_list.map{|v| v['youtubeID']}
    response = video_client.video_stats(ids)
    ids.each do |id|
      video = @video_list.find{|v| id == v['youtubeID']}
      youtube_record = response['items'].find{|v| id == v['id']}
      video['views'] = youtube_record['statistics']['viewCount'].to_i   
      video['monthlyViews'] = monthlyViews(video['views'], youtube_record['snippet']['publishedAt'])
    end
    return JSON.dump(@video_list)
  end

  private

  def monthlyViews(views, publishing_date)
    days_available = Date.today - Date.parse(publishing_date)
    return views if days_available < 31
    views * 365.0 / days_available / 12
  end
end
