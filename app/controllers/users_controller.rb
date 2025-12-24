class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user

    # 表示する年（指定がなければ今年）
    @year = params[:year]&.to_i || Date.current.year

    all_sessions = @user.surf_sessions

    # 全期間
    @total_days = all_sessions.count
    @total_minutes = all_sessions.sum(:duration_minutes).to_i
    @total_hours = (@total_minutes / 60.0).round(1)

    # 指定年
    year_range = Date.new(@year, 1, 1)..Date.new(@year, 12, 31)
    year_sessions = all_sessions.where(session_date: year_range)

    @year_days = year_sessions.count
    @year_minutes = year_sessions.sum(:duration_minutes).to_i
    @year_hours = (@year_minutes / 60.0).round(1)

    # 前年 / 次年（切替用）
    @prev_year = @year - 1
    @next_year = @year + 1

    # 前年データ
    prev_range = Date.new(@prev_year, 1, 1)..Date.new(@prev_year, 12, 31)
    prev_sessions = all_sessions.where(session_date: prev_range)
    @prev_year_days = prev_sessions.count
    @prev_year_hours = (prev_sessions.sum(:duration_minutes).to_i / 60.0).round(1)

    # 差分（今年 - 前年）
    @diff_days = @year_days - @prev_year_days
    @diff_hours = (@year_hours - @prev_year_hours).round(1)


    # 次年データ
    next_range = Date.new(@next_year, 1, 1)..Date.new(@next_year, 12, 31)
    next_sessions = all_sessions.where(session_date: next_range)
    @next_year_days = next_sessions.count
    @next_year_hours = (next_sessions.sum(:duration_minutes).to_i / 60.0).round(1)

    # 指定年の最大連続サーフ日数（max streak）
    dates = year_sessions.order(:session_date).pluck(:session_date).uniq

    max_streak = 0
    current_streak = 0

    dates.each_with_index do |d, i|
      if i == 0 || d == dates[i - 1] + 1
        current_streak += 1
      else
        current_streak = 1
      end
      max_streak = [max_streak, current_streak].max
    end

    @max_streak_days = max_streak

    # 指定年のベスト波サイズ
    @best_wave_size_year =
      year_sessions
        .where.not(wave_size: [nil, ""])
        .group(:wave_size)
        .order(Arel.sql("COUNT(*) DESC"))
        .count
        .first
        &.first
  end
  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to mypage_path, notice: "プロフィールを更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :bio, :avatar, :cover_image)
  end
end
