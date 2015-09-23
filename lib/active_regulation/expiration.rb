require 'date'

module ActiveRegulation
  module Expiration
    extend ActiveSupport::Concern

    included do
      attr_accessor :expiration

      validates :expiration, inclusion: { in: 0..1 },
                             allow_blank: true,
                             allow_nil: true

      before_save :record_expiration!

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
      self.expires_at = (expiration.zero? ? extension_date : nil) unless expiration.blank?
    end

  end
end