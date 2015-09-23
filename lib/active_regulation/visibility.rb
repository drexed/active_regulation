module ActiveRegulation
  module Visibility
    extend ActiveSupport::Concern

    included do
      attr_accessor :visibility

      validates :visibility, inclusion: { in: 0..1 },
                             allow_blank: true,
                             allow_nil: true

      before_save :record_visibility!

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

    private

    def record_visibility!
      self.invisible_at = (visibility.zero? ? Time.now : nil) unless visibility.blank?
    end

  end
end