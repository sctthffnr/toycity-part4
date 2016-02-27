module Analyzable
  def average_price(products)
    total = products.inject(0) do |sum, product|
      sum + product.price
    end
    (total / products.size).round(2)
  end

  def count_by_brand(products)
    products.each_with_object(Hash.new(0)) do |product, counts|
      counts[product.brand] += 1
    end
  end

  def count_by_name(products)
    products.each_with_object(Hash.new(0)) do |product, counts|
      counts[product.name] += 1
    end
  end

  def print_report(products)
    print_average_price(products)
    print_brand_count(products)
    print_name_count(products)
    'Report completed'
  end

  def print_average_price(products)
    puts "Average Price: #{average_price(products)}"
    puts
  end

  def print_brand_count(products)
    brands = count_by_brand(products)
    puts 'Inventory by Brand:'
    format_count(brands)
  end

  def print_name_count(products)
    names = count_by_name(products)
    puts 'Inventory by Name';
    format_count(names)
  end

  def format_count(items)
    items.each do |key, value|
      puts " - #{key}: #{value}"
    end
    puts
  end
end
