# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Clear existing data
puts "Clearing existing data..."
OrderItem.destroy_all
Order.destroy_all
Product.destroy_all
Customer.destroy_all
Admin.destroy_all

# Create admin user
puts "Creating admin user..."
Admin.create!(
  email: "admin@example.com",
  password: "password",
  password_confirmation: "password"
)

# Create products
puts "Creating products..."
products = [
  {
    name: "Laptop XPS 15",
    sku: "LT-XPS-15",
    price: 1299.99,
    stock_quantity: 15,
    status: true
  },
  {
    name: "Wireless Mouse",
    sku: "ACC-WM-001",
    price: 24.99,
    stock_quantity: 100,
    status: true
  },
  {
    name: "Mechanical Keyboard",
    sku: "ACC-KB-001",
    price: 89.99,
    stock_quantity: 30,
    status: true
  },
  {
    name: "27-inch Monitor",
    sku: "MON-27-001",
    price: 349.99,
    stock_quantity: 8,
    status: true
  },
  {
    name: "External Hard Drive 1TB",
    sku: "ST-EHD-1TB",
    price: 79.99,
    stock_quantity: 25,
    status: true
  },
  {
    name: "USB-C Hub",
    sku: "ACC-HUB-001",
    price: 39.99,
    stock_quantity: 50,
    status: true
  },
  {
    name: "Laptop Stand",
    sku: "ACC-LS-001",
    price: 29.99,
    stock_quantity: 40,
    status: true
  },
  {
    name: "Wireless Headphones",
    sku: "AUD-WH-001",
    price: 199.99,
    stock_quantity: 12,
    status: true
  },
  {
    name: "Webcam HD",
    sku: "ACC-WC-001",
    price: 59.99,
    stock_quantity: 20,
    status: true
  },
  {
    name: "Gaming Mouse",
    sku: "ACC-GM-001",
    price: 49.99,
    stock_quantity: 35,
    status: true
  },
  {
    name: "Desk Lamp",
    sku: "HOM-DL-001",
    price: 39.99,
    stock_quantity: 15,
    status: true
  },
  {
    name: "Smartphone Holder",
    sku: "ACC-SH-001",
    price: 15.99,
    stock_quantity: 45,
    status: true
  },
  {
    name: "Bluetooth Speaker",
    sku: "AUD-BS-001",
    price: 79.99,
    stock_quantity: 18,
    status: true
  },
  {
    name: "Wireless Charger",
    sku: "ACC-WCH-001",
    price: 29.99,
    stock_quantity: 22,
    status: true
  },
  {
    name: "Screen Protector",
    sku: "ACC-SP-001",
    price: 9.99,
    stock_quantity: 60,
    status: true
  },
  {
    name: "Laptop Bag",
    sku: "BAG-LT-001",
    price: 49.99,
    stock_quantity: 25,
    status: true
  },
  {
    name: "HDMI Cable",
    sku: "CAB-HD-001",
    price: 14.99,
    stock_quantity: 70,
    status: true
  },
  {
    name: "Printer",
    sku: "PR-001",
    price: 199.99,
    stock_quantity: 7,
    status: true
  },
  {
    name: "Router",
    sku: "NET-RT-001",
    price: 89.99,
    stock_quantity: 12,
    status: true
  },
  {
    name: "USB Flash Drive 64GB",
    sku: "ST-USB-64",
    price: 19.99,
    stock_quantity: 40,
    status: true
  },
  {
    name: "Discontinued Tablet",
    sku: "TAB-OLD-001",
    price: 299.99,
    stock_quantity: 3,
    status: false
  },
  {
    name: "Low Stock Smartphone",
    sku: "SP-LS-001",
    price: 699.99,
    stock_quantity: 2,
    status: true
  },
  {
    name: "Out of Stock Item",
    sku: "OUT-OF-ST-001",
    price: 49.99,
    stock_quantity: 0,
    status: true
  }
]

created_products = products.map { |product_data| Product.create!(product_data) }

# Create customers
puts "Creating customers..."
customers = [
  {
    name: "John Smith",
    email: "john.smith@example.com",
    phone: "555-123-4567",
    address: "123 Main St\nAnytown, NY 10001"
  },
  {
    name: "Jane Doe",
    email: "jane.doe@example.com",
    phone: "555-987-6543",
    address: "456 Oak Ave\nOther City, CA 90210"
  },
  {
    name: "Alice Johnson",
    email: "alice.johnson@example.com",
    phone: "555-555-5555",
    address: "789 Pine Rd\nSomewhere, TX 75001"
  },
  {
    name: "Bob Williams",
    email: "bob.williams@example.com",
    phone: "555-222-3333",
    address: "101 Maple Dr\nAnother Place, FL 33101"
  },
  {
    name: "Charlie Brown",
    email: "charlie.brown@example.com",
    phone: "555-444-7777",
    address: "202 Elm St\nLastville, WA 98101"
  },
  {
    name: "Tech Solutions Inc.",
    email: "contact@techsolutions.example",
    phone: "555-888-9999",
    address: "1000 Corporate Blvd\nBusiness City, IL 60601"
  },
  {
    name: "Education First School",
    email: "admin@eduschool.example",
    phone: "555-111-2222",
    address: "500 Learning Ln\nKnowledge Town, MA 02108"
  },
  {
    name: "Healthcare Center",
    email: "info@healthcare.example",
    phone: "555-333-4444",
    address: "300 Wellness Way\nCaring City, PA 19101"
  }
]

created_customers = customers.map { |customer_data| Customer.create!(customer_data) }

puts "Creating orders and order items..."
order_statuses = %w[pending processing shipped delivered canceled]

20.times do |i|
  customer = created_customers.sample

  status_index = i < 5 ? i % 5 : rand(5)
  order = Order.new(
    customer: customer,
    status: order_statuses[status_index],
    created_at: rand(30).days.ago
  )

  used_products = []

  order_items_added = false
  potential_products = created_products.shuffle

  potential_products.each do |product|
    break if used_products.length >= 5 || (order_items_added && rand < 0.7)

    next if product.stock_quantity <= 0 || used_products.include?(product.id)

    max_qty = product.price > 100 ? 3 : 5
    quantity = rand(1..[ max_qty, product.stock_quantity ].min)

    order.order_items.build(
      product: product,
      quantity: quantity,
      unit_price: product.price
    )

    used_products << product.id
    order_items_added = true
  end

  if !order_items_added
    in_stock_product = potential_products.find { |p| p.stock_quantity > 0 }
    if in_stock_product
      quantity = 1

      order.order_items.build(
        product: in_stock_product,
        quantity: quantity,
        unit_price: in_stock_product.price
      )
    end
  end

  begin
    order.save!
    puts "  Created order ##{order.id} with #{order.order_items.count} items, total: #{order.total}"
  rescue => e
    puts "  Failed to create order: #{e.message}"
  end
end

puts "Seed data created successfully!"
puts "------------------------------------------------"
puts "Admin login: admin@example.com / password"
puts "#{Product.count} products created"
puts "#{Customer.count} customers created"
puts "#{Order.count} orders with #{OrderItem.count} order items created"
puts "------------------------------------------------"
