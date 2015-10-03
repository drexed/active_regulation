require "active_regulation/version"
require "active_regulation/base"
require "active_regulation/activation"
require "active_regulation/containment"
require "active_regulation/expiration"
require "active_regulation/visibility"

if defined?(Rails)
  require 'rails'

  module ActiveRegulation
    class Railtie < ::Rails::Railtie

      initializer 'active_regulation' do |app|
        ActiveRegulation::Railtie.instance_eval do
          [app.config.i18n.available_locales].flatten.each do |locale|
            (I18n.load_path << path(locale)) if File.file?(path(locale))
          end
        end
      end

      protected

      def self.path(locale)
        File.expand_path("../../config/locales/#{locale}.yml", __FILE__)
      end

    end
  end
end