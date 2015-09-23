module ActiveRegulation
  module Activation
    extend ActiveSupport::Concern

    included do
      attr_accessor :activation

      validates :activation, inclusion: { in: 0..1 },
                             allow_blank: true,
                             allow_nil: true

      before_save :record_activation!

      scope :active,   -> { where(inactivated_at: nil) }
      scope :inactive, -> { where.not(inactivated_at: nil) }
    end

    def active!
      update(inactivated_at: nil) if inactive?
    end

    def inactive!
      update(inactivated_at: Time.now) if active?
    end

    def active?
      inactivated_at.nil?
    end

    def inactive?
      !active?
    end

    def to_activation
      I18n.t("active_regulation.activation.#{active? ? :active : :inactive}")
    end

    private

    def record_activation!
      self.inactivated_at = (activation.zero? ? Time.now : nil) unless activation.blank?
    end

  end
end