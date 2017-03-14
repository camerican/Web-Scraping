# spider.rb

require 'open-uri'
require 'nokogiri'
require 'sqlite3'

# rather than use an ORM like ActiveRecord, 
# we can just use sqlite3 directly:
# open connection to database
$db = SQLite3::Database.new "db/scraper.sqlite3"

# by default, sqlite3 will return results as an array
# rather than a hash, so we will want to keep track 
# of column positions...
$col_school = %w(id name url_source url_school)
$col_school_capture = %w(school_id batch applicants acceptance_rate sat_reading_lo sat_reading_hi sat_math_lo sat_math_hi sat_writing_lo sat_writing_hi act_lo act_hi selectivity_rating deadline_early deadline_late)

# this is another reason why using an ORM can be helpful
# as it would allow us to avoid managing this ourselves

# now let's retrieve schools for our scraper
# to get data on
$schools = $db.query("SELECT * FROM school").map do |row|
    row.each_with_index.reduce({}) do |hash,(value,index)|
      hash[$col_school[index]] = value
      hash
    end
end

# We now will want to iterate over each of the schools
# in our list and pull data from the web about them

$docs = []
$schools.each do |school|
  $docs.push Nokogiri::HTML(open(school['url_source']))
  # sleep 10 seconds before moving on
  sleep(10)
end

# to do: process the documents we've collected!

