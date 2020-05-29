# On Cloud Wine
Colorados favored wine collection at your disposal.


## Table of Contents
* [General Info](#general-info)
* [Inspiration](#inspiration)
* [Demonstration Video](#demonstration-video)
* [Technologies](#technologies)
* [Setup](#setup)
* [Example Code](#example-code)
* [Features](#features)
* [Status](#status)
* [Contact](#contact)
* [License](#license)


## General Info
On Cloud Wine is a CLI application for a consumer of any level to browse, select, manage, or contribute to Colorados most prominent wine selection. Add to your personal collection and open a bottle when desire strikes.

## Inspiration 
On Cloud Wine came to be due to the desire to have an application capable of browsing and storing some of Colorados favorites wines.

## Demonstration Video
[On Cloud Wine Youtube Demonstation](https://www.youtube.com/watch?v=-Xw4rSUTWnU)

## Technologies 
* Ruby - version 2.7.1
* ActiveRecord - version 6.0
* Sqlite3 - version 1.4
* TTY-prompt - version 0.21.0
* Sinatra-activerecord - version 2.0
* Colorize - version 0.8.1

## Setup 
To get On Cloud Wine installed and running clone the Github Repository into your directory and input into your terminal:
```ruby
ruby config/environment.rb
```
Followed by:
```ruby
bundle install
```
And to get the program running execute while in the project directory:
```ruby
ruby runner.rb
```

## Example Code
```ruby
  def personal_collection
    wines.reload
    system('clear')
    if !has_wines?
      empty_navigator
    else
      user_wines = wines.map do |wine|
        [wine.name, wine.vintage, wine.winery, wine.varietal, bottle_count(wine), wine.id]
      end.uniq
      table = TTY::Table.new %w[Name Vintage Winery Varietal Count ID], user_wines
      puts table.render(:ascii)
      puts ""
      collection_navigator
    end
  end
```
## Features
Current Features:
* Browse wines by color
* Browse wines by varietal
* Add wines to your personal collection
* Open bottles from your personal collection
* Add wines to the database

Future Features:
* Create a 'favorite' function
* Dynamically changing varietal lists
* Add a most owned wine varietal by type listing
* Larger Selection
* More detailed info on each wine

## Status
The application is fully functional and ready to be enjoyed at current status. Future updates and improvements are still a possibility for future renditions.

## Contact
Created by [Bryce Kennedy](https://www.linkedin.com/in/bryce-kennedy/) and [Adrian Avila](reneavila1993@gmail.com).

If you have any questions or comments feel free to reach out to us and thank you for your time.

## License 
[Click to view](https://github.com/btken88/on-cloud-wine/blob/master/LICENSE)



