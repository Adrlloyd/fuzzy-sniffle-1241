require 'rails_helper'

RSpec.describe 'chefs show page' do
  before :each do
    @chef = Chef.create!(name: "Ramsey")
    @chef2 = Chef.create!(name: "Fieri")
    @dish = Dish.create!(name: "Prime rib", description: 'rare steak served with baked potatoe', chef_id: @chef.id)
    @dish2 = Dish.create!(name: "Grilled Chicken", description: 'served in a salad', chef_id: @chef.id)
    @dish3 = Dish.create!(name: "Mac n Cheese", description: 'heaven', chef_id: @chef2.id)
  end

  it 'displays the name and its dishes' do
    visit chef_path(@chef)

    expect(page).to have_content("Ramsey")

    within("#dishes") do
      expect(page).to have_content("Prime rib")
      expect(page).to have_content("Grilled Chicken")
      expect(page).to_not have_content("Mac n Cheese")
    end
  end

  it 'has a form to add a dish' do
    visit chef_path(@chef)

    expect(page).to have_field "dish_id"

    within("#dishes") do
      expect(page).to_not have_content("Mac n Cheese")
    end

    fill_in('dish_id', with: "#{@dish3.id}")

    click_button 'Submit'

    expect(current_path).to eq(chef_path(@chef))

    within("#dishes") do
      expect(page).to have_content("Mac n Cheese")
    end
  end

  it 'has a link to a chefs ingredients index page' do
    visit chef_path(@chef)

    expect(page).to have_link("#{@chef.name}'s Ingredients")

    click_link "#{@chef.name}'s Ingredients"

    expect(current_path).to eq(chef_ingredients_path(@chef))
  end
end