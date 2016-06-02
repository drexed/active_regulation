module ActiveRegulation
  module Quarantine
    extend ActiveSupport::Concern

    included do
      scope :quarantined, -> { where.not(quarantined_at: nil) }
      scope :unquarantined, -> { where(quarantined_at: nil) }
    end

    def quarantine!
      update(quarantined_at: Time.now) if unquarantined?
    end

    def unquarantine!
      update(quarantined_at: nil) if quarantined?
    end

    def quarantined?
      !unquarantined?
    end

    def unquarantined?
      quarantined_at.nil?
    end

    def quarantined_at_or_time
      unquarantined? ? Time.now : quarantined_at
    end

    def to_quarantine
      I18n.t("active_regulation.quarantine.#{unquarantined? ? :unquarantined : :quarantined}")
    end

  end
end
