require 'minitest/autorun'
require './youtube_video_list'
require 'json'

class VideoServiceTest < MiniTest::Test
    
    def test_video_list_returns_video_list
        video_service = VideoService.new
        video_array = [{'youtubeId': 'blahblahblah', 'views': 3, 'monthlyViews': 1}]
        video_json = JSON.generate(video_array)
        video_service.stub(:get_current_video_list, video_array) do
            assert_equal(video_service.video_list, video_json)
        end
    end
    
end