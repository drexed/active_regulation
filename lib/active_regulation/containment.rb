module ActiveRegulation
  module Containment
    extend ActiveSupport::Concern

    included do
      scope :contained, -> { where.not(contained_at: nil) }
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

    def contained_at_or_time
      uncontained? ? Time.now : contained_at
    end

    def to_containment
      I18n.t("active_regulation.containment.#{uncontained? ? :uncontained : :contained}")
    end

  end
end
