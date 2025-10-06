Rails.application.config.session_store :cookie_store,
  key: "_happy_feet_session",
  httponly: true,
  secure: Rails.env.production?,
  same_site: :lax
