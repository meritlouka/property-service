# README
A - Installation Steps:-


1-`docker-compose build`

2-`docker-compose up`

3- Create Database

`docker-compose run web rake db:create`

4- Migrate Database

`docker-compose run web rake db:migrate`

4- Import Properties Data base Copy properties.sql to app home dir and run

`docker exec -i homeday_db_1 psql -Upostgres  ps_development < properties.sql`

5- To excute te request

api/property/search?lng=13.4236807&lat=52.5342963&property_type=apartment&marketing_type=sell


6- To Run Specs

`docker exec -i homeday_web_1 rspec spec`


B - Heighlights:-

1- Api HTTP route:-

api/property/search?lng=13.4236807&lat=52.5342963&property_type=apartment&marketing_type=sell

2- Adding Pagination To help with huge data use with adding page and limit:-

/api/property/search?lng=13.4236807&lat=52.5342963&property_type=apartment&marketing_type=sell&page=3&limit=25

3- Use Psql earthdistance and cube extensions to calculate reduis distanse

4- SearchPropertiesService import to help in validate the input params

    include ActiveModel::Validations
    include ActiveModel::Callbacks

5- Handle Thrown errors from service in controller to modularize the code

6- Added Rspec in Spec Folder(models, service, requests)

7- Added method to order from nearest places to farthest places to help having more similar data
