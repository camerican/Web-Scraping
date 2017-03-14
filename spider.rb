# spider.rb
# This spider has been set to process data
# from the Princeton review.  We've preloaded
# two schools and will run a batch to capture
# data about each school
require 'open-uri'
require 'nokogiri'
require 'sqlite3'

# rather than use an ORM like ActiveRecord, 
# we can just use sqlite3 directly
# ref: http://www.rubydoc.info/github/luislavena/sqlite3-ruby/SQLite3/Database

# open connection to database
$db = SQLite3::Database.new "db/scraper.sqlite3"
# we'd prefer if results are returned as a hash
$db.results_as_hash = true

# each time we run our script, we'll refer to 
# this as a "batch." So, we'll want to figure out
# what the current batch number should be by
# looking into our database and finding the 
# largest batch that has previously been recorded
$batch = ($db.get_first_value("SELECT MAX(batch) FROM school_capture;") || 0) + 1

# now let's retrieve schools for our scraper
# to get data on
$schools = $db.query("SELECT * FROM school;")

# We now will want to iterate over each of the schools
# in our list and pull data from the web about them

$docs = []
$schools.each do |school|
  $docs.push Nokogiri::HTML(open(school['url_source']))
  # sleep 10 seconds before moving on
  sleep(10)
end

# to do: process the documents we've collected!
# ref: http://www.nokogiri.org/tutorials/searching_a_xml_html_document.html
$docs.each do |doc|
  
end

