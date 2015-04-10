require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'rinruby'
require 'matrix'
require 'csv' 

# If you have a Gemfile, require the gems listed there, including any gems
# you've limited to :test, :development, or :production.
#Bundler.require(:default, Rails.env) if defined?(Bundler)
#below stuff added lator

if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  #Bundler.require(*Rails.groups(:assets => %w(development test)))
  # If you want your assets lazily compiled in production, use this line
  #Bundler.require(:default, :assets, Rails.env)
  # Require the gems listed in Gemfile, including any gems
  # you've limited to :test, :development, or :production.
  Bundler.require(:default, Rails.env)
end

module Bioaqua1
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]
    #config.force_ssl = true

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # JavaScript files you want as :defaults (application.js is always included).
    #config.action_view.javascript_expansions[:defaults] = %w(jquery rails)

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = 'utf-8'

    config.time_zone = 'UTC'

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    # Enforce whitelist mode for mass assignment.
    # This will create an empty whitelist of attributes available for mass-assignment for all models
    # in your app. As such, your models will need to explicitly whitelist or blacklist accessible
    # parameters by using an attr_accessible or attr_protected declaration.
    config.active_record.whitelist_attributes = false


    #http://blog.55minutes.com/2012/02/untangling-the-rails-asset-pipeline-part-3-configuration/
    #predates the asset pipeline; the “assets” in serve_static_assets therefore does not mean
    #exactly the same thing as “assets” in the asset pipeline. Instead, this setting controls 
    #whether or not Rails serves the static #files located the public/ directory. These might be 
    #precompiled asset pipeline “assets”, or they may just be static #files you’ve decided to put 
    #there, like public/favicon.ico.
    #When set to true, Rails will install a middleware that checks if each browser request matches a file 
    #in the #public/ directory. If so, it responds with the matching file, and your routes and controllers 
    #will not be used. #Since this middleware adds a certain amount of overhead to processing each request, 
    #it is important to set #config.serve_static_assets=true only if necessary.
    #config.serve_static_assets = true

    # Enable the asset pipeline
    config.assets.enabled = false

    # Version of your assets, change this if you want to expire all your assets
    #config.assets.version = '1.0'

    #config.assets.paths << "#{Rails.root}"
    
  end
end
