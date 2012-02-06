require 'test/unit'
require './menu'

class TestMenu < Test::Unit::TestCase
  def setup
    @menu = Menu.new
    [["couscous", 500],
    ["bigmac", 800],
    ["kebab", 1000],
    ["sandwich", "200"],
    ["pizza", "700"],
    ["crepe", "200"],
    ["chinois", 450]].map do |meal|
      @menu << Meal.new(:name => meal.first, :kcal => meal.last)
    end
  end

  def test_healthy_with_minimum_kcal_should_return_healthy_food
    assert !@menu.empty?
    assert_equal ["sandwich", "crepe", "chinois", "couscous", "pizza"], @menu.healthy(2050).first.collect(&:name)
  end

  def test_healthy_with_very_high_kcal_should_return_bad_food
    assert_equal ["chinois", "couscous", "pizza", "bigmac", "kebab"], @menu.healthy(10000).first.collect(&:name)
  end

  def test_healthy_with_kcal_zero_should_not_freak_out
    assert_equal ["sandwich", "crepe", "chinois", "couscous", "pizza"], @menu.healthy(0).first.collect(&:name)
  end

  def test_healthy_should_return_closest_matching_kcal_menu
    # ["sandwich", "crepe", "chinois", "couscous", "pizza"] => 2050 kcal
    # ["crepe", "chinois", "couscous", "pizza", "bigmac"] =>  2650 kcal
    assert_equal ["sandwich", "crepe", "chinois", "couscous", "pizza"], @menu.healthy(2100).first.collect(&:name)
    assert_equal ["crepe", "chinois", "couscous", "pizza", "bigmac"], @menu.healthy(2400).first.collect(&:name)
  end

end