require File.dirname(__FILE__) + '/spec_helper.rb'

describe Run do

  it "shoud return false for blank instance_id " do
    test_result = Run.add("", REGION, INSTANCE_STATE, INSTANCE_FLAVOR, START_TIME, STOP_TIME)
    test_result.should be_false
  end
  
  it "should return true if there is change in tags" do
    run_record = Run.new(:instance_id => INSTANCE_ID, :region => REGION, :instance_state => INSTANCE_STATE, :instance_flavor => INSTANCE_FLAVOR, :start_time => START_TIME, :stop_time => STOP_TIME)
    value = Run.check_for_change_in_tags(run_record)
    value.should be_true
  end

  it "should return true if both objects are same" do
    run_record_1 = Run.new(:instance_id => INSTANCE_ID, :region => REGION, :instance_state => INSTANCE_STATE, :instance_flavor => INSTANCE_FLAVOR, :start_time => START_TIME, :stop_time => STOP_TIME)
    run_record_2 = Run.new(:instance_id => INSTANCE_ID, :region => REGION, :instance_state => INSTANCE_STATE, :instance_flavor => INSTANCE_FLAVOR, :start_time => START_TIME, :stop_time => STOP_TIME)
    value = run_record_1 == run_record_2
    value.should be_true
  end
  
end
