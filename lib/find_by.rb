class Module
  def create_finder_methods(*attributes)
    attributes.each do |attribute|
      define_method("find_by_#{attribute}") do |arg|
        all.each do |item|
          return item if item.send(attribute.to_s) == arg.to_s
        end
      end
    end
  end
end
