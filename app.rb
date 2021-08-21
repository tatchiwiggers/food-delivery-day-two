require_relative "app/repositories/meal_repository"
require_relative "app/controllers/meals_controller"
require_relative "app/repositories/customer_repository"
require_relative "app/controllers/customers_controller"
require_relative "router"

# REQUIRE RELATIVE EMPLOYEE REPOSITORY
require_relative "app/repositories/employee_repository"
# REQUIRE RELATIVE SESSIONS CONTROLLER
require_relative "app/controllers/sessions_controller"

# MAKE SURE WE HAVE THAT
EMPLOYEES_CSV_FILE = File.join(__dir__, "data/employees.csv")


MEALS_CSV_FILE = File.join(__dir__, "data/meals.csv")
CUSTOMERS_CSV_FILE = File.join(__dir__, "data/customers.csv")
ORDERS_CSV_FILE = File.join(__dir__, "data/orders.csv")

meal_repository = MealRepository.new(MEALS_CSV_FILE)
meals_controller = MealsController.new(meal_repository)

customer_repository = CustomerRepository.new(CUSTOMERS_CSV_FILE)
customers_controller = CustomersController.new(customer_repository)

# INSTANTIATE EMPLOYEE REPOSITORY
employee_repository = EmployeeRepository.new(EMPLOYEES_CSV_FILE)
# INSTANTIATE SESSIONS CONTROLLER
sessions_controller = SessionsController.new(employee_repository)

router = Router.new(meals_controller, customers_controller, sessions_controller)
router.run
