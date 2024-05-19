User.create(first_name: "John", last_name: "Doe", role: "super_admin", email: "johnsa@example.com", phone_number: "+254787990876", password: "Security123", password_confirmation: "Security123")
Order.create(mode_of_payment: "MPesa", phone_number: "+254787990876", full_name: "John Doe", user_id: 1)
Service.create(service_type: "water supply", service_quantity: "10,000 l", price: 20000.0, order_id: 1)
