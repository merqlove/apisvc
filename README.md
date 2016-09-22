## ApiSvc Ruby Backend

### Dependencies:

- Ruby 2.3+
- Rails 5.0
- PostgreSQL
- Memcached
- Puma

### Setup

        # Install gems
        $ bundle install

        # Setup DB
        $ make migrate

        # Seed into DB
        $ make seed
        
        # Run project!
        $ bin/rails s     
                    

#### Few words about:
- This project is a little API app.

### Написать сервис с API.
Сервис должен иметь один endpoint и предоставлять возможность версионирования (версия указывается в header'e запроса).
Url endpoint'a - '/data'.

#### Post запрос:
Обязательный параметр - type.  
Может принимать два значения: 
- 'time'
- 'location'.

##### Если параметр 'time', 
обязательный параметр: 

- 'value' (datetime)
    который может принимать значения в формате:
    - 'hour:minutes day.month' (19:25 13.11)
    - 'end' (конец текущего дня 23:59)
    - 'beginning' (начало текущего дня 00:00)

##### В случае 'location', 
обязательны три параметра: 

- 'latitude' (double, 4 зн после точки)
- 'longitude' (double)
- 'name' (string) 
- необязательный 'timezone' (вида '-04:00')

Полученные данные сохраняются в бд.
Время отдельно, локации отдельно.

Get запрос:
Единственный query параметр 'timezone' должен указывать на 'name' одного из хранимых 'location'.
Endpoint должен возвращать список хранимых 'time' для указанной timezone.
В случае отсутствия query параметра, либо пустого поля 'timezone' для указанного 'location', возвращать в utc.
Использовать JSON API формат ответов. Добавить ошибки по своему усмотрению. Покрыть код тестами. Указать используемую database и web server.
Сервис должен быть рассчитан на средне-высокую нагрузку.

- All JSON data works via AMS.

Copyright (c) 2016 Alexander Merkulov

MIT License
