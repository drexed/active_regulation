module ActiveRegulation
  module Visibility
    extend ActiveSupport::Concern

    included do
      scope :visible,   -> { where(invisible_at: nil) }
      scope :invisible, -> { where.not(invisible_at: nil) }
    end

    def invisible!
      update(invisible_at: Time.now)
    end

    def visible!
      update(invisible_at: nil)
    end

    def invisible?
      !visible?
    end

    def visible?
      invisible_at.nil?
    end

    def to_visibility
      I18n.t("active_regulation.visibility.#{visible? ? :visible : :invisible}")
    end

  end
end