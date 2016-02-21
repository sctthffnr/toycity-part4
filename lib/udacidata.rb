require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata
  @@items = []

  def self.create(options = {})
    item = new(options)
    @@items << item
    @data_path = File.dirname(__FILE__) + '/../data/data.csv'
    CSV.open(@data_path, 'a') do |csv|
      csv << [item.id.to_s, item.brand, item.name, item.price]
    end
    item
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
  end
end
