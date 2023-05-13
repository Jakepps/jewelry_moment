class Product
  attr_reader :product_id, :title, :master_id, :customer_id

  def initialize(product_id, title, master_id, customer_id)
    validate_null('product_id', product_id)
    validate_null('title', title)
    validate_null('master_id', master_id)
    validate_null('customer_id', customer_id)

    validate_title_length(title)

    @product_id = product_id
    @title = title
    @master_id = master_id
    @customer_id = customer_id
  end

  private

  def validate_null(name, value)
    if value.nil?
      raise ArgumentError, "Argument  '#{name}' cannot be null"
    end
  end

  def validate_title_length(title)
    if title.length > 255
      raise ArgumentError, "The title contains more than 255 characters: #{title}"
    end
  end
end