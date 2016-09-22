RSpec.configure do |config|
  config.include RSpec::Rails::RequestExampleGroup, type: :request, file_path: /spec\/api/
  config.include ActiveModelSerializers::Test::Schema, file_path: /spec\/controllers\/api/
end
