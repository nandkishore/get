class Tag < ActiveRecord::Base
  belongs_to :run

  class << self
    def add(run_id, key, value)
                                       ## Saves User defined Tags for each Runrecord
      return false if run_id.blank? 
      tag = Tag.new(:run_id => run_id, :key => key, :value => value)
      tag.save!
    end
  end
end
