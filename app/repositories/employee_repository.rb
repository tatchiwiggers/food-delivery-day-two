require "csv"
require_relative "../models/employee"

class EmployeeRepository
  def initialize(csv_file)
    @csv_file = csv_file
    @employees = []
    load_csv if File.exist?(@csv_file)
  end

  def all_riders
    # SELECT RETURNS AN ARRAY
    @employees.select { |employee| employee.rider? }
  end

  def find(id)
    # FIND RETURNS ONE - THE FIRST ELEMENT (HAS TO BE UNIQUE)
    @employees.find { |employee| employee.id == id }
  end

  def find_by_username(username)
    # FIND RETURNS ONE - THE FIRST ELEMENT (HAS TO BE UNIQUE)
    @employees.find { |employee| employee.username == username }
  end

  private

  def load_csv
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_file, csv_options) do |row|
      row[:id] = row[:id].to_i
      @employees << Employee.new(row)
    end
  end
end
