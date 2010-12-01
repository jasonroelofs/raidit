require 'factory_girl'

Factory.define(:user) do |f|
  f.email { "user@raidit.org" }
  f.password { "testingzoo" }
  f.password_confirmation { |f| f.password }
  f.role { "user" }
end

Factory.define(:character) do |f|

end
