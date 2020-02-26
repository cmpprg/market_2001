class Market


  attr_reader :name, :vendors
  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map{ |vendor| vendor.name }
  end

  def vendors_that_sell(item)
    @vendors.find_all{|vendor| vendor.inventory.include?(item)}
  end

  def total_inventory
    all_inventories = @vendors.map do |vendor|
       vendor.inventory
     end

    items = @vendors.map{ |vendor| vendor.inventory.keys }.flatten.uniq

    total_inventory = items.reduce({}) do |total_inventory, item|
      total_inventory[item] = {quantity: 0, vendors: vendors_that_sell(item)}
      total_inventory
    end
    
    all_inventories.each do |inventory|
      inventory.each do |item, quantity|
        total_inventory[item][:quantity] += quantity
      end
    end

    total_inventory
  end
end
