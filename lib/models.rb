Product = Struct.new(:id, :name, :price_in_cents, :discount_ids, keyword_init: true) do
  def price
    (price_in_cents / 100.0).round(2)
  end
end

Discount = Struct.new(:id, :name, :amount_in_cents, :quantity, keyword_init: true) do
  def amount
    (amount_in_cents / 100.0).round(2)
  end
end
