class TasksController < ApplicationController
 def index
   @task = Task.new
   @tasks = Task.order(:priority)
 end

 def create
   @task = Task.new(task_params)
   @task.priority = Task.count
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

 private

 def task_params
   params.require(:task).permit(:description, :completed, :priority)
 end

end
