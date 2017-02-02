require File.expand_path('../boot', __FILE__)

require 'rails/all'

# If you have a Gemfile, require the gems listed there, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env) if defined?(Bundler)
if defined?(Bundler)
  Bundler.require(*Rails.groups(:assets => %w(development test)))
end

module CfiOauthProvider
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # JavaScript files you want as :defaults (application.js is always included).
    # config.action_view.javascript_expansions[:defaults] = %w(jquery rails)

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = 'utf-8'

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    config.assets.enabled = true
    config.assets.version = '1.0'

    # Mass assingment protection
    config.active_record.whitelist_attributes=true

    # The site name that will be used in text such as "Sign in to site_title"
    config.site_title = ENV.fetch 'SITE_TITLE', 'Arvados'

    # After logging in, the title and URL of the link that will be presented to
    # the user as the default destination on the welcome page.
    config.default_link_title = ENV.fetch 'LINK_TITLE', config.site_title
    config.default_link_url = ENV.fetch 'LINK_URL', 'http://localhost:3000'

    # secret_token is a string of alphanumeric characters used by Rails
    # to sign session tokens. IMPORTANT: This is a site secret. It
    # should be at least 50 characters.
    config.secret_token = ENV['SECRET_TOKEN']

    # The uuid prefix for generating new Arvados user uuids.  Must be exactly
    # five characters long in the range [a-z0-9].
    config.uuid_prefix = ENV['UUID_PREFIX']

    # You really want to run everything over SSL.
    config.force_ssl = true

    ###
    ### Local account configuration.  This is enabled if neither
    ### google_oauth2 or LDAP are enabled below.
    ###
    # If true, allow new creation of new accounts in the SSO server's internal
    # user database.
    config.allow_account_registration = false

    # If true, send an email confirmation before activating new accounts in the
    # SSO server's internal user database.
    config.require_email_confirmation = false


    ###
    ### Google+ OAuth2 authentication.
    ###
    # Google API tokens required for OAuth2 login.
    #
    # See https://github.com/zquestz/omniauth-google-oauth2
    #
    # and https://developers.google.com/accounts/docs/OAuth2
    config.google_oauth2_client_id = false
    config.google_oauth2_client_secret = false

    # Set this to your OpenId 2.0 realm to enable migration from Google OpenId
    # 2.0 to Google OAuth2 OpenId Connect (Google will provide OpenId 2.0 user
    # identifiers via the openid.realm parameter in the OAuth2 flow until 2017).
    config.google_openid_realm = false

    # Enable login via Google OpenId 2.0 (note this is scheduled to be shut off 20 April 2015!)
    config.google_deprecated_openid = false


    ###
    ### LDAP authentication.
    ###
    #
    # If you want to use LDAP, you need to provide
    # the following set of fields under the use_ldap key.
    #
    # use_ldap: false
    #   title: Example LDAP
    #   host: ldap.example.com
    #   port: 636
    #   method: ssl
    #   base: "ou=Users, dc=example, dc=com"
    #   uid: uid
    #   email_domain: example.com
    #   #bind_dn: "some_user"
    #   #password: "some_password"
    config.use_ldap = false
  end
end
