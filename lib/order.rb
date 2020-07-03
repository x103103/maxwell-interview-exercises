class Order
  attr_reader :items, :repository

  def initialize(products, repository)
    @repository = repository
    @items = build_items(products)
  end

  def price_with_discount
    items.sum(&:price)
  end

  def discount
    items.sum(&:discount)
  end

  private

  def build_items(products)
    products.group_by(&:id).map do |_id, group|
      OrderItem.new(group.first, group.size, repository)
    end
  end
end
