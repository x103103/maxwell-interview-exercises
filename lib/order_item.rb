class OrderItem
  attr_reader :product, :quantity, :repo

  # @param [Repository] repo
  def initialize(product, quantity, repo)
    @product = product
    @quantity = quantity
    @repo = repo
  end

  def price
    (product.price_in_cents * quantity) - discount
  end

  def discount
    discounts = repo
                  .find_discounts(product.discount_ids)
                  .select { |d| d.quantity <= quantity }
    discounts.map { |d| apply_discount(d) }.sum
  end

  def apply_discount(discount)
    (quantity / discount.quantity).to_i * discount.amount_in_cents
  end
end
