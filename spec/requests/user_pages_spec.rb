require 'spec_helper'

describe "User pages" do
	subject { page }

	describe "signup page" do
		before { visit signup_path }
		it { should have_content('Sign up') }
		it { should have_title(full_title('Sign up')) }
    end

    describe "signup" do
    	before {visit signup_path}

    	let(:submit) {"Create my account"}

    	describe "with invalid information" do
    		it "should not create a user" do
    			expect {click_button submit}.not_to change(User, :count)
    		end
    	end

    	describe "with valid info" do
    		before do
    			fill_in "Name",			with: "Example User"
    			fill_in "Email",		with: "user@example.com"
    			fill_in "Password",		with: "foobar"
    			fill_in "Confirm password",	with: "foobar"
    		end

    		it "should create a user" do
        		expect { click_button submit }.to change(User, :count).by(1)
        	end
        end
    end

	describe "profile page" do
		let(:user) {FactoryGirl.create(:user)}
		before {visit user_path(user)}

		it {should have_content(user.name)}
		it {should have_title(user.name)}
	end

    describe "edit" do
        let(:user) {FactoryGirl.create(:user)}
        before do 
            sign_in user
            visit edit_user_path(user)
        end

        describe "page" do
            it { should have_content('Update your profile') }
            it { should have_title(full_title('Edit')) }
            it { should have_link('change', href: 'http://gravatar.com/emails')}
        end

        describe "with valid information" do
            let(:new_name) {"New name"}
            let(:new_email) {"new@example.com"}
            before do
                # fill_in "Name",         with: new_name
                fill_in "Email",        with: new_email
                fill_in "Password",     with: user.password
                fill_in "Confirm password", with: user.password
                click_button "Save changes"
            end

            
            it { should have_selector('div.alert.alert-success')}
            it {should have_link('Sign out', href: signout_path)}
        end
    end
 end
