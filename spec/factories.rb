FactoryGirl.define do

	factory :task do
		sequence(:title)  { |n| "task#{n}" }		
	end

	factory :invalid_task do
		title nil		
	end

	factory :user do
		sequence(:email) { |n| "valid#{n}@email.com" }
		password 'monkeyslut'
		password_confirmation { |u| u.password }

		factory :user_with_tasks do
		  after(:build) do |user|
		  	user.tasks << FactoryGirl.build(:task)
		  end
		end

	end

end

