class Form
  include Virtus.model
  include ActiveModel::Conversion
  include ActiveModel::Validations
  extend  ActiveModel::Naming

  def persisted?
    false
  end

  def add_errors_from_record(record)
    record.errors.each do |field, message|
      errors.add(field, message)
    end
  end

  class << self
    def validates_component(component_name, options={})
      validator_name = :"_ensure_valid_#{component_name}"

      define_method(validator_name) {
        record = public_send(component_name)
        if record.invalid?
          add_errors_from_record(record)
        end
      }

      validate(validator_name, options)
    end

    def model_name
      begin
        super
      rescue TypeError
        ActiveModel::Name.new(Form)
      end
    end
  end
end
