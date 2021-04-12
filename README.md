Всем привет!

Это мой первый проект на Ruby + Sinatra, представляет собой сайт дистанционного обучения для профессиональнго колледжа (подойдет также для школы или небольшого ВУЗа). Без баз данных, без настройки, без сложных манипуляций. Все, что вам надо: хостинг, поддерживающий Ruby и установленная библиотека Sinatra. Для совсем бюджетного варианта можно запустить проект на стационарном компьютере с адресом 127.0.0.1:4567, а потом расшарить его в сеть с помощью сервиса https://ngrok.com, получится страшный по имени, но совершенно бесплатный сайт.

На странице администратора (логин=admin, пароль=password) можно править список групп (его нельзя делать пустым), список преподавателей (в формате "Фамилия Пароль" через пробел, для каждого человека своя строка), а также список заданий (формат "Преподаватель|Группа|Дисциплина|Задание"). В заданиях можно указывать ссылки, но они не будут "кликаться", их отображение будет текстом. К заданиям нельзя прикреплять файлы, для этого рекомендую использовать файлообменник https://wdfiles.ru, на котором файлы хранятся месяц.

Сайт можно развернуть за час и использовать целый год. В начале нового учебного года рекомендуется очистить файл с заданиями data.txt, а также подправить файлы groups.txt и prepods.txt

Запуск на домашнем компьютере:
>ruby app.rb

Если не установлена библиотека Sinatra, то сначала:
>gem install sinatra

Удачи!

P.S. Тестовые испытания показали, что данный проект не получится использовать на Heroku, так как там нет локального сохранения текстовых файлов. Сайт заработает, но постоянно будет сбрасываться к первоначальным состояним трех файлов с информацией. Это печально.
