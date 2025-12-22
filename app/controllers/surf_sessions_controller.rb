class SurfSessionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @surf_sessions = current_user.surf_sessions.order(session_date: :desc)
    @sessions_by_date = @surf_sessions.group_by(&:session_date)
  end


  def new
    @surf_session = current_user.surf_sessions.new(surf_session_params)
  end


  def create
    @surf_session = current_user.surf_sessions.new(surf_session_params)
    if @surf_session.save
      redirect_to surf_sessions_path, notice: "記録を追加しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def surf_session_params
    params.require(:surf_session).permit(:session_date, :duration_minutes, :note, :photo)
  end
end
