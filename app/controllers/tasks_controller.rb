class TasksController < ApplicationController
 def index
   @task = Task.new
   @tasks = Task.order(:priority)
 end

 def create
   @task = Task.new(task_params)
   @task.priority = Task.count
   @task.completed = false
   if @task.save
     redirect_to root_path, notice: "Task successfully created."
   else
     render :index
   end
 end

 def update
   @task = Task.find(params[:id])
   if params[:completed]

     @task.update(completed: true)
     redirect_to root_path
   else
     @task.completed = false
     redirect_to root_path
   end
 end

 def add_priority
   @task = Task.find(params[:id])
   current_priority = @task.priority
   if @task.priority != 0
     previous_task = Task.find_by!(priority: current_priority - 1)
     @task.priority = previous_task.priority
     @task.save
     previous_task.priority = current_priority
     previous_task.save
     redirect_to root_path
   else
     redirect_to root_path
   end
 end

 def subtract_priority
   @task = Task.find(params[:id])
   current_priority = @task.priority
   if @task.priority != Task.count - 1
     previous_task = Task.find_by!(priority: current_priority + 1)
     @task.priority = previous_task.priority
     @task.save
     previous_task.priority = current_priority
     previous_task.save
     redirect_to root_path
   else
     redirect_to root_path
   end
 end
 private

 def task_params
   params.require(:task).permit(:description, :completed, :priority)
 end

end
