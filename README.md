# Ogle

Lean Ruby bindings to OpenStack's [Glance](http://glance.openstack.org/). Exposes the Glance API endpoints in an easy to access manner. Go ahead and ogle, it's so much more than a glance.

# Why

Depending on the informaiton you want to get back, you will either receive JSON or XML. This will normalize the returned data for easy use. Plus, I was bored.

## Usage

### Bundler
  gem "ogle"

### Examples

  require "ogle"

  CONNECTION = Ogle::Client.new(
  :host => "123.456.789.101"
  )

  response = CONNECTION.resource.all
  puts response
  puts response.body
  puts response.code

  response = CONNECTION.resource.details
  puts response
  puts response.body
  puts response.code

## Compatability

ruby 1.9.2

## Testing

Tests currently only run online, but eventually I'll add [VCR](https://github.com/myronmarston/vcr) bindings to make them run offline
  $ bundle exec rake
