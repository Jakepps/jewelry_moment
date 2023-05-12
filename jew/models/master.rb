class Master
  attr_reader :master_id, :first_name, :last_name, :father_name

  def initialize(master_id, first_name, last_name, father_name = nil)
    validate_null('master_id', master_id)
    validate_null('first_name', first_name)
    validate_null('last_name', last_name)

    validate_name_length(first_name, last_name, father_name)

    @master_id = master_id
    @first_name = first_name
    @last_name = last_name
    @father_name = father_name
  end

  private

  def validate_null(name, value)
    if value.nil?
      raise ArgumentError, "The argument '#{name}' cannot be null"
    end
  end

  def validate_name_length(first_name, last_name, father_name)
    [first_name, last_name, father_name].each do |name|
      if name && name.length > 50
        raise ArgumentError, "The number of characters in the name exceeds 50: #{name}"
      end
    end
  end
end
