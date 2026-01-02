module ApplicationHelper
  # 表示中の月を指定して共有URLを生成する
  #
  # month_date:
  #   - Date / Time / ActiveSupport::TimeWithZone
  #   - 例: base_date, Date.current など
  #
  def share_url_for_month(month_date)
    return "#" unless user_signed_in?

    # 念のため月初日に正規化
    month = month_date.to_date.beginning_of_month

    share_link =
      current_user.share_links.find_or_create_by!(month: month)

    share_url(share_link.token)
  end
end
