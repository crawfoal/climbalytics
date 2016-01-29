# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
Rails.application.config.assets.precompile += %w( bootstrap.css )
Rails.application.config.assets.precompile += %w( bootstrap-theme.css )
Rails.application.config.assets.precompile += %w( bootstrap.js )

# Page specific assets
page_assets_folder = Rails.root.join(*%w(app assets stylesheets pages)).to_s
Dir.glob("#{page_assets_folder}/**/*") do |file|
  next unless file['.css'] or file['.scss'] or file['.sass']
  file[page_assets_folder] = 'pages'
  Rails.application.config.assets.precompile += [ file ]
end
