Rails.application.config.session_store :cookie_store,
  key: "happy_feet_music_festival",
  httponly: true,
  secure: Rails.env.production?,
  same_site: :lax
