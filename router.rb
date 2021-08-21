class Router
  def initialize(meals_controller, customers_controller, sessions_controller)
    @meals_controller = meals_controller
    @customers_controller = customers_controller
    # instantiantes sessions controller
    @sessions_controller = sessions_controller
    @running = true
  end

  def run
    while @running
      # WE NEED TO SIGN IN FIRST
      @current_user = @sessions_controller.login
      while @current_user
        # if manager print manager menu
        if @current_user.manager?
          route_manager_action
        else
          # else print rider menu
          route_rider_action
        end
      end
      print `clear`
    end
  end

  private

  def route_manager_action
    print_manager_menu
    choice = gets.chomp.to_i
    print `clear`
    manager_action(choice)
  end

  def route_rider_action
    print_rider_menu
    choice = gets.chomp.to_i
    print `clear`
    rider_action(choice)
  end

  def print_manager_menu
    puts "--------------------"
    puts "------- MENU -------"
    puts "--------------------"
    puts "1. Add new meal"
    puts "2. List all meals"
    puts "3. Add new customer"
    puts "4. List all customers"
    puts "5. Add new order"
    puts "6. List all undelivered orders"
    puts "7. Logout"
    puts "8. Exit"
    print "> "
  end

  def print_rider_menu
    puts "--------------------"
    puts "------- MENU -------"
    puts "--------------------"
    puts "1. List my undelivered orders"
    puts "2. Mark order as delivered"
    puts "3. Logout"
    puts "4. Exit"
    print "> "
  end

  def manager_action(choice)
    case choice
    when 1 then @meals_controller.add
    when 2 then @meals_controller.list
    when 3 then @customers_controller.add
    when 4 then @customers_controller.list
    when 5 then @orders_controller.add
    when 6 then @orders_controller.list_undelivered_orders
    # implements sign out
    when 7 then logout!
    when 8 then stop!
    else puts "Try again..."
    end
  end

  def rider_action(choice)
    case choice
    when 1 then @orders_controller.list_my_orders(@current_user)
    when 2 then @orders_controller.mark_as_delivered(@current_user)
    # implements sign out
    when 3 then logout!
    when 4 then stop!
    else puts "Try again..."
    end
  end

  # implements sign out method
  def logout!
    @current_user = nil
  end

  def stop!
    logout!
    @running = false
  end
end
