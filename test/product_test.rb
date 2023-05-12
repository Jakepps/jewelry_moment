require 'minitest/autorun'
require './jew/models/product'

class TestProduct < Minitest::Test

  def test_product_attributes_are_set
    product = Product.new(1, 'title', 2, 3)

    assert_equal 1, product.product_id
    assert_equal 'title', product.title
    assert_equal 2, product.master_id
    assert_equal 3, product.customer_id
  end

  def test_initialize_raises_error_with_null_product_id
    error = assert_raises(ArgumentError) do
      Product.new(nil, 'Ring', 1,1)
    end
    assert_equal "Argument 'id' cannot be null", error.message
  end

  def test_initialize_raises_error_with_null_title
    error = assert_raises(ArgumentError) do
      Product.new(1, nil, 1,1)
    end
    assert_equal "Argument 'title' cannot be null", error.message
  end

  def test_initialize_raises_error_with_null_master_id
    error = assert_raises(ArgumentError) do
      Product.new(1, 'Ring', nil,1)
    end
    assert_equal "Argument 'master_id' cannot be null", error.message
  end

  def test_initialize_raises_error_with_null_publisher_id
    error = assert_raises(ArgumentError) do
      Product.new(1, 'Ring', 1,nil)
    end
    assert_equal "Argument 'customer_id' cannot be null", error.message
  end

  def test_initialize_raises_error_with_long_title
    long_title = 'a' * 256
    error = assert_raises(ArgumentError) do
      Product.new(1, long_title, 1, 1)
    end
    assert_equal "First title exceeds 255 characters limit: #{long_title}", error.message
  end
end
