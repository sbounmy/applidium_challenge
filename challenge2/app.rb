class Hash
  def symbolize_keys!
    keys.each do |key|
      self[(key.to_sym rescue key) || key] = delete(key)
    end
    self
  end
end

class App
  PARAMS = [:term, :description, :kind]
  attr_accessor *PARAMS

  def self.new_from_json(json=[])
    return if json.nil? or json.empty?
    App.new(json)
  end

  def initialize(attributes={})
    attributes.symbolize_keys!
    PARAMS.each do |param|
      self.send("#{param}=", attributes[param])
    end
  end
end