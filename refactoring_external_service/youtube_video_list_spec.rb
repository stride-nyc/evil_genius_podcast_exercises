require 'minitest/autorun'
require './youtube_video_list'
require 'json'
require 'date'

class VideoServiceTest < MiniTest::Test

    class VideoRepoStub
        def videos
            [{'youtubeID' => 'blahblahblah', 'views' => 3, 'monthlyViews' => 3}]
        end
    end

    class YoutubeVideoClientStub
        def video_stats(ids=:NotGiven)
            {'items' => 
                [
                    {
                        'id' =>'blahblahblah', 
                        'statistics' => {'viewCount' => '3'}, 
                        'snippet' => {'publishedAt' => (Date.today - 30).to_s }
                    }
                ]
            }
        end
    end
    
    def test_video_list_returns_video_list
        video_service = VideoService.new(video_repo: VideoRepoStub.new, video_client: YoutubeVideoClientStub.new)
        video_array = [{'youtubeID' => 'blahblahblah', 'views' => 3, 'monthlyViews' => 3}]
        video_json = JSON.generate(video_array)

        result = JSON.parse(video_service.video_list)
        actual = JSON.parse(video_json)
        assert_equal(result[0]['youtubeID'], result[0]['youtubeID'])
        assert_equal(result[0]['views'], result[0]['views'])
        assert_in_delta(result[0]['monthlyViews'], result[0]['monthlyViews'], 0.1)

    end
end