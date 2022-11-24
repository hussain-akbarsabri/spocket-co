# Poject Name
Spocket CO

# Description

The following are the endpoints that are supported
- Endpoint to receive a list of customers data.
- Will store the address for each customer after finding it.

# System Architecture

- An endpoint to accepts a list of customers having zip-code as JSON.
- In a background worker, it will find the address for each customers whose address is not yet stored.

Advantages:
- Faster API's
- consistence results

Drawbacks:
- More dependency on viacep API

# Stack

* [Ruby](https://www.ruby-lang.org/en/)
* [Ruby on Rails](https://rubyonrails.org/)
* [RSpec](https://github.com/rspec/rspec-rails)


------------

## Getting Started

To get a local copy up and running follow these simple steps.

### Prerequisites

* `ruby 3.1.2`
* `rails 7.0.4`

### Installation

1. Extract the repo
2. Install the gems
`bundle install`
3. Start the server
`rails s`
4. Send the list
