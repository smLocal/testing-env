require 'rails_helper'

feature "a user can create a new item" do
	scenario "valid item" do
		visit '/items/new'
		fill_in "Name", with: "My new item"
		fill_in "Qty", with: "1"
		click_button "Create Item"
		expect(page).to have_content("My new item")
		expect(page).to have_content("1")
		expect(page).not_to have_content("randomness")
	end

	scenario "invalid item" do
		visit '/items/new'
		click_button "Create Item"
		expect(page).to have_content("Name can't be blank")
	end
end

feature "a user can see a list of all items" do
	before :each do
		Item.create(name: "checked item", checked: true)
		Item.create(name: "unchecked item", checked: false)
	end
	scenario "checked items appear, unchecked items do not appear" do
		visit '/items'
		expect(page).not_to have_content("unchecked item")
	end
	scenario "checked and unchecked items appear" do
		visit '/items'
		click_link "Show All"
		expect(page).to have_content("unchecked item")
	end
end
