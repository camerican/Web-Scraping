# Web Scraper example

## Gem Setup

Make sure we have our necessary gems installed via `bundle install`

## Database Setup

Now let's set up our database using good old fashioned SQL with sqlite3:

```bash
cd db
sqlite3 scraper.sqlite3 < schema.sql
sqlite3 scraper.sqlite3 < seeds.sql
```

We could test to make sure this worked by entering the database and looking around.

```
sqlite3 scraper.sqlite3
.tables
SELECT * FROM school;
```

