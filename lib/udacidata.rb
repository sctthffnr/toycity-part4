require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata
  Module.create_finder_methods(:name, :brand)
  @@data_path = File.dirname(__FILE__) + '/../data/data.csv'

  def self.create(options = {})
    item = new(options)
    add_to_db(item)
  end

  def self.all
    db = CSV.read(@@data_path).drop(1)
    db.each_with_object([]) do |row, items|
      items << Product.new(id: row[0], brand: row[1],
                           name: row[2], price: row[3].to_f)
    end
  end

  def self.first(num = nil)
    num ? all.take(num) : all.first
  end

  def self.last(num = nil)
    num ? all.slice(-num, num) : all.last
  end

  def self.find(id)
    all.each do |item|
      return item if item.id == id
    end
    raise ProductNotFoundError, "#{id} is not a valid product id"
  end

  def self.destroy(id)
    raise ProductNotFoundError, "#{id} is not a valid product id" unless find(id)
    item = find(id)
    update_db(remove_from_db(id))
    item
  end

  def self.where(query)
    all.each_with_object([]) do |item, result|
      result << item if item.send(query.keys.first.to_s) == query.values.first
    end
  end

  def update(options = {})
    options.each do |key, value|
      send("#{key}=", value)
    end
    Udacidata.update_db(Udacidata.remove_from_db(id))
    Udacidata.add_to_db(self)
  end

  def self.add_to_db(item)
    CSV.open(@@data_path, 'a') do |csv|
      csv << [item.id.to_s, item.brand, item.name, item.price]
    end
    item
  end

  def self.remove_from_db(id)
    current = CSV.read(@@data_path)
    current.each do |row|
      current.delete(row) if row.first == id.to_s
    end
    current
  end

  def self.update_db(new_db)
    CSV.open(@@data_path, 'wb') do |csv|
      new_db.each do |row|
        csv << row
      end
    end
  end
end
