CarrierWave.configure do |config|

  require 'carrierwave/orm/activerecord'

  config.ignore_integrity_errors = false
  config.ignore_processing_errors = false
  config.ignore_download_errors = false


  if Rails.env.test? || Rails.env.cucumber?
    config.storage = :file
    config.enable_processing = false
    config.root = "#{Rails.root}/tmp"
  else
    config.storage = :fog
  end

  config.cache_dir = "#{Rails.root}/tmp/uploads"                  # To let CarrierWave work on heroku

end
