CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',                        # required
    :aws_access_key_id      => Figaro.env.aws_access_key_id,                        # required
    :aws_secret_access_key  => Figaro.env.aws_secret_access_key,                        # required
    :region                 => 'eu-west-1'                   # optional, defaults to 'us-east-1'
  }
  config.fog_directory  = Figaro.env.aws_directory                     # required
  # config.fog_public     = false                                   # optional, defaults to true
  # config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
end
