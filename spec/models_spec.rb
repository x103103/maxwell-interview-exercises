require 'spec_helper'

describe 'Models' do
  context 'Product' do
    context '#price' do
      it 'returns price in dollars' do
        product = Product.new(id: 1, name: 'Milk', price_in_cents: 120)

        expect(product.price).to eq(1.20)
      end
    end
  end
  context 'Discount' do
    context '#amount' do
      it 'returns price in dollars' do
        product = Discount.new(id: 1, name: 'Milk discount', amount_in_cents: 120)

        expect(product.amount).to eq(1.20)
      end
    end
  end
end
