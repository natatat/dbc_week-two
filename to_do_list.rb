require 'csv'
 
class List # **MODEL**
  attr_reader :array_of_task_strings
 
  def initialize
    @array_of_task_strings = []
    create_list
    instantiate_rows_into_tasks
  end
 
  def create_list
    CSV.foreach('todo.csv') {|row| array_of_task_strings << row }
  end
 
  def instantiate_rows_into_tasks
    @array_of_Task_objects = array_of_task_strings.map { |row| Task.new(row).text }
  end
 
  def push_to_csv!
    CSV.open("todo.csv", "wb") do |csv|
      @array_of_Task_objects.each {|task| csv << task}
    end
  end
 
  def add!(comment_body)
    @array_of_Task_objects << [Task.new(comment_body.join(" ")).text]
    push_to_csv!
  end
 
  def delete!(comment_info)
    puts "Now deleting Task Number #{comment_info}"
    deleted_task = @array_of_Task_objects.delete_at(comment_info[0].to_i-1)
    puts "#{deleted_task} is now deleted"
    push_to_csv!
  end
 
  def list
    print_current_list = []
    @array_of_Task_objects.each_with_index {|task, index| print_current_list << "Task Number #{index}: #{task}"}
    print_current_list
  end
 
end
 
class View
  class << self
    def render(information_for_screen)
      puts information_for_screen
    end
  end
end
 
#attr_reader possibility
class Task
  attr_reader :text
  
  def initialize(text)
    @text = text
  end
end
 
 
#holder for all of our driver code
#ideally just one line for driver code at the end of this shit
class Controller
 
  def initialize(method, comment_info)
    @current_to_do_list = List.new
    @method = method
    @comment_info = comment_info
    decider
  end
 
  def decider
    case @method
      when "add"
        View.render(@current_to_do_list.add!(@comment_info))
      when "delete"
        View.render(@current_to_do_list.delete!(@comment_info))
      when "list"
        View.render(@current_to_do_list.list)
    end
  end
 
  def write_onto_csv
    current_to_do_list.push_to_csv!
  end
end
 
body_of_task = ARGV  
method_to_use = body_of_task.shift
Controller.new(method_to_use, body_of_task)