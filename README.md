# Mailigen

[![Gem Version](https://badge.fury.io/rb/mailigen.png)](http://badge.fury.io/rb/mailigen)
[![Build Status](https://travis-ci.org/artursbraucs/mailigen.png?branch=master)](https://travis-ci.org/artursbraucs/mailigen)
[![Coverage Status](https://coveralls.io/repos/artursbraucs/mailigen/badge.png)](https://coveralls.io/r/artursbraucs/mailigen)

API wrapper for mailigen.com .

## Installation

Add this line to your application's Gemfile:

    gem 'mailigen'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mailigen

## Usage

Create your mailigen instance and call 'call' method. First param - API method, seconds param - parameteres (api_key included by default).

Few examples:

    require "mailigen"

    mailigen = Mailigen::Api.new YOUR_MAILIGEN_API_KEY

    # Ping to check apy key
    mailigen.call :ping # returns "Everything's Ok!" if API KEY is correct

    # Creates a list
    list_id = mailigen.call :listCreate, {title: "testListRspec", options: {permission_reminder: "Your in", notify_to: "foo@bar.com", subscription_notify: false}}

    # Adds extra var to list
    mailigen.call :listMergeVarAdd, {id: list_id, tag: "NAME", name: "Name of user"}

    # Adds contacts batch to list
    contacts_array_hash = {
      "0" => {EMAIL: "foo@sample.com", EMAIL_TYPE: 'plain', NAME: 'Foo'}, 
      "1" => {EMAIL: "bar@sample.com", EMAIL_TYPE: 'html',  NAME: 'Bar'}, 
      "2" => {EMAIL: "foo@sample.com", EMAIL_TYPE: 'html',  NAME: 'Foo Dublicate'}
    }
    
    resp = mailigen.call :listBatchSubscribe, {id: list_id, batch: contacts_array_hash, double_optin: false}

    puts resp["success_count"] # Output should be 3

For more: [Mailigen API documentation](http://dev.mailigen.com/display/AD/API+Documentation)

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
