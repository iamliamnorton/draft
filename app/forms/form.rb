class Form
  include Virtus.model
  include ActiveModel::Conversion
  include ActiveModel::Validations
  extend  ActiveModel::Naming

  def initialize(attributes = {})
    super
    attributes.each { |n, v| send("#{n}=", v) if respond_to?("#{n}=") }
  end

  def persisted?
    false
  end

  class << self
    def model_name
      begin
        super
      rescue TypeError
        ActiveModel::Name.new(Form)
      end
    end
  end
end
