# frozen_string_literal: true

require 'spec_helper'

describe ActiveRegulation::Containment do
  let(:klass) { User.include(ActiveRegulation::Containment) }
  let(:user) { klass.create! }

  describe '#contained_at' do
    it 'to be nil' do
      expect(user.contained_at).to eq(nil)
    end

    it 'to be nil' do
      user.contain!
      user.uncontain!

      expect(user.contained_at).to eq(nil)
    end

    it 'to not be nil' do
      user.contain!

      expect(user.contained_at).not_to eq(nil)
    end
  end

  describe '#uncontain!' do
    it 'to be true' do
      user.uncontain!

      expect(user.uncontained?).to eq(true)
    end
  end

  describe '#contain!' do
    it 'to be false' do
      user.contain!

      expect(user.uncontained?).to eq(false)
    end
  end

  describe '#uncontained?' do
    it 'to be true' do
      expect(user.uncontained?).to eq(true)
    end

    it 'to be false' do
      user.contain!

      expect(user.uncontained?).to eq(false)
    end
  end

  describe '#contained?' do
    it 'to be false' do
      expect(user.contained?).to eq(false)
    end

    it 'to be true' do
      user.contain!

      expect(user.contained?).to eq(true)
    end
  end

  describe '#to_containment' do
    it 'to be "Uncontained"' do
      expect(user.to_containment).to eq('Uncontained')
    end

    it 'to be "Contained"' do
      user.contain!

      expect(user.to_containment).to eq('Contained')
    end
  end

  describe '#uncontained' do
    it 'to be 15' do
      35.times { klass.create!(contained_at: Time.current) }
      15.times { klass.create!(contained_at: nil) }

      expect(klass.uncontained.count).to eq(15)
    end
  end

  describe '#contained' do
    it 'to be 35' do
      35.times { klass.create!(contained_at: Time.current) }
      15.times { klass.create!(contained_at: nil) }

      expect(klass.contained.count).to eq(35)
    end
  end

end
