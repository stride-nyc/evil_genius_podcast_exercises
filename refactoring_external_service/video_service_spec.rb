require 'minitest/autorun'
require './video_service'
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
        assert_equal(expected[0]['monthlyViews'], actual[0]['monthlyViews'])
    end

    def test_when_less_than_thirty_days_have_passed
        video_repo_response = [{'youtubeID' => 'blahblahblah', 'views' => 0, 'monthlyViews' => 0}]
        youtube_client_response =  {'items' => 
            [
                {
                    'id' =>'blahblahblah', 
                    'statistics' => {'viewCount' => '3'}, 
                    'snippet' => {'publishedAt' => (Date.today - 29).to_s }
                }
            ]
        }
        video_service = VideoService.new(
            video_repo: VideoRepoStub.new(video_repo_response), 
            video_client: YoutubeVideoClientStub.new(youtube_client_response)
        )
        actual = JSON.parse(video_service.video_list)
        assert_equal(3, actual[0]['views'])
        # I'm making an assumption here that when the video has been out less than 30 days, 
        # the monthlyViews should be just the total views
        assert_equal(3, actual[0]['monthlyViews'])
    end

    def test_when_sixty_days_have_passed_since_publishing
        video_repo_response = [{'youtubeID' => 'blahblahblah', 'views' => 0, 'monthlyViews' => 0}]
        youtube_client_response =  {'items' => 
            [
                {
                    'id' =>'blahblahblah', 
                    'statistics' => {'viewCount' => '10'}, 
                    'snippet' => {'publishedAt' => (Date.today - 60).to_s }
                }
            ]
        }
        video_service = VideoService.new(
            video_repo: VideoRepoStub.new(video_repo_response), 
            video_client: YoutubeVideoClientStub.new(youtube_client_response)
        )
        actual = JSON.parse(video_service.video_list)
        assert_equal(10, actual[0]['views'], 'Total Views')
        # I'm making another assumption here that fractional views don't really count for anything
        # So monthly views should always be integers. 
        assert_equal(5, actual[0]['monthlyViews'], 'Monthly Views')
    end
end