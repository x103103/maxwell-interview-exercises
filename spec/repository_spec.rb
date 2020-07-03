require 'spec_helper'

describe Repository do
  context '#products' do
    it 'returns all products' do
      repo = described_class.new(['product 1', 'product 2'], [])
      expect(repo.products.count).to eq(2)
    end
  end
  context '#discounts' do
    it 'returns all discounts' do
      repo = described_class.new([], ['item 1', 'item 2'])
      expect(repo.discounts.count).to eq(2)
    end
  end

  context '#find_discounts' do
    it 'returns discounts matched by id' do
      disc1 = double('Discount', id: 1)
      disc2 = double('Discount', id: 2)
      disc3 = double('Discount', id: 3)
      repo = described_class.new([], [disc1, disc2, disc3])
      expect(repo.find_discounts([1, 2])).to match_array([disc1, disc2])
    end
  end
end
