# API available

# /monitor/api/index
Request monitoring<br/>
<br/>
Response example:

```
{
  "header": {
    "page": 1,
    "limit_value": 25,
    "total_pages": 6,
    "total_count": 135
  },
  "data": [
    {
      "id": 1,
      "ip": "::1",
      "path": "/2.2/questions",
      "created_at": "2021-07-21T01:49:24.163Z",
      "updated_at": "2021-07-21T01:49:24.163Z"
    },
    {
      "id": 2,
      "ip": "::1",
      "path": "/2.2/questions",
      "created_at": "2021-07-21T01:50:43.419Z",
      "updated_at": "2021-07-21T01:50:43.419Z"
    },
  ]
}
```

<br/>
Filters:<br/>

```
page=1                #=> Actual page
limit_value=25        #=> Itens per page
start_at=2021-01-01   #=> Pick up items that have a creation date greater than or equal to
end_at=2022-01-01     #=> Pick up items that are up to this creation date
ip=127.0.0.1          #=> Filter by ip
path=/docs            #=> Filter by path
```
