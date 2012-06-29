require File.dirname(__FILE__) + '/spec_helper.rb'

describe Cost do
  it "should add a cost record" do
    cost_records_before = Cost.all.length
    cost_record = Cost.compute_cost(INSTANCE_ID, REGION, INSTANCE_FLAVOR, RUN_ID)
    cost_records_after =  Cost.all.length
    value = cost_records_after - cost_records_before == 1
    value.should be_true
  end
end
