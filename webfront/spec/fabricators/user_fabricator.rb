Fabricator(:user) do
  email { Faker::Internet.email }
  password { 'secret' }
end
