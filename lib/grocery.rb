require 'os'
require_relative './repository'
require_relative './models'
require_relative './order'
require_relative './order_item'
require_relative './data_loader'
require_relative './table_drawer'

trap("INT") do |signal|
  puts signal == 2 ? "\b\bShutting down..." : "Exit status: #{signal}"
  exit
end

class Grocery
  attr_reader :repository

  def initialize
    @repository = Repository.new(DataLoader.load_products, DataLoader.load_discounts)
  end

  def call
    play_greeting

    loop do
      puts 'Please enter all the items purchased separated by a comma'
      order_string = gets.strip
      products = find_products(order_string)

      draw(products)
    end
  end

  private

  def find_products(order_string)
    product_names = order_string.split(',')
                      .map(&:downcase)
                      .map(&:strip)

    products = product_names.map do |name|
      repository.products.find { |p| p.name.downcase == name }
    end

    products.reject(&:nil?)
  end

  def draw(products)
    order = Order.new(products, repository)
    headers = %w[Item Quantity Price]
    rows = order.items.map do |item|
      [item.product.name, item.quantity, to_dollars(item.price)]
    end

    TableDrawer.new(
      headers,
      rows,
      to_dollars(order.price_with_discount),
      to_dollars(order.discount)
    ).call
  end

  def to_dollars(value)
    "$#{value / 100.0}"
  end

  def play_greeting
    if OS.mac?
      Thread.new do
        `afplay assets/favoritecustomer.mp3`
      rescue StandardError
        # whatever happens, it doesn't matter
      end
    end
  end
end
