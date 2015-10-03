module ActiveRegulation
  module Visibility
    extend ActiveSupport::Concern
    include ActiveRegulation::Base

    included do
      attr_accessor :visibility, :raw_visibility

      before_save :record_visibility!
      after_initialize :set_visibility!

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
      unless raw_visibility.nil?
        false_value = FALSE_VALUES.include?(visibility)
        true_value  = TRUE_VALUES.include?(visibility)

        if false_value || true_value
          self.invisible_at = (false_value ? Time.now : nil)
        else
          raise ArgumentError,
            "Unknown boolean: #{visibility.inspect}. Must be a valid boolean."
        end
      end
    end

    def set_visibility!
      self.raw_visibility = visibility
      self.visibility     = visible? if visibility.nil?
    end

  end
end