module Analyzable
  def average_price(products)
    total = products.inject(0) do |sum, product|
      sum + product.price
    end
    (total / products.size).round(2)
  end
end
