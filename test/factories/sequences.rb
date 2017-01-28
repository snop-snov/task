FactoryGirl.define do
  sequence :string, aliases: [:name, :address] do |n|
    "string-#{n}"
  end

  sequence :email do |n|
    "example-#{n}@mail.com"
  end

  sequence :phone_number do |n|
    "123-123-#{1234 + n}"
  end

  sequence :integer do |n|
    n
  end

  sequence :float do |n|
    n.to_f + 0.5
  end

  sequence :date do
    DateTime.now.to_date
  end

  sequence :file do
    Rack::Test::UploadedFile.new(Settings.schedule.file_path, 'text/csv')
  end
end
