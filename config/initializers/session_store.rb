# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_gametheorygame_session',
  :secret      => '30195fbea8a3d98561d41ab41fec6f7949659605953aa3789fc25ec45cfde101dd62c77f65a638f9e1bbaec3f14a4c98201084f1069c7982ea88bea5168094ff'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
