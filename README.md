## Meli Proxy
A project aimed at the Challenge suggested by Mercado Livre, where a Proxy must be built to use the free market API with monitoring.

# Quick access
- /monitor -> Follow the monitoring of requests
- /monitor/api -> Monitoring APIs
- /admin -> Tracking and managing custom rules by IP

# Heroku
The application is available on heroku for testing.<br/>
Base URL: https://meli-p.herokuapp.com/  
Monitor: https://meli-p.herokuapp.com/monitor  
Admin: https://meli-p.herokuapp.com/admin  
API: https://meli-p.herokuapp.com/monitor/api/index  
[See API Documentation](documentation/API.md)

# Request Flow

![Alt text](documentation/images/flow.jpg?raw=true "Request Flow")

# Use Models Flow

![Alt text](documentation/images/models.jpg?raw=true "Models")

# SQL Usage in Proxy

## With custom rule
```
Started GET "/docs/duplicate-requests" for ::1 at 2021-07-23 16:36:36 -0300
  LimitIpPath Load (205.1ms)  SELECT `limit_ip_paths`.* FROM `limit_ip_paths` WHERE `limit_ip_paths`.`path` = '/docs/duplicate-requests' AND `limit_ip_paths`.`ip` = '::1' ORDER BY `limit_ip_paths`.`id` ASC LIMIT 1
  ↳ app/proxy/application_service_proxy.rb:111:in `custom_rule'
   (152.6ms)  SELECT COUNT(*) FROM `ip_histories` WHERE `ip_histories`.`ip` = '::1' AND `ip_histories`.`path` = '/docs/duplicate-requests' AND `ip_histories`.`created_at` BETWEEN '2021-07-23 03:00:00' AND '2021-07-23 19:36:37.232956'
  ↳ app/proxy/application_service_proxy.rb:95:in `count_ip_in_path_requests_today'
  CACHE LimitIpPath Load (0.0ms)  SELECT `limit_ip_paths`.* FROM `limit_ip_paths` WHERE `limit_ip_paths`.`path` = '/docs/duplicate-requests' AND `limit_ip_paths`.`ip` = '::1' ORDER BY `limit_ip_paths`.`id` ASC LIMIT 1
  ↳ app/proxy/application_service_proxy.rb:111:in `custom_rule'
  IpHistory Load (244.2ms)  SELECT `ip_histories`.* FROM `ip_histories` WHERE `ip_histories`.`ip` = '::1' AND `ip_histories`.`path` = '/docs/duplicate-requests' AND `ip_histories`.`created_at` BETWEEN '2021-07-23 03:00:00' AND '2021-07-23 19:36:37.394270'
  ↳ app/proxy/application_service_proxy.rb:100:in `filter'
  CACHE LimitIpPath Load (0.0ms)  SELECT `limit_ip_paths`.* FROM `limit_ip_paths` WHERE `limit_ip_paths`.`path` = '/docs/duplicate-requests' AND `limit_ip_paths`.`ip` = '::1' ORDER BY `limit_ip_paths`.`id` ASC LIMIT 1
  ↳ app/proxy/application_service_proxy.rb:111:in `custom_rule'
  TRANSACTION (197.8ms)  BEGIN
  ↳ app/proxy/application_service_proxy.rb:104:in `create_ip_history'
  IpHistory Create (204.9ms)  INSERT INTO `ip_histories` (`ip`, `path`, `created_at`, `updated_at`) VALUES ('::1', '/docs/duplicate-requests', '2021-07-23 19:36:37.644837', '2021-07-23 19:36:37.644837')
  ↳ app/proxy/application_service_proxy.rb:104:in `create_ip_history'
  TRANSACTION (156.0ms)  COMMIT
  ↳ app/proxy/application_service_proxy.rb:104:in `create_ip_history'
```

