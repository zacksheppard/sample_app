require 'spec_helper'

describe "Authentication" do
	subject {page}

	describe "Signin page" do
		before { visit signin_path }
		it { should have_content('Sign in') }
		it { should have_title('Sign in') }

		#it { should have_selector('div.alert.alert-error')}

		describe "with valid info" do
			let(:user) {FactoryGirl.create(:user)}
			before do
				fill_in "Email", with: user.email.upcase
				fill_in "Password", with: user.password
				click_button "Sign in"
			end

			it {should have_link('Profile', href: user_path(user))}
			it {should have_title(user.name)}
			it {should_not have_link('Sign in', href: signout_path)}
			it {should have_link('Settings', href: edit_user_path(user))}

		end

		describe "with invalid information" do
			before { click_button "Sign in" }

			it { should have_title('Sign in') }
			it { should have_selector('div.alert.alert-error') }
		end	
	end

	describe "authorization" do 
		describe "for non-signed-in users" do
    		let(:user) { FactoryGirl.create(:user) }

      		describe "in the Users controller" do

		        describe "visiting the edit page" do
		          	before { visit edit_user_path(user) }
		          	it { should have_title('Sign in') }
		        end

		        describe "submitting to the update action" do
		          before { patch user_path(user) }
		          specify { expect(response).to redirect_to(signin_path) }
        		end
      		end

    	end

    	describe "edit as wrong user" do
    		let(:user) { FactoryGirl.create(:user) }
    		let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
    		before {sign_in user, no_capybara: true}

    		describe "submitting a GET req to the Users#edit action" do 
    			before { get edit_user_path(wrong_user) }
        		specify { expect(response.body).not_to match(full_title('Edit user')) }
        		specify { expect(response).to redirect_to(root_url) }
     		end
   	 	end
	end

	describe "index" do
	    before do
	      sign_in FactoryGirl.create(:user)
	      FactoryGirl.create(:user, name: "Bob", email: "bob@example.com")
	      FactoryGirl.create(:user, name: "Ben", email: "ben@example.com")
	      visit users_path
	    end

	    it { should have_title('All users') }
	    it { should have_content('All the users') }

	    it "should list each user" do
	      User.all.each do |user|
	        expect(page).to have_selector('li', text: user.name)
	    end
	end
	end
end
