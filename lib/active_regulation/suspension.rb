module ActiveRegulation
  module Suspension
    extend ActiveSupport::Concern

    included do
      scope :suspended, -> { where.not(suspended_at: nil) }
      scope :unsuspended, -> { where(suspended_at: nil) }
    end

    def suspend!
      update(suspended_at: Time.now) if unsuspended?
    end

    def unsuspend!
      update(suspended_at: nil) if suspended?
    end

    def suspended?
      !unsuspended?
    end

    def unsuspended?
      suspended_at.nil?
    end

    def suspended_at_or_time
      suspended? ? Time.now : suspended_at
    end

    def to_suspension
      I18n.t("active_regulation.suspension.#{suspended? ? :suspended : :unsuspended}")
    end

  end
end
