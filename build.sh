#!/usr/bin/env bash	
# exit on error	
set -o errexit	
	
# Fetch dependencies for production
mix deps.get --only prod

# Compile application
MIX_ENV=prod mix compile	
	
# Compile assets	
npm install --prefix ./assets	
npm run deploy --prefix ./assets	
mix phx.digest	

# Build the release and overwrite the existing release directory	
MIX_ENV=prod mix release --overwrite	

# Run the migrations
_build/prod/rel/chirp/bin/chirp eval "Chirp.Release.migrate"
