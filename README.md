# Mailigen

API wrapper for mailigen.com .

## Installation

Add this line to your application's Gemfile:

    gem 'mailigen'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mailigen

## Usage

    require "mailigen"

    mailigen = Mailigen::Api.new YOUR_MAILIGEN_API_KEY
    mailigen.call :ping # returns "Everything's Ok!" if API KEY is correct

## Testing

Gem using RSpec tests. You must add spec/keys/api.yml:
    
    mailigen:
      api_key: "YOUR_MAILIGEN_API_KEY"

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
