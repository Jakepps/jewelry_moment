require 'mysql2'
require_relative '../data_sources/db_client'

class MasterDBDataSource
  def initialize
    @client = DBClient.instance
  end

  def add(master)
    query = "INSERT INTO Master (FirstName, LastName, FatherName) VALUES ('#{master.first_name}', '#{master.last_name}', #{master.father_name.nil? ? 'NULL' : "'#{master.father_name}'"})"
    @client.query(query)
    master_id = @client.last_id
    get(master_id)
  end

  def change(master)
    query = "UPDATE Master SET FirstName='#{master.first_name}', LastName='#{master.last_name}', FatherName=#{master.father_name.nil? ? 'NULL' : "'#{master.father_name}'"} WHERE MasterID=#{master.master_id}"
    @client.query(query)
    get(master.master_id)
  end

  def delete(id)
    query = "DELETE FROM Master WHERE MasterID=#{id}"
    @client.query(query)
  end

  def get(id)
    query = "SELECT * FROM Master WHERE MasterID=#{id}"
    result = @client.query(query).first
    if result
      Master.new(result[:'MasterID'], result[:'FirstName'], result[:'LastName'], result[:'FatherName'])
    else
      nil
    end
  end

  def get_list(page_size, page_num, sort_field, sort_direction, has_father_name = nil)
    offset = (page_num - 1) * page_size
    query = "SELECT * FROM Master"

    if has_father_name == true
      query += " WHERE FatherName IS NOT NULL"
    elsif has_father_name == false
      query += " WHERE FatherName IS NULL"
    end

    query += " ORDER BY #{sort_field} #{sort_direction} LIMIT #{page_size} OFFSET #{offset}"
    results = @client.query(query)

    masters = []
    results.each do |result|
      masters << Master.new(result[:'MasterID'], result[:'FirstName'], result[:'LastName'], result[:'FatherName'])
    end

    masters
  end


  def count
    query = "SELECT COUNT(*) FROM Master"
    result = @client.query(query).first

    result[:'COUNT(*)']
  end
end