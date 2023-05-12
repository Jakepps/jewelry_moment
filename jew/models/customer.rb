class Customer
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  attr_reader :customer_id, :name, :email

  def initialize(customer_id, name, email = nil)
    validate_null('customer_id', customer_id)
    validate_null('name', name)

    validate_name_length(name)
    validate_email(email)

    @customer_id = customer_id
    @name = name
    @email = email
  end

  private

  def validate_null(name, value)
    if value.nil?
      raise ArgumentError, "The argument '#{name}' cannot be null"
    end
  end

  def validate_name_length(name)
    if name.length > 100
      raise ArgumentError, "The number of characters in the name exceeds 100: #{name}"
    end
  end

  def validate_email(email)
    if email && !email.match?(EMAIL_REGEX)
      raise ArgumentError, "Invalid email format: #{email}"
    end
  end
end
