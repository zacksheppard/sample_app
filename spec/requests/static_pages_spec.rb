require 'spec_helper'

describe "Static Pages" do
	describe "Home page" do
		it "should have the content 'Sample App'" do
			visit '/static_pages/home'
			page.should have_selector('h1', :text => 'Sample App') 
		end

		# it "should have the right title" do
		# 	visit '/static_pages/home'
		# 	page.should have_selector('title', :text => 'Ruby on Rails Tutorial Sample App | Home') 
		# end
	end 

	describe "Help Page" do
		it "should have the content 'Help' and FAQs" do
			visit '/static_pages/help'
			expect(page).to have_selector('h1', :text => 'Help Page') 
		end

		# it "should have the right title" do
		# 	visit '/static_pages/help'
		# 	expect(page).to have_selector('title', :text => "Ruby on Rails Tutorial Sample App | Help") 
		# end
	end

	describe "About Page" do
		it "should have the content 'About us'" do
			visit '/static_pages/about'
			expect(page).to have_selector('h1', :text => 'About us') 
		end
		
		# it "should have the right title" do
		# 	visit '/static_pages/about'
		# 	expect(page).to have_selector('title', :text => "Ruby on Rails Tutorial Sample App | About") 
		# end
	end

	describe "Contact Page" do
		it "should have the content 'Contact us'" do
			visit '/static_pages/contact'
			expect(page).to have_selector('h1', :text => 'Contact us') 
		end
		
		# it "should have the right title" do
		# 	visit '/static_pages/about'
		# 	expect(page).to have_selector('title', :text => "Ruby on Rails Tutorial Sample App | Contact") 
		# end
	end
end
