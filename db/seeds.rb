[
  ['Dispatcher', 'dispatcher@email.com', '123456', :dispatcher],
  ['Driver_1', 'driver_1@email.com', '123456', :driver, 1],
  ['Driver_2', 'driver_2@email.com', '123456', :driver, 2]
].each do |name, email, password, role, shift|
  user = User.find_or_create_by(email: email)
  user.name = name
  user.password = password
  user.role = role
  user.shift = shift
  user.save
end
