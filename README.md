[![Build Status](https://travis-ci.org/oddityoverseer13/kinship.svg?branch=master)](https://travis-ci.org/oddityoverseer13/kinship)
Kinship
=======
Kinship is a Ruby on Rails application for managing and displaying genealogical data.

Installation
============
For development:

- install rails
- install postgres
- create database and user
 - kinship-dev (pw: kinship)
- `rake db:migrate` - set up the database
- `rake db:seed` - set up some default data
- Optional: import gedcom file
- `rails s` - start rails
- Go to [http://localhost:3000]
- Log in as user: admin, password: kinship

In addition, for testing:

- create database and user
 - kinship-test (pw: kinship)
- `rake db:migrate RAILS_ENV=test` - set up the database
- `rspec` - run rspec tests
