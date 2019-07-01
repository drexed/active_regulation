# ActiveRegulation

[![Gem Version](https://badge.fury.io/rb/active_regulation.svg)](http://badge.fury.io/rb/active_regulation)
[![Build Status](https://travis-ci.org/drexed/active_regulation.svg?branch=master)](https://travis-ci.org/drexed/active_regulation)

**NOTE** ActiveRegulation has been deprecated in favor of [Lite::Regulation](https://github.com/drexed/lite-regulation). Its a drop-in replacement, so please make the switch as soon as possible.

ActiveRegulation is a library for commonly used record states.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'active_regulation'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install active_regulation

## Table of Contents

* [Methods](#methods)
* [Usage](#usage)

## Methods

**Modules:**
 * `activation`
 * `containment`
 * `expiration`
 * `quarantine`
 * `suspension`
 * `visibility`

**Attributes:**
 * `:inactivated_at`
 * `:contained_at`
 * `:expires_at`
 * `:invisible_at`
 * `:quarantined_at`
 * `:suspended_at`

```ruby
class User < ActiveRecord::Base

  # Add one of the datetime attributes
  # above to the corresponding table.

  include ActiveRegulation::Containment

end
```

## Usage
```ruby
user.active?       #=> true
user.inactive?     #=> false

user.inactive!
user.active?       #=> false

user.active!
user.active?       #=> true

user.to_activation #=> 'Active'

User.active        #=> retrieves all active records
User.inactive      #=> retrieves all inactive records
```

## Contributing

Your contribution is welcome.

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
