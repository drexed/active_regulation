%w(version activation containment expiration quarantine suspension visibility).each do |file_name|
  require "active_regulation/#{file_name}"
end
