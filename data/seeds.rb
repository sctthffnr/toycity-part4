require 'faker'
require_relative '../lib/product'
# This file contains code that populates the database with
# fake data for testing purposes

def db_seed
  Product.empty!
  10.times do
    Product.create(brand: Faker::Company.name,
                   name: Faker::Commerce.product_name,
                   price: Faker::Commerce.price)
  end
end
