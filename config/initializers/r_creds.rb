# frozen_string_literal: true

require 'r_creds'

RCreds.config do |c|
  c.environment_first = true
  # c.allow_nil_value   = boolean # default: true
end
