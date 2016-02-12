CarrierWave.configure do |config|
  if Rails.env.test?
    config.enable_processing = false
  end
end
