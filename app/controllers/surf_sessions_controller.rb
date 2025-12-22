class SurfSessionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @surf_sessions = current_user.surf_sessions.order(session_date: :desc)
    @sessions_by_date = @surf_sessions.group_by(&:session_date)
  end


  def new
    attrs = surf_session_params
    date = attrs[:session_date]

    if date.present?
      existing = current_user.surf_sessions.find_by(session_date: date)
      return redirect_to edit_surf_session_path(existing) if existing
    end

    @surf_session = current_user.surf_sessions.new(attrs)
  end



  def create
    date = surf_session_params[:session_date]

    if date.present?
      existing = current_user.surf_sessions.find_by(session_date: date)
      return redirect_to edit_surf_session_path(existing), notice: "その日の記録は既にあります。編集してください。" if existing
    end

    @surf_session = current_user.surf_sessions.new(surf_session_params)
    if @surf_session.save
      redirect_to root_path, notice: "記録を追加しました"
    else
      render :new, status: :unprocessable_entity
    end
  end


  def edit
    @surf_session = current_user.surf_sessions.find(params[:id])
  end

  def update
    @surf_session = current_user.surf_sessions.find(params[:id])
    if @surf_session.update(surf_session_params)
      redirect_to root_path, notice: "更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end


  private

  def surf_session_params
    params.require(:surf_session).permit(:session_date, :duration_minutes, :note, :photo)
  end
end
