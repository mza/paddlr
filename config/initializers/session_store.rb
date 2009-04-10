# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_dw_session',
  :secret      => 'bb796a84cc204ef9466988a302d5f51ad0ba314ac518be012994dfe3ad1cbb5166685c743449e6909cff078ee9baa9dfa7103252b95ed18b6c5d6faf80de2370'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
