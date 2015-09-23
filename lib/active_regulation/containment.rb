module ActiveRegulation
  module Containment
    extend ActiveSupport::Concern

    included do
      attr_accessor :containment

      validates :containment, inclusion: { in: 0..1 },
                              allow_blank: true,
                              allow_nil: true

      before_save :record_containment!

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
      self.contained_at = (containment.zero? ? nil : Time.now) unless containment.blank?
    end

  end
end