require 'json'

class DataLoader
  DATA_STORAGE_PATH = 'data'

  class << self
    def load_products
      new.load_records('products', Product)
    end

    def load_discounts
      new.load_records('discounts', Discount)
    end
  end

  def load_records(name, model)
    File.open("#{DATA_STORAGE_PATH}/#{name}.json") do |f|
      JSON.load(f).map do |item|
        model.new(item)
      end
    end
  end
end
