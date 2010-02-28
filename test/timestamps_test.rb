require 'test_helper'
require 'mocha'

class TimestampsTest < Test::Unit::TestCase
  context 'The version' do
    setup do
      time = Time.parse("28 Feb, 2010")
      Time.stubs(:now).returns(time)
      
      @current_time = time
      @original_timestamp = time - 1.day
      @user = User.create(:name => 'Steve Richert')
    end

    should 'default to current time' do
      @user.update_attributes(:first_name => 'Stephen')
      assert_equal @current_time, @user.versions.last.created_at
      assert_equal @current_time, @user.versions.last.updated_at
    end

    should 'have timestamps equal to original timestamp' do
      @user.update_attributes(:first_name => 'Stephen', :original_timestamp => @original_timestamp)
      assert_equal @original_timestamp, @user.versions.last.created_at
      assert_equal @original_timestamp, @user.versions.last.updated_at
    end

  end
end
