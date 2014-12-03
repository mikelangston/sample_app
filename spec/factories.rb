Factory.define :user do |user|
	user.name 					"Test User"
	user.email 					"test@example.com"
	user.password 				"changeMe"
	user.password_confirmation	"changeMe"
end