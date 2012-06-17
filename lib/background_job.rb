class BackgroundJob
  
  def perform
    Run.connect
  end
end
