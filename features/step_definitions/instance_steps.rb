Given /^the Background Job does not exist$/ do
  if !Delayed::Job.all.blank?
    Delayed::Job.all.each do |job|
      job.delete
    end
  end
end

Given /^the Background Job exist$/ do
  
  if Delayed::Job.all.blank?
    Delayed::Job.enqueue(BackgroundJob.new(), 0, 60.minutes.from_now)
  end
end

Then /^the Backgroud job shuld be scheduled to run in an hour$/ do
  diff =  (Delayed::Job.all.last.run_at - Time.now)/60
  raise "Delayed job scheduled after #{diff.ceil} mins" if  diff.ceil != 60
end

Given /^there are run and utilization records$/ do
  Run.connect if Run.all.blank? || Utilization.all.blank?
end

