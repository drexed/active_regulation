require 'spec_helper'

describe ActiveRegulation::Visibility do

  describe '#invisible_at' do
    it 'to be nil' do
      user = User.create!

      expect(user.invisible_at).to eq(nil)
    end

    it 'to be nil' do
      user = User.create!
      user.invisible!
      user.visible!

      expect(user.invisible_at).to eq(nil)
    end

    it 'to not be nil' do
      user = User.create!
      user.invisible!

      expect(user.invisible_at).not_to eq(nil)
    end
  end

  describe '#visible!' do
    it 'to be true' do
      user = User.create!
      user.visible!

      expect(user.visible?).to eq(true)
    end
  end

  describe '#invisible!' do
    it 'to be false' do
      user = User.create!
      user.invisible!

      expect(user.visible?).to eq(false)
    end
  end

  describe '#visible?' do
    it 'to be true' do
      user = User.create!

      expect(user.visible?).to eq(true)
    end

    it 'to be false' do
      user = User.create!
      user.invisible!

      expect(user.visible?).to eq(false)
    end
  end

  describe '#invisible?' do
    it 'to be false' do
      user = User.create!

      expect(user.invisible?).to eq(false)
    end

    it 'to be true' do
      user = User.create!
      user.invisible!

      expect(user.invisible?).to eq(true)
    end
  end

  describe '#to_visibility' do
    it 'to be "Visible"' do
      user = User.create!

      expect(user.to_visibility).to eq('Visible')
    end

    it 'to be "Invisible"' do
      user = User.create!
      user.invisible!

      expect(user.to_visibility).to eq('Invisible')
    end
  end

  describe '#visible' do
    it 'to be 15' do
      35.times { User.create!(invisible_at: Time.now) }
      15.times { User.create!(invisible_at: nil) }

      expect(User.visible.count).to eq(15)
    end
  end

  describe '#invisible' do
    it 'to be 35' do
      35.times { User.create!(invisible_at: Time.now) }
      15.times { User.create!(invisible_at: nil) }

      expect(User.invisible.count).to eq(35)
    end
  end

end
