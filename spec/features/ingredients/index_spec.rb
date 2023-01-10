require 'rails_helper'

RSpec.describe 'ingredients index page' do
  before :each do
    @chef = Chef.create!(name: "Ramsey")
    @chef2 = Chef.create!(name: "Fieri")
    @dish = Dish.create!(name: "Prime rib", description: 'rare steak served with baked potatoe', chef_id: @chef.id)
    @dish2 = Dish.create!(name: "Grilled Chicken", description: 'served in a salad', chef_id: @chef.id)
    @dish3 = Dish.create!(name: "Mac n Cheese", description: 'heaven', chef_id: @chef2.id)
    @ingredient1 = @dish.ingredients.create!(name: "Steak", calories: 700)
    @ingredient2 = @dish.ingredients.create!(name: "Baked potatoe", calories: 500)
    @ingredient3 = @dish2.ingredients.create!(name: "Chicken", calories: 700)
    @ingredient4 = @dish3.ingredients.create!(name: "Maccaroni", calories: 500)
  end

  it 'links to a chefs ingredients index page' do
    visit chef_ingredients_path(@chef)

    expect(page).to have_content("Chef #{@chef.name}'s Ingredients")
    expect(page).to have_content(@ingredient1.name)
    expect(page).to have_content(@ingredient2.name)
    expect(page).to have_content(@ingredient3.name)
    expect(page).to_not have_content(@ingredient4.name)
  end
end