module MonitorHelper

  def path_request_rank
    @path_request_rank ||= IpHistory.group('path').order('count(path) DESC').limit(10).select('path').count
  end
end
