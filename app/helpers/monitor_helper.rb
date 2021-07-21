module MonitorHelper

  def path_request_rank
    byebug
    @path_request_rank ||= IpHistory.group('path').order('count(path) DESC').select('path').count
  end
end
