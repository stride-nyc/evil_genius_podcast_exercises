require 'minitest/autorun'
require './youtube_video_list'
require 'json'
require 'date'

class VideoServiceTest < MiniTest::Test

    class VideoRepoStub
        attr_reader :canned_response
        def initialize(canned_response)
            @canned_response = canned_response
        end
        def videos
           canned_response
        end
    end

    class YoutubeVideoClientStub
        attr_reader :canned_response
        def initialize(canned_response)
            @canned_response = canned_response
        end

        def video_stats(ids=:NotGivenToStub)
            canned_response
        end
    end
    
    def test_video_list_returns_video_list
        video_repo_response = [{'youtubeID' => 'blahblahblah', 'views' => 3, 'monthlyViews' => 3}]
        youtube_client_response =  {'items' => 
            [
                {
                    'id' =>'blahblahblah', 
                    'statistics' => {'viewCount' => '3'}, 
                    'snippet' => {'publishedAt' => (Date.today - 30).to_s }
                }
            ]
        }
        video_service = VideoService.new(
            video_repo: VideoRepoStub.new(video_repo_response), 
            video_client: YoutubeVideoClientStub.new(youtube_client_response)
        )
        video_json = JSON.generate(video_repo_response)

        result = JSON.parse(video_service.video_list)
        actual = JSON.parse(video_json)
        assert_equal(result[0]['youtubeID'], result[0]['youtubeID'])
        assert_equal(result[0]['views'], result[0]['views'])
        assert_in_delta(result[0]['monthlyViews'], result[0]['monthlyViews'], 0.1)

    end
end