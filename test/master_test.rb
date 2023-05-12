require 'minitest/autorun'
require './jew/models/master'

class TestMaster < Minitest::Test

  def test_initialize_sets_attributes
    master = Master.new(1, 'Jake', 'Epps', 'Smith')

    assert_equal 1, master.master_id
    assert_equal 'Jake', master.first_name
    assert_equal 'Epps', master.last_name
    assert_equal 'Smith', master.father_name
  end

  def test_initialize_raises_error_if_master_id_is_nil
    error = assert_raises(ArgumentError) do
      Master.new(nil, 'Jake', 'Epps')
    end
    assert_equal "Argument 'id' cannot be null", error.message
  end

  def test_initialize_raises_error_if_first_name_is_nil
    error = assert_raises(ArgumentError) do
      Master.new(1, nil, 'Epps')
    end
    assert_equal "Argument 'first name' cannot be null", error.message
  end

  def test_initialize_raises_error_if_last_name_is_nil
    error = assert_raises(ArgumentError) do
      Master.new(1, 'Jake', nil)
    end
    assert_equal "Argument 'last name' cannot be null", error.message
  end

  def test_initialize_raises_error_if_first_name_exceeds_50_characters
    long_name = 'a' * 51
    error = assert_raises(ArgumentError) do
      Master.new(1, long_name, 'Epps')
    end
    assert_equal "First name exceeds 50 characters limit: #{long_name}", error.message
  end

  def test_initialize_raises_error_if_last_name_exceeds_50_characters
    long_name = 'a' * 51
    error = assert_raises(ArgumentError) do
      Master.new(1, 'Jake', long_name)
    end
    assert_equal "Last name exceeds 50 characters limit: #{long_name}", error.message
  end

  def test_initialize_raises_error_if_father_name_exceeds_50_characters
    long_name = 'a' * 51
    error = assert_raises(ArgumentError) do
      Master.new(1, 'Jake', 'Epps', long_name)
    end
    assert_equal "Father name exceeds 50 characters limit: #{long_name}", error.message
  end
end
