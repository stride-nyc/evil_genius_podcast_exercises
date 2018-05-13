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
    
    def test_when_views_unchanged_for_one_month
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

        actual = JSON.parse(video_service.video_list)
        expected = video_repo_response
        assert_equal(expected[0]['youtubeID'], actual[0]['youtubeID'])
        assert_equal(expected[0]['views'], actual[0]['views'])
        assert_in_delta(expected[0]['monthlyViews'], actual[0]['monthlyViews'], 0.1)
    end

end