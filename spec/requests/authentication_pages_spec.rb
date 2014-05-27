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
		end

		describe "with invalid information" do
			before { click_button "Sign in" }

			it { should have_title('Sign in') }
			it { should have_selector('div.alert.alert-error') }
		end	
	end
end
