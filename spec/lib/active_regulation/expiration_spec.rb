require 'spec_helper'
require 'date'

describe ActiveRegulation::Expiration do

  describe '#expires_at' do
    it 'to be nil' do
      user = User.create!

      expect(user.expires_at).to eq(nil)
    end

    it 'to be nil' do
      user = User.create!
      user.unexpire!
      user.expire!

      expect(user.expires_at).to eq(nil)
    end

    it 'to not be nil' do
      user = User.create!
      user.unexpire!

      expect(user.expires_at).not_to eq(nil)
    end

    it 'to not be nil' do
      user = User.create!
      user.extend!

      expect(user.expires_at).not_to eq(nil)
    end
  end

  describe '#unexpire!' do
    it 'to be true' do
      user = User.create!
      user.unexpire!

      expect(user.unexpired?).to eq(true)
    end
  end

  describe '#extend!' do
    it 'to be true' do
      user = User.create!
      user.extend!

      expect(user.unexpired?).to eq(true)
    end
  end

  describe '#expire!' do
    it 'to be false' do
      user = User.create!
      user.expire!

      expect(user.unexpired?).to eq(false)
    end
  end

  describe '#unexpired?' do
    it 'to be false' do
      user = User.create!

      expect(user.unexpired?).to eq(false)
    end

    it 'to be false' do
      user = User.create!
      user.expire!

      expect(user.unexpired?).to eq(false)
    end

    it 'to be true' do
      user = User.create!
      user.unexpire!

      expect(user.unexpired?).to eq(true)
    end

    it 'to be true' do
      user = User.create!
      user.extend!

      expect(user.unexpired?).to eq(true)
    end
  end

  describe '#expired?' do
    it 'to be true' do
      user = User.create!

      expect(user.expired?).to eq(true)
    end

    it 'to be true' do
      user = User.create!
      user.expire!

      expect(user.expired?).to eq(true)
    end

    it 'to be false' do
      user = User.create!
      user.extend!

      expect(user.expired?).to eq(false)
    end

    it 'to be false' do
      user = User.create!
      user.unexpire!

      expect(user.expired?).to eq(false)
    end
  end

  describe '#to_expiration' do
    it 'to be "Expired"' do
      user = User.create!

      expect(user.to_expiration).to eq('Expired')
    end

    it 'to be "Expired"' do
      user = User.create!
      user.expire!

      expect(user.to_expiration).to eq('Expired')
    end

    it 'to be "Unexpired"' do
      user = User.create!
      user.unexpire!

      expect(user.to_expiration).to eq('Unexpired')
    end

    it 'to be "Unexpired"' do
      user = User.create!
      user.extend!

      expect(user.to_expiration).to eq('Unexpired')
    end
  end

  describe '#unexpired' do
    it 'to be 35' do
      10.times { User.create!(expires_at: Time.now) }
      35.times { User.create!(expires_at: DateTime.now + 30) }
      15.times { User.create!(expires_at: nil) }

      expect(User.unexpired.count).to eq(35)
    end
  end

  describe '#expired' do
    it 'to be 25' do
      10.times { User.create!(expires_at: Time.now) }
      35.times { User.create!(expires_at: DateTime.now + 30) }
      15.times { User.create!(expires_at: nil) }

      expect(User.expired.count).to eq(25)
    end
  end

end
