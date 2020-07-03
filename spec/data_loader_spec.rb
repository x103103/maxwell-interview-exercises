require 'spec_helper'

describe DataLoader do
  context '.load_products' do
    it 'loads two products' do
      expect(described_class.load_products.count).to eq(2)
    end

    it 'returns instances of Product model' do
      expect(described_class.load_products.first).to be_a(Product)
      end

    it 'sets attributes correctly' do
      product = described_class.load_products.first
      aggregate_failures 'Product attributes' do
        expect(product.id).to eq(1)
        expect(product.name).to eq('Milk')
        expect(product.price_in_cents).to eq(300)
        expect(product.discount_ids).to eq([1])
      end
    end
    end
  context '.load_discountss' do
    it 'loads two products' do
      expect(described_class.load_discounts.count).to eq(2)
    end

    it 'returns instances of Discount model' do
      expect(described_class.load_discounts.first).to be_a(Discount)
      end

    it 'sets attributes correctly' do
      product = described_class.load_discounts.first
      aggregate_failures 'Discount attributes' do
        expect(product.id).to eq(1)
        expect(product.name).to eq('Milk Discount')
        expect(product.amount_in_cents).to eq(294)
        expect(product.quantity).to eq(2)
      end
    end
  end
end
