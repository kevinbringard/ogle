# Ogle

> Go ahead and ogle, it's so much more than a glance.

Lean Ruby bindings to OpenStack's [Glance](http://glance.openstack.org/). Exposes the Glance API endpoints in an easy to access manner.

# Why

Depending on the call you make, glance will sometimes return JSON and others XML. This will normalize the returned data for easy use. Plus, I was bored.

## Usage

### Bundler

    gem "ogle"

### Examples

    require "ogle"

    CONNECTION = Ogle::Client.new(
      :host => "example.com"
    )

    # This will give a list of all the images
    response = CONNECTION.images.all
    puts response

    # This will give a detailed list of all the images
    response = CONNECTION.images true
    puts response

    # This will return headers for a specific image as a hash
    response = CONNECTION.images.find 6
    puts response

## Compatability

ruby 1.9.2

## Testing

    $ bundle exec rake

## TODOs

* Image#all should return all public/runnable images.
  See lib/nephophobia/image.rb#pubic?
