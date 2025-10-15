Rails.application.config.session_store :cookie_store,
                                       key: '_music_festival_session',
                                       httponly: true,
                                       secure: Rails.env.production?,
                                       same_site: :lax
