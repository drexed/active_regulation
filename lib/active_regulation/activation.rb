module ActiveRegulation
  module Activation
    extend ActiveSupport::Concern
    include ActiveRegulation::Base

    included do
      attr_accessor :activation, :raw_activation

      before_save :record_activation!, unless: -> (obj) { obj.raw_activation.nil? }
      after_initialize :set_activation!

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
      false_value = FALSE_VALUES.include?(activation)
      true_value  = TRUE_VALUES.include?(activation)

      if false_value || true_value
        self.inactivated_at = (false_value ? Time.now : nil)
      else
        raise ArgumentError,
          "Unknown boolean: #{activation.inspect}. Must be a valid boolean."
      end
    end

    def set_activation!
      self.raw_activation = activation
      self.activation     = active? if activation.nil?
    end

  end
end