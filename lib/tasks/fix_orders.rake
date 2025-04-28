namespace :orders do
  desc "Recalculate totals for all orders"
  task recalculate_totals: :environment do
    puts "Recalculating all order totals..."
    orders_updated = 0

    Order.find_each do |order|
      old_total = order.total
      if order.order_items.any?
        order.reload
        order.save!
        new_total = order.total

        if old_total != new_total
          puts "Order ##{order.id}: Total updated from #{old_total || 0} to #{new_total}"
          orders_updated += 1
        end
      end
    end

    puts "Done! #{orders_updated} orders updated."
  end
end
