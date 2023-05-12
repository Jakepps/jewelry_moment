require 'minitest/autorun'
require './jew/models/customer'

class TestCustomer < Minitest::Test

  def test_initialize_with_valid_arguments
    customer = Customer.new(1, "Test Customer", "test@example.com")
    assert_equal 1, customer.customer_id
    assert_equal "Test Customer", customer.name
    assert_equal "test@example.com", customer.email
  end

  def test_initialize_with_null_customer_id
    error = assert_raises(ArgumentError) do
      Customer.new(nil, "Test Customer", "test@example.com")
    end
    assert_equal "Argument 'customer_id' cannot be null", error.message
  end

  def test_initialize_with_null_name
    error = assert_raises(ArgumentError) do
      Customer.new(1, nil, "test@example.com")
    end
    assert_equal "Argument 'name' cannot be null", error.message
  end

  def test_initialize_with_name_length_exceeding_limit
    long_name = "a" * 101
    error = assert_raises(ArgumentError) do
      Customer.new(1, long_name, "test@example.com")
    end
    assert_equal "Name exceeds 100 characters limit: #{long_name}", error.message
  end

  def test_initialize_with_invalid_email_format
    error = assert_raises(ArgumentError) do
      Customer.new(1, "Test Customer", "invalid-email")
    end
    assert_equal "Invalid email format: invalid-email", error.message
  end
end
