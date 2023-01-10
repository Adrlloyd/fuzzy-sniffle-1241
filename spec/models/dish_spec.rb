require 'rails_helper'

RSpec.describe Dish, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
  end
  
  describe "relationships" do
    it {should belong_to :chef}
    it {should have_many :dish_ingredients}
    it {should have_many(:ingredients).through(:dish_ingredients)}
  end

  describe "instance method" do
    before :each do
      @chef = Chef.create!(name: "Ramsey")
      @dish = Dish.create!(name: "Prime rib", description: 'rare steak served with baked potatoe', chef_id: @chef.id)
      @ingredient1 = @dish.ingredients.create!(name: "Steak", calories: 700)
      @ingredient2 = @dish.ingredients.create!(name: "Baked potatoe", calories: 500)
    end

    it '#total_calories' do
      expect(@dish.total_calories).to eq 1200
    end
  end
end