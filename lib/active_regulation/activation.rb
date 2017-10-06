# frozen_string_literal: true

module ActiveRegulation
  module Activation
    extend ActiveSupport::Concern

    included do
      scope :active, -> { where(inactivated_at: nil) }
      scope :inactive, -> { where.not(inactivated_at: nil) }
    end

    def active!
      update(inactivated_at: nil) if inactive?
    end

    def inactive!
      update(inactivated_at: Time.current) if active?
    end

    def active?
      inactivated_at.nil?
    end

    def inactive?
      !active?
    end

    def inactivated_at_or_time
      active? ? Time.current : inactivated_at
    end

    def to_activation
      I18n.t("active_regulation.activation.#{active? ? :active : :inactive}")
    end

  end
end
