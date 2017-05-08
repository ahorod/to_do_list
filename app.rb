require('sinatra')
require('sinatra/reloader')
require("sinatra/activerecord")
require('./lib/task')
require('./lib/list')
require('pry')
require('pg')
also_reload('lib/**/*.rb')

get('/') do
  @tasks = Task.all()
  # @tasks_not_done = @tasks.not_done()
  @lists = List.all()
  erb(:index)
end

get('/tasks/:id/edit') do
  @task = Task.find(params.fetch("id").to_i())
  erb(:task)
end

patch("/tasks/:id") do
  description = params.fetch("description")
  @task = Task.find(params.fetch("id").to_i())
  @task.update({:description => description})
  @tasks = Task.all()
  @lists = List.all()
  erb(:index)
end

post("/tasks") do
  description = params.fetch("description")
  list_id = params.fetch("list_id").to_i()
  @list = List.find(list_id)
  @task = Task.new({:description => description, :list_id => list_id})
  @task.save()
  erb(:list)
end

post('/lists') do
  name = params[:name]
  new_list = List.create({:name => name})
  @lists = List.all()
  @tasks = Task.all()
  erb(:index)
end

get('/lists/:id') do
  @list = List.find(params[:id].to_i())
  @tasks = Task.all()
  erb(:list)
end
