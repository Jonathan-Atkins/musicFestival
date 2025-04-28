source "https://rubygems.org"
ruby "3.2.2"

gem "rails", "~> 7.1.5", ">= 7.1.5.1"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "tzinfo-data", platforms: %i[windows jruby]
gem "bootsnap", require: false
gem "jsonapi-serializer"
gem "faraday"
gem "rack-cors"

group :development, :test do
  gem "pry"
  gem "rspec-rails"
  gem "shoulda-matchers"
  gem "factory_bot_rails"
  gem "faker"
end

group :test do
  gem "simplecov", require: false
  gem "webmock"
  gem "vcr"
end
