class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find(params[:id]) #GET
  end

  def new
    @task = Task.new #GET
  end

  def create #POST
    @task = Task.new(task_params)

    if @task.save
      flash[:success] = 'Task が正常に投稿されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Task が投稿されませんでした'
      render :new
    end
  end

  def edit #GET 操作＝show＋edit
    @task = Task.find(params[:id])
  end

  def update #アクセスがPUT
    @task = Task.find(params[:id])
    
    if @task.update(task_params)
      flash[:sucsess] = "Taskは正常に更新されました"
      redirect_to @task
    else
      flash.now[:danger] = "Taskは更新されませんでした"
      render :edit
    end
  end

  def destroy #DELETE 特定のタスク削除 操作=show+delete
    @task = Task.find(params[:id])
    @task.destroy
    
    flash[:success] = "Taskは正常に削除されました"
    redirect_to tasks_url
  end
  
  private

  def correct_user
    @tasklist = current_user.tasklists.find_by(id: params[:id])
    unless @tasklist
      redirect_to root_url
    end
  end

  # Strong Parameter
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
end