## Whitout custom rule
```
Started GET "/docs" for ::1 at 2021-07-23 16:32:42 -0300
  LimitIpPath Load (206.9ms)  SELECT `limit_ip_paths`.* FROM `limit_ip_paths` WHERE `limit_ip_paths`.`path` = '/docs' AND `limit_ip_paths`.`ip` = '::1' ORDER BY `limit_ip_paths`.`id` ASC LIMIT 1
  ↳ app/proxy/application_service_proxy.rb:111:in `custom_rule'
  ProxyControl Load (201.7ms)  SELECT `proxy_controls`.* FROM `proxy_controls` ORDER BY `proxy_controls`.`id` ASC LIMIT 1
  ↳ app/proxy/application_service_proxy.rb:127:in `proxy_control'
   (175.7ms)  SELECT COUNT(*) FROM `ip_histories` WHERE `ip_histories`.`path` = '/docs' AND `ip_histories`.`created_at` BETWEEN '2021-07-23 03:00:00' AND '2021-07-23 19:32:44.576601'
  ↳ app/proxy/application_service_proxy.rb:85:in `count_path_requests_today'
  CACHE ProxyControl Load (0.0ms)  SELECT `proxy_controls`.* FROM `proxy_controls` ORDER BY `proxy_controls`.`id` ASC LIMIT 1
  ↳ app/proxy/application_service_proxy.rb:127:in `proxy_control'
  CACHE ProxyControl Load (0.0ms)  SELECT `proxy_controls`.* FROM `proxy_controls` ORDER BY `proxy_controls`.`id` ASC LIMIT 1
  ↳ app/proxy/application_service_proxy.rb:127:in `proxy_control'
  IpHistory Load (156.3ms)  SELECT `ip_histories`.* FROM `ip_histories` WHERE `ip_histories`.`path` = '/docs' AND `ip_histories`.`created_at` BETWEEN '2021-07-23 03:00:00' AND '2021-07-23 19:32:44.761804'
  ↳ app/proxy/application_service_proxy.rb:90:in `filter'
  CACHE ProxyControl Load (0.0ms)  SELECT `proxy_controls`.* FROM `proxy_controls` ORDER BY `proxy_controls`.`id` ASC LIMIT 1
  ↳ app/proxy/application_service_proxy.rb:127:in `proxy_control'
  CACHE ProxyControl Load (0.0ms)  SELECT `proxy_controls`.* FROM `proxy_controls` ORDER BY `proxy_controls`.`id` ASC LIMIT 1
  ↳ app/proxy/application_service_proxy.rb:127:in `proxy_control'
   (153.0ms)  SELECT COUNT(*) FROM `ip_histories` WHERE `ip_histories`.`ip` = '::1' AND `ip_histories`.`created_at` BETWEEN '2021-07-23 03:00:00' AND '2021-07-23 19:32:44.926327'
  ↳ app/proxy/application_service_proxy.rb:80:in `count_ip_requests_today'
  CACHE ProxyControl Load (0.0ms)  SELECT `proxy_controls`.* FROM `proxy_controls` ORDER BY `proxy_controls`.`id` ASC LIMIT 1
  ↳ app/proxy/application_service_proxy.rb:127:in `proxy_control'
  CACHE ProxyControl Load (0.0ms)  SELECT `proxy_controls`.* FROM `proxy_controls` ORDER BY `proxy_controls`.`id` ASC LIMIT 1
  ↳ app/proxy/application_service_proxy.rb:127:in `proxy_control'
  IpHistory Load (195.8ms)  SELECT `ip_histories`.* FROM `ip_histories` WHERE `ip_histories`.`ip` = '::1' AND `ip_histories`.`created_at` BETWEEN '2021-07-23 03:00:00' AND '2021-07-23 19:32:45.090331'
  ↳ app/proxy/application_service_proxy.rb:75:in `filter'
  CACHE ProxyControl Load (0.1ms)  SELECT `proxy_controls`.* FROM `proxy_controls` ORDER BY `proxy_controls`.`id` ASC LIMIT 1
  ↳ app/proxy/application_service_proxy.rb:127:in `proxy_control'
  TRANSACTION (192.1ms)  BEGIN
  ↳ app/proxy/application_service_proxy.rb:104:in `create_ip_history'
  IpHistory Create (203.3ms)  INSERT INTO `ip_histories` (`ip`, `path`, `created_at`, `updated_at`) VALUES ('::1', '/docs', '2021-07-23 19:32:45.297407', '2021-07-23 19:32:45.297407')
  ↳ app/proxy/application_service_proxy.rb:104:in `create_ip_history'
  TRANSACTION (202.0ms)  COMMIT
  ↳ app/proxy/application_service_proxy.rb:104:in `create_ip_history'

```

# Dependencies
- rack-proxy (https://github.com/ncr/rack-proxy) To rewrite the request and create the "Proxy"
- Bootstrap 5 In Front-end
- Chartkick (https://chartkick.com) In monitoring charts
- Groupdate (https://github.com/ankane/groupdate) In monitoring charts
- Kaminari (https://github.com/kaminari/kaminari) For pagination