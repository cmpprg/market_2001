require "minitest/autorun"
require "minitest/pride"
require "./lib/vendor"
require "./lib/item"

class ItemTest < Minitest::Test

  def setup
    @item1 = Item.new({name: 'Peach', price: "$0.75"})
    @item2 = Item.new({name: 'Tomato', price: '$0.50'})
    @vendor = Vendor.new("Rocky Mountain Fresh")
  end

  def test_it_exists
    assert_instance_of Vendor, @vendor
  end

  def test_it_has_attributes
    assert_equal "Rocky Mountain Fresh", @vendor.name
    assert_equal ({}), @vendor.inventory
  end

  def test_it_can_check_stock_for_item
    assert_equal 0, @vendor.check_stock(@item1)
  end

  def test_it_can_add_quantity_of_item_to_inventory
    @vendor.stock(@item1, 30)

    assert_equal ({@item1=>30}), @vendor.inventory

    @vendor.stock(@item1, 25)

    assert_equal ({@item1=>55}), @vendor.inventory

    @vendor.stock(@item2, 12)

    assert_equal ({@item1=>55, @item2=>12}), @vendor.inventory
  end

  def test_it_can_calculate_its_potential_revenue
    @vendor.stock(@item1, 30)
    @vendor.stock(@item1, 25)
    @vendor.stock(@item2, 12)

    assert_equal 47.25, @vendor.potential_revenue
  end

end
