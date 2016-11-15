[![Version](https://badge.fury.io/gh/dkniffin%2Fkinship.svg)](https://badge.fury.io/gh/dkniffin%2Fkinship)
[![Build Status](https://travis-ci.org/dkniffin/kinship.svg?branch=master)](https://travis-ci.org/dkniffin/kinship)
[![Code Climate](https://codeclimate.com/github/dkniffin/kinship/badges/gpa.svg)](https://codeclimate.com/github/dkniffin/kinship)
[![Coverage Status](https://coveralls.io/repos/github/dkniffin/kinship/badge.svg?branch=master)](https://coveralls.io/github/dkniffin/kinship?branch=master)
[![Repo Size](https://reposs.herokuapp.com/?path=dkniffin/kinship)](https://github.com/ruddfawcett/reposs)
[![License](https://img.shields.io/badge/license-BSD%203-blue.svg)](https://github.com/dkniffin/kinship/blob/master/LICENSE.txt)
[![Gitter](https://badges.gitter.im/KeitIG/museeks.svg)](https://gitter.im/dkniffin/kinship)

# Kinship

Kinship is a Ruby on Rails application for managing and displaying genealogical data. It is inspired by [webtrees](https://www.webtrees.net)

## Installation
### Pre-requisites

Before installing Kinship, you'll need the following:
- Postgresql
- Ruby

### Install

````
git clone git@github.com:dkniffin/kinship.git
cd kinship
bundle install
cp config/database.example.yml config/database.yml
rake db:setup
rails s
````

Then, visit [http://localhost:3000] to view the site.

The db is seeded with an admin user:
email: `admin@nowhere.com`
pw: `kinship123`
