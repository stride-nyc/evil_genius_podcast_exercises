class VideoService
  def video_list
     # Read a json file  and store the contents in an instance variable
    @video_list = JSON.parse(File.read('videos.json'))
    # Get all the ids of the stored in the contents and JSON file that was just
    ids = @video_list.map{|v| v['youtubeID']}
    # Get authorized with Google to be allowed to make API calls
    client = GoogleAuthorizer.new(
      token_key: 'api-youtube',
      application_name: 'Gateway Youtube Example',
      application_version: '0.1'
      ).api_client
    # Not sure what this does, but I think its a way to tell youtube what I'm asking for
    youtube = client.discovered_api('youtube', 'v3')
    # Send the request to Youtube passing in the ids of the videos from out Json file and telling which
    # data we want from youtube. We want a video snippet, contentDetails(probably a description)
    # and statistics about the video
    request = {
      api_method: youtube.videos.list, # This looks like there are many api_methods and the one
      # we are asking for is the one that returns a list of videos.
      parameters: {
        id: ids.join(","),
        part: 'snippet, contentDetails, statistics',
      }
    }
    # Get the body of the response and parse it with JSON.parse to make into a Ruby hash
    response = JSON.parse(client.execute!(request).body)
    # Go through the array of ids
    ids.each do |id| 
      # Find the video object that matches the this specific id
      video = @video_list.find{|v| id == v['youtubeID']}
       # Go through the items from the response and find one that matches the id 
      youtube_record = response['items'].find{|v| id == v['id']}
      # Update the views key in the video object(the one we got from our JSON file)
      # with the viewCount from the response we got from youtube.
      video['views'] = youtube_record['statistics']['viewCount'].to_i
      # Find out how many days the video has been live from the response from youtube
      days_available = Date.today - Date.parse(youtube_record['snippet']['publishedAt'])
       # Update the monthly views of the video
      video['monthlyViews'] = video['views'] * 365.0 / days_available / 12      
    end
    # return the updated video list in a JSON dump
    return JSON.dump(@video_list)
  end
end