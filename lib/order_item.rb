class OrderItem
  attr_reader :product, :quantity, :repository

  def initialize(product, quantity, repository)
    @product = product
    @quantity = quantity
    @repository = repository
  end

  def price
    (product.price_in_cents * quantity) - discount
  end

  def discount
    discounts = repository
                  .find_discounts(product.discount_ids)
                  .select { |d| d.quantity <= quantity }
    discounts.map { |d| apply_discount(d) }.sum
  end

  def apply_discount(discount)
    (quantity / discount.quantity).to_i * discount.amount_in_cents
  end
end
