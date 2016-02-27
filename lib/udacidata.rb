require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata
  Module.create_finder_methods(:name, :brand)
  @@items = []
  @@data_path = File.dirname(__FILE__) + '/../data/data.csv'

  def self.create(options = {})
    item = new(options)
    @@items << item
    CSV.open(@@data_path, 'a') do |csv|
      csv << [item.id.to_s, item.brand, item.name, item.price]
    end
    item
  end

  def self.delete_all
    @@items = []
  end

  def self.all
    @@items
  end

  def self.first(num = nil)
    num ? @@items.take(num) : @@items.first
  end

  def self.last(num = nil)
    num ? @@items.slice(-num, num) : @@items.last
  end

  def self.find(id)
    @@items.each do |item|
      return item if item.id == id
    end
    raise ProductNotFoundError, "#{id} is not a valid product id"
  end

  def self.destroy(id)
    fail ProductNotFoundError, "#{id} is not a valid product id" unless find(id)
    rewrite_csv(id)
    @@items.delete(find(id))
  end

  def self.where(query)
    @@items.each_with_object([]) do |item, result|
      result << item if item.send(query.keys.first.to_s) == query.values.first
    end
  end

  def update(options = {})
    options.each do |key, value|
      send("#{key}=", value)
    end
    self
  end

  def self.rewrite_csv(id)
    current = CSV.read(@@data_path)
    current.each do |row|
      current.delete(row) if row.first == id.to_s
    end
    CSV.open(@@data_path, 'wb') do |csv|
      current.each do |row|
        csv << row
      end
    end
  end
end
