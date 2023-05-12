require 'mysql2'
require_relative '../data_sources/db_client'
require_relative '../models/customer'

class CustomerDBDataSource
  def initialize
    @client = DBClient.instance
  end

  def add(customer)
    query = "INSERT INTO Customer (Name, Email) VALUES ('#{customer.name}', #{customer.email.nil? ? 'NULL' : "'#{customer.email}'"})"
    @client.query(query)
    customer_id = @client.last_id
    get(customer_id)
  end

  def change(customer)
    query = "UPDATE Customer SET Name='#{customer.name}', Email=#{customer.email.nil? ? 'NULL' : "'#{customer.email}'"} WHERE CustomerID=#{customer.customer_id}"
    @client.query(query)
    get(customer.customer_id)
  end

  def delete(id)
    query = "DELETE FROM Customer WHERE CustomerID=#{id}"
    @client.query(query)
  end

  def get(id)
    query = "SELECT * FROM Customer WHERE CustomerID=#{id}"
    result = @client.query(query).first
    if result
      Customer.new(result[:'CustomerID'], result[:'Name'], result[:'Email'])
    else
      nil
    end
  end

  def get_list(page_size, page_num, sort_field, sort_direction, has_email = nil)
    offset = (page_num - 1) * page_size
    query = "SELECT * FROM Customer"

    if has_email == true
      query += " WHERE Email IS NOT NULL"
    elsif has_email == false
      query += " WHERE Email IS NULL"
    end

    query += " ORDER BY #{sort_field} #{sort_direction} LIMIT #{page_size} OFFSET #{offset}"

    results = @client.query(query)
    customers = []
    results.each do |result|
      customers << Customer.new(result[:'CustomerID'], result[:'Name'], result[:'Email'])
    end
    customers
  end

  def count
    query = "SELECT COUNT(*) FROM Customer"
    result = @client.query(query).first
    result[:'COUNT(*)']
  end
end