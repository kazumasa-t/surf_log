class SurfSessionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @surf_sessions = current_user.surf_sessions.order(session_date: :desc)
    @sessions_by_date = @surf_sessions.group_by(&:session_date)
    @best_session_id = @surf_sessions.max_by { |s| s.duration_minutes.to_i }&.id

    dates = current_user.surf_sessions
      .where(session_date: ..Date.current)
      .pluck(:session_date)
      .uniq
      .sort
      .reverse

    @streak_days = 0
    dates.each_with_index do |date, i|
      expected = Date.current - i
      break unless date == expected
      @streak_days += 1
    end
  end

  def new
    attrs = surf_session_params
    date = attrs[:session_date]

    if date.present?
      existing = current_user.surf_sessions.find_by(session_date: date)
      return redirect_to edit_surf_session_path(existing) if existing
    end

    @surf_session = current_user.surf_sessions.new(attrs)
    @points = Point.order(:name)
  end

  def create
    date = surf_session_params[:session_date]

    if date.present?
      existing = current_user.surf_sessions.find_by(session_date: date)
      return redirect_to edit_surf_session_path(existing), notice: "その日の記録は既にあります。編集してください。" if existing
    end

    @surf_session = current_user.surf_sessions.new(surf_session_params)

    if params[:surf_session][:photo].present?
      result = Cloudinary::Uploader.upload(
        params[:surf_session][:photo].path,
        folder: "surf_sessions"
      )
      @surf_session.photo_url = result["secure_url"]
    end

    if @surf_session.save
      redirect_to root_path, notice: "記録を追加しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @surf_session = current_user.surf_sessions.find(params[:id])
    @points = Point.order(:name)
  end

  def update
    @surf_session = current_user.surf_sessions.find(params[:id])

    if params[:surf_session][:photo].present?
      result = Cloudinary::Uploader.upload(
        params[:surf_session][:photo].path,
        folder: "surf_sessions"
      )
      @surf_session.photo_url = result["secure_url"]
    end

    if @surf_session.update(surf_session_params)
      redirect_to root_path, notice: "更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    surf_session = current_user.surf_sessions.find(params[:id])
    surf_session.destroy
    redirect_to root_path, notice: "記録を削除しました"
  end

  private

  def surf_session_params
    params.require(:surf_session).permit(
      :session_date,
      :wave_size,
      :duration_minutes,
      :note,
      :point_id
    )
  end
end
