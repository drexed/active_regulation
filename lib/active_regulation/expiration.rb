require 'date'

module ActiveRegulation
  module Expiration
    extend ActiveSupport::Concern
    include ActiveRegulation::Base

    included do
      attr_accessor :expiration, :raw_expiration

      before_save :record_expiration!, unless: -> (obj) { obj.raw_expiration.nil? }
      after_initialize :set_expiration!

      scope :expired,   -> { where("expires_at IS NULL OR expires_at < ?", Time.now) }
      scope :unexpired, -> { where("expires_at IS NOT NULL AND expires_at >= ?", Time.now) }
    end

    def expire!
      update(expires_at: nil) unless expires_at.nil?
    end

    def extend!(amount=nil)
      update(expires_at: (amount.nil? ? extension_date : amount))
    end

    def unexpire!
      update(expires_at: extension_date) if expires_at.nil?
    end

    def expired?
      expires_at.nil? ? true : (Time.now >= expires_at)
    end

    def unexpired?
      expires_at.nil? ? false : (Time.now < expires_at)
    end

    def to_expiration
      I18n.t("active_regulation.expiration.#{expired? ? :expired : :unexpired}")
    end

    private

    def extension_date(days=30)
      DateTime.now + days
    end

    def record_expiration!
      false_value = FALSE_VALUES.include?(expiration)
      true_value  = TRUE_VALUES.include?(expiration)

      if false_value || true_value
        self.expires_at = (false_value ? extension_date : nil)
      else
        raise ArgumentError,
          "Unknown boolean: #{expiration.inspect}. Must be a valid boolean."
      end
    end

    def set_expiration!
      self.raw_expiration = expiration
      self.expiration     = expired? if expiration.nil?
    end

  end
end