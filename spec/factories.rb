FactoryGirl.define do
	factory :user do
		name "Zack Sheppard"
		email "z@zack.io"
		password "foobar"
		password_confirmation "foobar"
	end
end