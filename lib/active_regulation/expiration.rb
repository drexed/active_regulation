# frozen_string_literal: true

module ActiveRegulation
  module Expiration
    extend ActiveSupport::Concern

    included do
      scope :expired, -> { where('expires_at IS NULL OR expires_at < ?', Time.current) }
      scope :unexpired, -> { where('expires_at IS NOT NULL AND expires_at >= ?', Time.current) }
    end

    def expire!
      update(expires_at: nil) unless expires_at.nil?
    end

    def extend!(amount = nil)
      update(expires_at: extension_date(amount))
    end

    def unexpire!
      update(expires_at: extension_date) if expires_at.nil?
    end

    def expired?
      expires_at.nil? ? true : (Time.current >= expires_at)
    end

    def unexpired?
      expires_at.nil? ? false : (Time.current < expires_at)
    end

    def expires_at_or_time(amount = nil)
      expired? ? extension_date(amount) : expires_at
    end

    def to_expiration
      I18n.t("active_regulation.expiration.#{expired? ? :expired : :unexpired}")
    end

    private

    def extension_date(time = nil)
      time = 30 if time.nil?

      time.is_a?(Integer) ? (Time.current + time) : time
    end

  end
end
