require './menu'

puts "Kcal souhaitee"
kcal = gets
kcal = kcal.to_i


def self.get_meals(menu)
  puts "Veuillez saisir: nom_du_plat = Kcal"

  input = gets
  return menu if input == "\n"

  plat, kcal = input.gsub("\n", "").split("=")
  puts "#{plat.strip!}(#{kcal.strip!}kcal) ajoute avec succes"
  get_meals(menu <<  Meal.new(:name => plat, :kcal => kcal.to_i) )
end

menu = get_meals(Menu.new)
Menu.display(*menu.healthy(kcal), kcal)