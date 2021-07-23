class ApplicationServiceProxy < Rack::Proxy
  def perform_request(env)
    @request = Rack::Request.new(env)

    return @app.call(env) if @request.path =~ %r{^/monitor} || @request.path =~ %r{^/assets} || @request.path =~ %r{^/admin}

    if custom_rule.present?
      return request_limit_exceeded(env) if count_ip_in_path_requests_today > custom_rule.max_requests_day
      return request_limit_exceeded(env) if ip_in_path_requests_in_last_hour > custom_rule.max_requests_hour
    else
      path_exceded_limit = check_path_exceded_request_limits
      exceded_limit = check_exceded_request_limits unless path_exceded_limit

      return request_limit_exceeded(env) if exceded_limit || path_exceded_limit
    end

    api = URI(ENV['SERVICE_URL'])

    env["HTTP_HOST"] = api.host

    # This is the only path that needs to be set currently on Rails 5 & greater
    env['PATH_INFO'] = @request.path

    # don't send your sites cookies to target service, unless it is a trusted internal service that can parse all your cookies
    env['HTTP_COOKIE'] = ''

    create_ip_history

    super(env)
  end

  def request_limit_exceeded(env)
    env['PATH_INFO'] = '/proxy/show'
    env['ERROR_INFO'] = 'You have exceeded the request limit.'
    @app.call(env)
  end

  private

  def check_exceded_request_limits
    exceded = false

    if proxy_control.max_ip_requests_day > 0
      requests = count_ip_requests_today
      exceded = true if requests > proxy_control.max_ip_requests_day
    end

    if proxy_control.max_ip_requests_hour > 0 && !exceded
      requests = count_ip_requests_in_last_hour
      exceded = true if requests > proxy_control.max_ip_requests_hour
    end

    exceded
  end

  def check_path_exceded_request_limits
    exceded = false

    if proxy_control.max_path_requests_day > 0
      requests = count_path_requests_today

      exceded = true if requests > proxy_control.max_path_requests_day
    end
    
    if proxy_control.max_path_requests_hour > 0 && !exceded
      requests = count_path_requests_in_last_hour
      exceded = true if requests > proxy_control.max_path_requests_hour
    end

    exceded
  end

  def count_ip_requests_in_last_hour
    return 0 unless ip_history
    ip_history.filter{ |history| history.created_at >= Time.now - 1.hour }.size
  end

  def count_ip_requests_today
    return 0 unless ip_history
    ip_history.count
  end

  def count_path_requests_today
    return 0 unless path_history
    path_history.count
  end

  def count_path_requests_in_last_hour
    return 0 unless path_history
    path_history.filter{ |history| history.created_at >= Time.now - 1.hour }.size
  end

  def count_ip_in_path_requests_today
    return 0 unless ip_in_path_custom_rule
    ip_in_path_custom_rule.count
  end

  def ip_in_path_requests_in_last_hour
    return 0 unless ip_in_path_custom_rule
    ip_in_path_custom_rule.filter{ |history| history.created_at >= Time.now - 1.hour }.size
  end

  def create_ip_history
    IpHistory.create(
      ip: @request.ip,
      path: @request.path
    )
  end

  def custom_rule
    LimitIpPath.where(path: @request.path, ip: @request.ip)&.first
  end

  def ip_in_path_custom_rule
    IpHistory.where(ip: @request.ip, path: @request.path, created_at: Time.now.beginning_of_day..Time.now)
  end

  def path_history
    IpHistory.where(path: @request.path, created_at: Time.now.beginning_of_day..Time.now)
  end

  def ip_history
    IpHistory.where(ip: @request.ip, created_at: Time.now.beginning_of_day..Time.now)
  end

  def proxy_control
    ProxyControl.first
  end
end
