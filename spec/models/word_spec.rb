require 'rails_helper'

RSpec.describe Word, type: :model do
  let(:word) { create(:word) }
  describe 'spelling' do
    it 'must be present' do
      expect(Word.create(spelling: nil).errors.messages.count).to eql(1)
    end
    it 'must be unique' do
      create(:word, spelling: 'hello')
      expect(Word.create(spelling: 'hello').errors.messages.count).to eql(1)
    end
  end

  describe 'reviews' do
    it 'is dependent' do
      word.reviews.create!(scheduled_for: Date.new(2018))
      Word.first.destroy
      expect(Review.all.count).to eql(0)
    end
  end
end
