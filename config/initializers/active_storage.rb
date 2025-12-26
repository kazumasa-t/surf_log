Rails.application.config.after_initialize do
  if Rails.env.production?
    Rails.application.config.active_storage.service = :cloudflare_r2
  end
end
