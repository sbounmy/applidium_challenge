# Rep
class Meal
  attr_accessor :name, :kcal
  # Public: Initialize a Meal.
  #
  # name - A String naming the meal.
  # kcal - An Integer representing the kcal.
  def initialize(options={})
    self.name, self.kcal = options[:name], options[:kcal].to_i
  end
end

class Menu < Array
  # Internal: Array of days
  DAYS = %w(lundi mardi mercredi jeudi vendredi)

  # Public: Sort and calculate optimal menu for a given Kcal
  #
  # kcal - An integer representing the number of KiloCalories.
  #
  # Examples
  #
  #   @menu = Menu.new
  #   @menu << @meal1 = Meal.new(:name => "noodle", :kcal => 200)
  #   @menu << @meal2 = Meal.new(:name => "couscous", :kcal => 500)
  #   @menu << @meal3 = Meal.new(:name => "pasta", :kcal => 700)
  #   @menu << @meal4 = Meal.new(:name => "bigmac", :kcal => 800)
  #   @menu << @meal5 = Meal.new(:name => "pasta", :kcal => 1000)
  #   @menu << @meal6 = Meal.new(:name => "bigmac", :kcal => 1300)
  #   @menu.healthy(3300)
  #   => [[@meal1, @meal2, @meal3, @meal4, @meal5], 3200]
  #
  # Returns an array :
  # - an array of meals
  # - the meals total kcal
  def healthy(kcal)
    sort_by_kcal!

    optimal_kcal(kcal)
  end

  def meal_index #nodoc
    self.class.nb_days - 1
  end

  # Public : Integer number of days for the menu.
  def self.nb_days
    @nb ||= DAYS.count
  end

  # Public: Sort self meals by ascending Kcal
  #
  # Returns self (ordered by kcal)
  def sort_by_kcal!
    self.sort_by! { |meal| meal.kcal }
  end

  def self.display(meals, kcal, asked)
    DAYS.each_with_index do |day, i|
      puts "#{day} : \"#{meals[i].name}\""
    end
    puts "---\nTotal : #{kcal} kcal, contre #{asked} kcal demandees"
  end

  private
  # Private : Find recursively the optimal menu with a given kcal
  #
  # Returns an array :
  # - an array of meals
  # - the meals total kcal
  def optimal_kcal(kcal, i = 0)
    res = 0
    range = self[i..(meal_index + i)]
    range.each do |meal|
      res += meal.kcal
    end

    return [range, res] if res >= kcal or (self.class.nb_days + i > self.length)

    n, r = optimal_kcal(kcal, i += 1)
    if kcal - res > (kcal - r).abs
      return [n, r]
    else
      return [range, res]
    end
  end
end