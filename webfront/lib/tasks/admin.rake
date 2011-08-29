def ask message
  print message
  STDIN.gets.chomp
end

def ask_password message
  print message
  system "stty -echo"
  result = $stdin.gets.chomp
  system "stty echo"
  puts

  return result
end

namespace :admin do
  desc "Create admin user"
  task :create => :environment do
    puts "Creating admin user..."
    email = ask('Email: ')
    password = ask_password('Password: ')
    password_confirmation = ask_password('Confirm password: ')

    user = User.new(email: email, password: password, password_confirmation: password_confirmation)
    user.role = "admin"
    user.save!
    puts "User created successfuly"
  end
end
