require 'rails_helper'

RSpec.describe "dish's show page" do
  before :each do
    @chef = Chef.create!(name: "Ramsey")
    @dish = Dish.create!(name: "Prime rib", description: 'rare steak served with baked potatoe', chef_id: @chef.id)
    @ingredient1 = @dish.ingredients.create!(name: "Steak", calories: 700)
    @ingredient2 = @dish.ingredients.create!(name: "Baked potatoe", calories: 500)
  end

  it 'displays its name, description, and its ingredients' do
    visit dish_path(@dish)

    expect(page).to have_content(@dish.name)
    expect(page).to have_content(@dish.description)
    expect(page).to have_content(@dish.chef.name)

    within("#ingredients") do
      expect(page).to have_content("Steak")
      expect(page).to have_content("Baked potatoe")
    end
  end

  it 'displays the total calorie count' do
    visit dish_path(@dish)

    expect(page).to have_content("Total Calories: #{@dish.total_calories}")
  end
end