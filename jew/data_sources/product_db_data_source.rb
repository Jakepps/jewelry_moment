require 'mysql2'
require_relative 'db_client'

class ProductDBDataSource
  def initialize
    @client = DBClient.instance
  end

  def add(product)
    query = "INSERT INTO Product (ProductID, Title, MasterID, CustomerID) VALUES (#{product.id}, '#{product.title}', #{product.master_id}, #{product.customer_id})"
    @client.query(query)
  end

  def change(product)
    query = "UPDATE Product SET Title='#{product.title}', MasterID=#{product.master_id}, CustomerID=#{product.customer_id} WHERE ProductID=#{product.id}"
    @client.query(query)
  end

  def delete(id)
    query = "DELETE FROM Product WHERE ProductID=#{id}"
    @client.query(query)
  end

  def get(id)
    query = "SELECT * FROM Product WHERE ProductID=#{id}"
    result = @client.query(query).first
    if result
      Product.new(result['ProductID'], result['Title'], result['MasterID'], result['CustomerID'])
    else
      nil
    end
  end

  def get_list(page_size, page_num, sort_field, sort_direction)
    offset = (page_num - 1) * page_size
    query = "SELECT * FROM Product ORDER BY #{sort_field} #{sort_direction} LIMIT #{page_size} OFFSET #{offset}"
    results = @client.query(query)
    products = []
    results.each do |result|
      products << Product.new(result['ProductID'], result['Title'], result['MasterID'], result['CustomerID'])
    end
    products
  end
end