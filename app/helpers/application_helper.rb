module ApplicationHelper
  def share_url_for_current_month
    return "#" unless user_signed_in?

    month = Date.current.beginning_of_month

    share_link =
      current_user.share_links.find_or_create_by!(month: month)

    share_url(share_link.token)
  end
end
