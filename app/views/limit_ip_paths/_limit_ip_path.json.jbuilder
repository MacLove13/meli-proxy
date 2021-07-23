json.extract! limit_ip_path, :id, :ip, :path, :max_requests_hour, :max_requests_day, :created_at, :updated_at
json.url limit_ip_path_url(limit_ip_path, format: :json)
