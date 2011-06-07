# Ogle

> Go ahead and ogle, it's so much more than a glance.

Lean Ruby bindings to OpenStack's [Glance](http://glance.openstack.org/). Exposes the Glance API endpoints in an easy to access manner.

# Why

Depending on the call you make, glance will sometimes return JSON and others XML. This will normalize the returned data for easy use. Plus, I was bored.

## Usage

### Bundler

    gem "ogle"

### Examples

Please see the examples wiki here: https://github.com/kevinbringard/ogle/wiki/Examples

## Compatability

ruby 1.9.2

## Testing

Add glance.trunk to your hosts file.

    $ bundle exec rake

## TODOs

* Implement write functionality (POST/PUT)
