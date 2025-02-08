# frozen_string_literal: true

class Amadeus::Search::Cities < Amadeus::Search::Base
  # QUERY PARAMETERS
  #
  # hotel_ids - Amadeus unique hotel code. Array
  #
  # adults - 1 - Number of adults
  def call(keyword:, country_code:, options: {})
    options.merge!(keyword:, country_code:).transform_keys! { |key| key.to_s.camelize(:lower) }

    get_request(options:)
  end

  private

  def api_version
    'v1'
  end

  def request_url
    'reference-data/locations/cities'
  end
end
