class Task
  attr_reader(:description, :list_id )

  define_method(:initialize) do |attributes|
    @description = attributes.fetch(:description)
    @list_id = attributes.fetch(:list_id)
  end

  define_singleton_method(:all) do
    returned_tasks = DB.exec("SELECT * FROM tasks;")
    tasks = []
    returned_tasks.each() do |task|
      description = task.fetch("description")
      list_id = task.fetch("list_id").to_i()
      tasks.push(Task.new({:description => description, :list_id => list_id}))
    end
    tasks
  end

  define_method(:save) do
    DB.exec("INSERT INTO tasks (description, list_id) VALUES ('#{@description}', #{@list_id});")
  end

  define_method(:==) do |another_task|
    self.description().==(another_task.description())
  end
end



# test_task = Task.new({description => "drink coffee", id => nil})
#
# define_method(:initialize) do |attributes|
#   @description = attributes.fetch(:description)
# end
#
# --
#
# test_task = Task.new("drink coffee", nil)
#
# define_method(:initialize) do |a, b|
#   @description = a
#   @id = b
# end
