require_relative "../views/sessions_view"

class SessionsController
  def initialize(employee_repository)
    @sessions_view = SessionsView.new
    # INSTANTIATE THE EMPLOYEE REPO
    @employee_repository = employee_repository
  end

  def login
    # 1. ask user for username (we need a session view)
    username = @sessions_view.ask_for(:username)

    # 2. ask user for password
    password = @sessions_view.ask_for(:password)

    # 3. find the employee with the username
    employee = @employee_repository.find_by_username(username)

    # 4. compare the password given with the on in DB
    # check to see if there is an employee AND and if the password matches
    # this runs if login is successful
    return employee if employee && employee.password == password

    # WE NEED A METHOD IN THE VIEW
    # if something goes wrong, call this method then tries to login again
    @sessions_view.print_wrong_credentials
    login
  end
end
