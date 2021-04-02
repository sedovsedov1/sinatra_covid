require 'sinatra'

# Обработка первого захода пользователя
# 1) Считываем содержание файла groups.txt (группы)
# 2) Вызываем вьюху index.erb (она выводит список групп)

get '/' do
	@file = File.open("./groups.txt", "r")
	erb :index
end

# Обработка post-захода пользователя (авторизация преподавателя)
# 1) Считываем содержимое файла groups.txt (группы)
# 2) Получаем логин, пароль
# 3) Считываем содержимое файла prepods.txt (пароли преподавателей)
# 4) Проходим по строкам файла prepods.txt, обрезая \n
# 5) Если присланные логин, пароль == хотя бы одной строке из файла, @enter=1
# 6) Вызываем вьюху index.erb (она выводит преподавателя + список групп)

post '/' do
	@file = File.open("./groups.txt", "r")
	@login = params['login']
	@password = params['password']
	@file1 = File.open("./prepods.txt", "r")
	@file1.each_line do |line|
		line = line.chomp
		log, pas = line.split(' ')
		if @login == log && @password == pas
			@enter = 1
		end
	end
	erb :index
end

# Обработка входа администратора
# 1) Выводим вьюху admin.erb (там только авторизация)

get '/admin' do
	erb :admin
end

# Обработка post-захода администратора
# 1) Получаем логин, пароль
# 2) Если логин, пароль == заданным, то выводим вьюху admin1.erb
# 2) Если логин, пароль != заданным, то выводим вьюху admin.erb (еще раз) 

post '/admin' do
	@login = params['login']
	@password = params['password']
	if @login == 'admin' && @password == 'p@ssw0rd'
		erb :admin1
	else
		erb :admin
	end
end

# Обработка post-захода администратора (изменение файлов сайта)
# 1) Перезаписываем файл groups.txt
# 2) Перезаписываем файл prepods.txt
# 3) Перезаписываем файл data.txt
# 4) Переходим на главную страницу

post '/admin1' do
	f1 = File.open("./groups.txt", "w")
	f1.write "#{params['groups']}"
	f1.close
	f2 = File.open("./prepods.txt", "w")
	f2.write "#{params['prepods']}"
	f2.close
	f3 = File.open("./data.txt", "w")
	f3.write "#{params['data']}"
	f3.close
	redirect '/'
end

# Обработка выборки преподавателя /имя/группа
# 1) Получаем имя преподавателя (логин) и номер группы
# 2) Вызываем вьюху prepods.erb (там он добавляет задания)

get '/prepods/:name/:number' do
	@name = params['name']
	@grp = params['number']
	erb :prepods
end

# Обработка post-выборки преподавателя /имя/группа
# 1) Получаем имя, группу, дисциплину, задание по ней
# 2) Открываем на дозапись файл data.txt (задания для студентов)
# 3) Делаем запись формата: имя|группа|дисциплина|задание\n
# 4) Закрываем файл
# 5) Вызываем вьюху prepods.erb (там он добавляет задания)

post '/prepods/:name/:number' do
	@name = params['name']
	@grp = params['number']
	@text1 = params['text1']
	@text2 = params['text2']
	f = File.open('data.txt', 'a')
	f.write "#{@name}|#{@grp}|#{@text1}|#{@text2}\n"
	f.close 
	erb :prepods
end

# Обработка простого входа студента, котоырй выбрал номер группы
# 1) Считываем номер группы, которую он выбрал
# 2) Вызываем вьюху students.erb (там простой вывод заданий для выбранной группы)

get '/groups/:number' do
	@grp = params['number']
	erb :students
end