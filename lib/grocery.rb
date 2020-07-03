require_relative './repository'
require_relative './data_loader'

class Grocery
  def call
    repo = Repository.new(DataLoader.load_products, DataLoader.load_discounts)


  end
end
