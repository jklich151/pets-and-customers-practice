require 'minitest/autorun'
require 'minitest/pride'
require './lib/customer'
require './lib/pet'
require './lib/day_care'

class DaycareTest < Minitest::Test
  def test_it_exists
    day_care = Daycare.new("Pet Place")

    assert_instance_of Daycare, day_care
  end

  def test_it_has_attributes
    day_care = Daycare.new("Pet Place")

    assert_equal "Pet Place", day_care.name
  end

  def test_has_customers
    day_care = Daycare.new("Pet Place")
    joel = Customer.new("Joel", 2)
    nick = Customer.new("Nick", 5)

    day_care.add_customer(joel)
    day_care.add_customer(nick)

    assert_equal [joel, nick], day_care.customers
  end

  def test_find_customer_by_id
    day_care = Daycare.new("Pet Place")
    joel = Customer.new("Joel", 2)
    nick = Customer.new("Nick", 5)

    day_care.add_customer(joel)
    day_care.add_customer(nick)

    assert_equal nick, day_care.search_id(5)
  end

  def test_unfed_pets
    day_care = Daycare.new("Pet Place")
    joel = Customer.new("Joel", 2)
    nick = Customer.new("Nick", 5)

    assert_equal [], day_care.hungry_pets

    day_care.add_customer(joel)
    day_care.add_customer(nick)

    samson = Pet.new({name: "Samson", type: :dog})
    lucy = Pet.new({name: "Lucy", type: :cat})

    joel.adopt(samson)
    nick.adopt(lucy)

    assert_equal [samson, lucy], day_care.hungry_pets

    samson.feed

    assert_equal [lucy], day_care.hungry_pets
  end
end
