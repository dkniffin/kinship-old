[![Build Status](https://travis-ci.org/dkniffin/kinship.svg?branch=master)](https://travis-ci.org/dkniffin/kinship)
[![Code Climate](https://codeclimate.com/github/dkniffin/kinship/badges/gpa.svg)](https://codeclimate.com/github/dkniffin/kinship)
[![Test Coverage](https://codeclimate.com/github/dkniffin/kinship/badges/coverage.svg)](https://codeclimate.com/github/dkniffin/kinship)
Kinship
=======
Kinship is a Ruby on Rails application for managing and displaying genealogical data.

Installation
============
For development:

````
git clone git@github.com:dkniffin/kinship.git
cd kinship
bundle install
rake db:setup
rake import:gedcom[file,verbosity] # Optional
rails s
````

Then, visit [http://localhost:3000] to view the site. The db is seeded with an
admin user. email: admin@nowhere.com, pw: kinship
