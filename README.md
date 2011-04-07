# Ogle

Lean Ruby bindings to OpenStack's [Glance](http://glance.openstack.org/). Exposes the Glance API endpoints in an easy to access manner.

# Why

Depending on the informaiton you want to get back, you will either receive JSON or XML. This will normalize the returned data for easy use. Plus, I was bored.

## Usage

### Bundler
  gem "ogle"

### Examples

I have not currently written any examples. Sorry yo, I'll get on that once the code actually works

## Compatability

ruby 1.9.2

## Testing

Tests currently only run online, but eventually I'll add [VCR](https://github.com/myronmarston/vcr) bindings to make them run offline
  $ bundle exec rake
