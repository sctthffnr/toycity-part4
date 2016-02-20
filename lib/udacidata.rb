require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata
  @@items = []

  def self.create(options = {})
    @data_path = File.dirname(__FILE__) + '/../data/data.csv'
    CSV.open(@data_path, 'a') do |csv|
      csv << [options[:brand], options[:product], options[:price]]
    end
    item = new(options)
    @@items << item
    item
  end

  def self.all
    @@items
  end

  def self.first
    @@items.first
  end
end
