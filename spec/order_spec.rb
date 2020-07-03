require 'spec_helper'

describe Order do
  context 'items' do
    it 'creates correct amount of items' do
      products = [
        double('product', id: 1, discount_ids: []),
        double('product', id: 1, discount_ids: []),
        double('product', id: 2, discount_ids: [])
      ]
      repository = double('repository')
      order = described_class.new(products, repository)
      expect(order.items.count).to eq(2)
    end
  end

  context '#price_with_discount' do
    it 'returns sum of prices with discounts' do
      order_items = [
        double('order_items', price: 100),
        double('order_items', price: 100),
        double('order_items', price: 200)
      ]

      order = described_class.new([], [])
      allow(order).to receive(:items) { order_items }
      expect(order.price_with_discount).to eq(400)
    end
  end

  context '#discount' do
    it 'returns sum of prices with discounts' do
      order_items = [
        double('order_items', discount: 100),
        double('order_items', discount: 100),
        double('order_items', discount: 200)
      ]

      order = described_class.new([], [])
      allow(order).to receive(:items) { order_items }
      expect(order.discount).to eq(400)
    end
  end
end
