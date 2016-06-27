# Rails Associations

### Summary
Defining associations between models

### Getting Started

In order to get started with the task you should run following commands

To install required gems run:
`bundle install`

In order to create development database run: `bundle exec rake db:create`. That will result in creating sqlite database which is sufficient for this test

Feel free to install any gem that helps you with the development process.


### Goal

First part is to create **Post**, **Image**, and **Video** models which should be commentable which means that a **Comment** can be added to each of those resources.
Post, Image, and Video should have multiple comments while each comment needs to be related with only one resource.

Second Part is to model the associations between Post, Image and Video. Image and Video *medium* can belong to a Post. We also want the post record to be able to fetch all related *post_media* by calling `@post.post_media`.

Models requirements:

* Post - **body** and **title** attributes should be present
* Comment - **body** should be present
* Image, Video - attributes: **name**, **url** and **description**

Genereate proper migration files and create models required to setup such relationships to the task.


**You can make changes only to app, lib and db directories**

### Verify your solution

Migrate database:
`bundle exec rake db:migrate`

Prepare test database: `bundle exec rake db:test:prepare`

Execute test suite and verify your solution:
 `bundle exec rspec`
