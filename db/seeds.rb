[
  ['Dispatcher', 'dispatcher@email.com', '123456', :dispatcher],
  ['Driver_1', 'driver_1@email.com', '123456', :driver],
  ['Driver_2', 'driver_2@email.com', '123456', :driver]
].each do |name, email, password, role|
  user = User.find_or_create_by(email: email)
  user.name = name
  user.password = password
  user.role = role
  user.save
end
