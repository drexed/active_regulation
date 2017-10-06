# frozen_string_literal: true

%w[active_record active_regulation pathname database_cleaner].each do |file_name|
  require file_name
end

spec_support_path = Pathname.new(File.expand_path('../spec/support', File.dirname(__FILE__)))

I18n.load_path << File.expand_path('../../config/locales/en.yml', __FILE__)
I18n.enforce_available_locales = false

ActiveRecord::Base.configurations = YAML::load_file(spec_support_path.join('config/database.yml'))
ActiveRecord::Base.establish_connection(:test)

load(spec_support_path.join('db/schema.rb'))

Dir.glob(spec_support_path.join('models/*.rb'))
   .each { |f| autoload(File.basename(f).chomp('.rb').camelcase.intern, f) }
   .each { |f| require(f) }

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) { DatabaseCleaner.start }
  config.after(:each) { DatabaseCleaner.clean }
end
