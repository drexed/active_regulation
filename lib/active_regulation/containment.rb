module ActiveRegulation
  module Containment
    extend ActiveSupport::Concern
    include ActiveRegulation::Base

    included do
      attr_accessor :containment, :raw_containment

      before_save :record_containment!, unless: -> (obj) { obj.raw_containment.nil? }
      after_initialize :set_containment!

      scope :contained,   -> { where.not(contained_at: nil) }
      scope :uncontained, -> { where(contained_at: nil) }
    end

    def contain!
      update(contained_at: Time.now) if uncontained?
    end

    def uncontain!
      update(contained_at: nil) if contained?
    end

    def contained?
      !uncontained?
    end

    def uncontained?
      contained_at.nil?
    end

    def to_containment
      I18n.t("active_regulation.containment.#{uncontained? ? :uncontained : :contained}")
    end

    private

    def record_containment!
      false_value = FALSE_VALUES.include?(containment)
      true_value  = TRUE_VALUES.include?(containment)

      if false_value || true_value
        self.contained_at = (false_value ? nil : Time.now)
      else
        raise ArgumentError,
          "Unknown boolean: #{containment.inspect}. Must be a valid boolean."
      end
    end

    def set_containment!
      self.raw_containment = containment
      self.containment     = contained? if containment.nil?
    end

  end
end