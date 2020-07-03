require_relative './repository'
require_relative './models'
require_relative './order'
require_relative './order_item'
require_relative './data_loader'
require_relative './table_drawer'

class Grocery
  def call
    repo = Repository.new(DataLoader.load_products, DataLoader.load_discounts)

    loop do
      pp('Please enter all the items purchased separated by a comma')
      order_string = gets.strip

      product_names = order_string.split(',')
                        .map(&:downcase)
                        .map(&:strip)


      products = product_names.map do |name|
        repo.products.find { |p| p.name.downcase == name }
      end
      products = products.reject(&:nil?)

      order = Order.new(products, repo)
      headers = %w[Item Quantity Price]
      rows = order.items.map do |item|
        [item.product.name,  item.quantity, to_dollars(item.price)]
      end

      TableDrawer.new(
        headers,
        rows,
        to_dollars(order.price_with_discount),
        to_dollars(order.discount)
      ).call

    end

  end

  private

  def to_dollars(value)
    "$#{value / 100.0}"
  end
end
