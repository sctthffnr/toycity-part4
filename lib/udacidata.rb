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

  def self.first(num = 1)
    return @@items.first if num == 1
    @@items.take(num)
  end
end
