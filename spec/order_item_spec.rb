require 'spec_helper'

describe OrderItem do
  context '#price' do
    it 'returns total price of products' do
      product = double('product', price_in_cents: 100, discount_ids: [])
      repo = Repository.new([product], [])
      item = described_class.new(product, 2, repo)
      expect(item.price).to eq(200)
    end
  end

  context '#discount' do
    context 'product quantity is enough for discount' do
      it 'returns discount amount' do
        discount = double('discount', id: 1, amount_in_cents: 23, quantity: 2)
        discount2 = double('discount', id: 2, amount_in_cents: 27, quantity: 2)
        product = double('product', price_in_cents: 100, discount_ids: [1, 2])
        repo = Repository.new([product], [discount, discount2])

        item = described_class.new(product, 2, repo)
        expect(item.discount).to eq(50)
      end

      it 'applies discount once' do
        discount = double('discount', id: 1, amount_in_cents: 23, quantity: 2)
        product = double('product', price_in_cents: 100, discount_ids: [1])
        repo = Repository.new([product], [discount])

        item = described_class.new(product, 3, repo)
        expect(item.discount).to eq(23)
      end

      it 'applies discount twice' do
        discount = double('discount', id: 1, amount_in_cents: 23, quantity: 2)
        product = double('product', price_in_cents: 100, discount_ids: [1])
        repo = Repository.new([product], [discount])

        item = described_class.new(product, 4, repo)
        expect(item.discount).to eq(46)
      end
    end

    context 'product quantity is not enough for discount' do
      it 'returns discount amount' do
        discount = double('discount', id: 1, quantity: 2)
        product = double('product', price_in_cents: 100, discount_ids: [1])
        repo = Repository.new([product], [discount])

        item = described_class.new(product, 1, repo)
        expect(item.discount).to eq(0)
      end
    end
  end
end
