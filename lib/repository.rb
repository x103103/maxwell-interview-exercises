class Repository
  attr_reader :products, :discounts

  def initialize(products, discounts)
    @products = products
    @discounts = discounts
  end


  def find_discounts(ids)
    discounts.select { |r| ids.include?(r.id) }
  end
end
