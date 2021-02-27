# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Start of the seed"
Ingredient.destroy_all
Cocktail.destroy_all
Dose.destroy_all

require 'json'
require 'open-uri'

url = 'https://www.thecocktaildb.com/api/json/v1/1/search.php?f=a'
url_raw = open(url).read
data = JSON.parse(url_raw)
cocktail_tracker = []
ingredient_tracker = []

data["drinks"].each { |cocktail_hash|
  # Create a Cocktail
  new_cocktail = Cocktail.new(
    name: cocktail_hash["strDrink"],
    description: cocktail_hash["strInstructions"],
    rating: rand(1..5),
    image: cocktail_hash["strDrinkThumb"]
  )

  if cocktail_tracker.include? new_cocktail[:name]
    puts "cocktail exists"
  else
    puts "saving cocktail - #{new_cocktail[:name]}"
    new_cocktail.save!
    cocktail_tracker << new_cocktail[:name]
  end

  #ABSORBING INGREDIENT 1
  if ingredient_tracker.include? cocktail_hash["strIngredient1"]
    puts 'ingredient exists'
  else
    if cocktail_hash["strIngredient1"] != nil
      puts "creating ingredient - #{cocktail_hash["strIngredient1"]}"
      new_ingredient = Ingredient.create!(name: cocktail_hash["strIngredient1"])
      ingredient_tracker << cocktail_hash["strIngredient1"]
      
      if cocktail_hash["strMeasure1"] != nil
        new_dose = Dose.new(description: cocktail_hash["strMeasure1"])
      else
        new_dose = Dose.new(description: "a sprinkle!")
      end

      new_dose.cocktail = new_cocktail
      new_dose.ingredient = new_ingredient
      puts "my new dose includes #{new_dose.ingredient[:name]}"
      new_dose.save!
    else
      puts 'ingredient is nil'
    end
    
  end

  #ABSORBING INGREDIENT 2
  if ingredient_tracker.include? cocktail_hash["strIngredient2"]
    puts 'ingredient exists'
  else
    if cocktail_hash["strIngredient2"] != nil
      puts "creating ingredient - #{cocktail_hash["strIngredient2"]}"
      new_ingredient = Ingredient.create!(name: cocktail_hash["strIngredient2"])
      ingredient_tracker << cocktail_hash["strIngredient2"]

      if cocktail_hash["strMeasure2"] != nil
        new_dose = Dose.new(description: cocktail_hash["strMeasure2"])
      else
        new_dose = Dose.new(description: "a sprinkle!")
      end

      new_dose.cocktail = new_cocktail
      new_dose.ingredient = new_ingredient
      puts "my new dose includes #{new_dose.ingredient[:name]}"
      new_dose.save!
    else
      puts 'ingredient is nil'
    end
  end

  #ABSORBING INGREDIENT 3
  if ingredient_tracker.include? cocktail_hash["strIngredient3"]
    puts "ingredient exists"
  else
    if cocktail_hash["strIngredient3"] != nil
      puts "creating ingredient - #{cocktail_hash["strIngredient3"]}"
      new_ingredient = Ingredient.create!(name: cocktail_hash["strIngredient3"])
      ingredient_tracker << cocktail_hash["strIngredient3"]
      
      if cocktail_hash["strMeasure3"] != nil
        new_dose = Dose.new(description: cocktail_hash["strMeasure3"])
      else
        new_dose = Dose.new(description: "a sprinkle!")
      end
      
      new_dose.cocktail = new_cocktail
      new_dose.ingredient = new_ingredient
      puts "my new dose includes #{new_dose.ingredient[:name]}"
      new_dose.save!
    else
      puts 'ingredient is nil'
    end
  end
}
