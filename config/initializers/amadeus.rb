

amadeus = Amadeus::Client.new(client_id: RCreds.fetch(:amadeus, :api_key), client_secret: RCreds.fetch(:amadeus, :api_secret))