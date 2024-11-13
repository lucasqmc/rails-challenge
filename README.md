# README

## Description

Ruby on Rails project for challenge


To download the images and prepare the containers, run the following command:

`docker-compose build --no-cache`

Start the containers in the foreground:

`docker-compose up` 

Creates the database and runs the migrations:

`docker exec rails-challenge sh ./init.sh`


Access the container via bash session:

`docker exec -ti rails-challenge bash`

## Generate Shortened URLs:

Use the following curl command to create a short URL:

`curl --location 'http://localhost:3000/url_shortener' \
--header 'Content-Type: application/json' \
--data '{"url": "https://example.com/your-long-url"}'`


This returns a shortened link hash for your URL.

## Redirect Using Shortened URL:

Open http://localhost:3000/{hash_link} in the browser (replace {hash_link} with the returned hash) to be redirected to the original URL.

## View Top 100 Links:

Run the following command to see the top 100 most accessed links:

`curl --location --request GET 'http://localhost:3000/top_100_urls' \
--header 'Content-Type: application/json'`



