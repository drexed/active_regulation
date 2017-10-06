# frozen_string_literal: true

require 'spec_helper'

describe ActiveRegulation::Visibility do
  let(:klass) { User.include(ActiveRegulation::Visibility) }
  let(:user) { klass.create! }

  describe '#invisible_at' do
    it 'to be nil' do
      expect(user.invisible_at).to eq(nil)
    end

    it 'to be nil' do
      user.invisible!
      user.visible!

      expect(user.invisible_at).to eq(nil)
    end

    it 'to not be nil' do
      user.invisible!

      expect(user.invisible_at).not_to eq(nil)
    end
  end

  describe '#visible!' do
    it 'to be true' do
      user.visible!

      expect(user.visible?).to eq(true)
    end
  end

  describe '#invisible!' do
    it 'to be false' do
      user.invisible!

      expect(user.visible?).to eq(false)
    end
  end

  describe '#visible?' do
    it 'to be true' do
      expect(user.visible?).to eq(true)
    end

    it 'to be false' do
      user.invisible!

      expect(user.visible?).to eq(false)
    end
  end

  describe '#invisible?' do
    it 'to be false' do
      expect(user.invisible?).to eq(false)
    end

    it 'to be true' do
      user.invisible!

      expect(user.invisible?).to eq(true)
    end
  end

  describe '#to_visibility' do
    it 'to be "Visible"' do
      expect(user.to_visibility).to eq('Visible')
    end

    it 'to be "Invisible"' do
      user.invisible!

      expect(user.to_visibility).to eq('Invisible')
    end
  end

  describe '#visible' do
    it 'to be 15' do
      35.times { klass.create!(invisible_at: Time.current) }
      15.times { klass.create!(invisible_at: nil) }

      expect(klass.visible.count).to eq(15)
    end
  end

  describe '#invisible' do
    it 'to be 35' do
      35.times { klass.create!(invisible_at: Time.current) }
      15.times { klass.create!(invisible_at: nil) }

      expect(klass.invisible.count).to eq(35)
    end
  end

end
