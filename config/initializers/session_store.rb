# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_innowhite_gem_session',
  :secret      => '9f58abf56eed422cd836e09b3410ddd038bff4e3c1ce739435ba478ab9bfedcbd98071b6540f0a6cbbbee599f106ca30a94fd150d0a274c97fd9c2023757c2a2'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
