class ShareLinksController < ApplicationController
  def show
    @share_link = ShareLink.find_by(token: params[:token])
    return unless @share_link

    # 共有元ユーザー
    @user = @share_link.user

    # 対象月
    @base_date = @share_link.month

    month_range =
      @base_date.beginning_of_month..@base_date.end_of_month

    # 日付ごとのセッション
    @sessions_by_date =
      @user.surf_sessions
           .where(session_date: month_range)
           .group_by(&:session_date)

    # 月間集計
    month_sessions =
      @user.surf_sessions.where(session_date: month_range)

    total_minutes = month_sessions.sum(:duration_minutes).to_i
    @total_hours = (total_minutes / 60.0).round(1)
    @total_days = month_sessions.count
  end
end
