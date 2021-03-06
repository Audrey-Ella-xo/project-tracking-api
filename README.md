<!--
*** Thanks for checking out this README Template. If you have a suggestion that would
*** make this better, please fork the repo and create a pull request or simply open
*** an issue with the tag "enhancement".
*** Thanks again! Now go create something AMAZING! :D
-->

<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]

<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://github.com/Audrey-Ella-xo/project-tracking-api">
    <img src="https://raw.githubusercontent.com/euqueme/toy-app/master/app/assets/images/mLogo.png" alt="Logo" width="80" height="80">
  </a>

  <h3 align="center">Project Tracker API Final Capstone project</h3>

  <p align="center">
    This project is part of the Microverse Ruby on Rails curriculum!
    <br />
    <a href="https://github.com/Audrey-Ella-xo/project-tracking-api"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/Audrey-Ella-xo/project-tracking-api/issues">Report Bug</a>
    ·
    <a href="https://github.com/Audrey-Ella-xo/project-tracking-api/issues">Request Feature</a>
  </p>
</p>

<!-- TABLE OF CONTENTS -->
## Table of Contents

* [About the Project](#about-the-project)
  * [API Development Guidelines and Timelines](#api-development-guidelines-and-timelines)
  * [Documentation](#documentation)
  * [Getting Started](#getting-started)
  * [Prerequisites](#prerequisites)
  * [Setup](#setup)
  * [Usage](#usage)
  * [Run Test](#run-test)
  * [Deployment](#deployment)
  * [Built With](#built-with)
* [Authors](#authors)
* [Contributing](#contributing)
* [Show your support](#show-support)
* [Acknowledgements](#acknowledgements)
* [License](#license)

<!-- ABOUT THE PROJECT -->
## About The Project

![screenshot](app/assets/images/project-index.png)

This is a tracker API, and has been given an individual theme to keep track of item todos of the projects, created by a loged in user. Only the administrator can manage the projects.

This is the final Capstone project of the Microverse Curriculum.

---
### API Development Guidelines and Timelines

| TIMELINE    |  TODO  |  DESCRIPTION  |    OUTCOME   |  STATUS   |
| :---        | :----: |    :----:     |    :----:    |  :----:   |
| Day 1       | Learn Rails API framework | Obtain leads, knowledge and the syntax necessary for the development of the API.| Understanding Rails API framework.|&#9745;|
| Day 2       | API Design | Design the API by designing the Entity relationship, set up the repository and tools, start building the basic functionality of the project and test the basics using Postman |  Set objectives for remaining days. |&#9745;|
| Day 3       |API Development| API Development following the defined design, as well as add user authentication and unit testing|  API Logic             |&#9745;|
| Day 4       |API Testing| Do a thorough Test of the completed API |  API Testing        |&#9745;|
| Day 5       |API Documentation| API Documentation following the defined design|  API Documentation |&#9745;|
---

### Documentation

The documentation was built using raddocs.

### Getting Started

To get a local copy up and running follow these simple example steps.

### Prerequisites

Ruby: 2.7.0
Rails: 6.0.3

### Setup

Install gems with:

```
bundle install
```

Setup database with:

```
rails db:migrate
```

### Usage

Start server with:

```
rails server
```

Install the HTTP client of your preference to use it, I used [httpie](https://httpie.org/)

#### Signup

The following command will create an login a new user in the database

```bash
$ http :3000/signup name=audrey email=audrey@email.com password=foobar password_confirmation=foobar
```

![screenshot](app/assets/images/signup.png)

#### Login

projects Log in with their email and password

```bash
$ http :3000/auth/login email=audrey@email.com password=foobar
```

![screenshot](app/assets/images/login.png)

#### Create Project

to create a new Project you first have to create an admin user to do that you have to do the following:

Open a rails console and update the user you want to set as admin this way:

```bash
$ rails c
> User.find_by(email: 'audrey@email.com').update(admin: true)
> exit
```
![screenshot](app/assets/images/user-admin.png)

After that you have to first login the user and copy the auth_token somewhere

```bash
$ http :3000/auth/login email=audrey@email.com password=foobar
```
![screenshot](app/assets/images/login.png)

Finally we'll create a new project this way (paste the auth_token in the Authorization header)

```bash
$ http :3000/projects name=Squats description=Squating created_by='1' \
Authorization:'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1OTEzMzMzOTl9.XLb1MX7E4293U6GzUi_lFxxBmAMcAZpcmapO7h8X92E'
```
![screenshot](app/assets/images/project-index1.png)

#### Non-admin Project Creation

If a non admin user attempts to create, update or destroy a project, they get the following error

![screenshot](app/assets/images/non-admin-error.png)

#### Projects index

To see all the projects created in the database you don't need to be logged in just type the following command

```bash
$ http :3000/projects
```
![screenshot](app/assets/images/project-index.png)

#### Projects show

No authentication is needed to see an specific project

```bash
$ http :3000/projects/50
```

![screenshot](app/assets/images/project-show.png)

#### Create Todo 

To create a todo an user has to be logged in and that user can only create his/her own todo

Login the user (admin or not) and copy the auth_token somewhere
```bash
$ http :3000/auth/login email=audrey@email.com password=foobar
```
![screenshot](app/assets/images/login.png)

Now we'll paste it in the Authentication header for creating todo

```bash
$ http :3000/projects/50/todos title=petitions progress=10 \
Authorization:'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJleHAiOjE1OTQ0OTE0Nzd9.QkhAKA-Oft6reyvCw5tGHgLkD6bRDpsWb_iKX8tef6s'
```
![screenshot](app/assets/images/todo-creation.png)

#### Wrong user Creation

If a user attempts to modify a todo item or todo that they don't own, they get the following error

![screenshot](app/assets/images/wrong-user-todo-creation.png)

#### All Todos

To see all the todos a user must be logged in and its only possible to see the todos created by the logged in user, we'll use the same authentication as the step before

```bash
$ http :3000/projects/50/todos Authorization:'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJleHAiOjE1OTQ0OTE0Nzd9.QkhAKA-Oft6reyvCw5tGHgLkD6bRDpsWb_iKX8tef6s'
```
![screenshot](app/assets/images/project-todo-index.png)

#### Show Todo

Same as the step before only difference is we have to specify the todo id just like we did in the Project one

```bash
$ http :3000/projects/50/todos/57 Authorization:'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJleHAiOjE1OTQ0OTE0Nzd9.QkhAKA-Oft6reyvCw5tGHgLkD6bRDpsWb_iKX8tef6s'
```
![screenshot](app/assets/images/show-todo.png)

#### Create Items 

To create a todo item, a user has to be logged in and that user can only create his/her own todo-item.

Login the user (admin or not) and copy the auth_token somewhere
```bash
$ http :3000/auth/login email=audrey@email.com password=foobar
```
![screenshot](app/assets/images/login.png)

Now we'll paste it in the Authentication header for creating todo-items

```bash
$ http :3000/projects/50/todos/57/items name=yetitions done=false\
Authorization:'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJleHAiOjE1OTQ0OTE0Nzd9.QkhAKA-Oft6reyvCw5tGHgLkD6bRDpsWb_iKX8tef6s'
```
![screenshot](app/assets/images/todo-item-creation.png)


#### All Items

To see all the Items a todo has, a user must be logged in and its only possible to see the items created by the logged in user, we'll use the same authentication as the step before

```bash
$ http :3000/projects/50/todos/57/items Authorization:'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJleHAiOjE1OTQ0OTE0Nzd9.QkhAKA-Oft6reyvCw5tGHgLkD6bRDpsWb_iKX8tef6s'
```
![screenshot](app/assets/images/item-index.png)

#### Delete Item

To delete an item, the user has navigate to the item and use the delete action with an authentication. We'll use the same authentication as the step before

```bash
$ http :3000/projects/50/todos/57/items/55 Authorization:'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJleHAiOjE1OTQ0OTE0Nzd9.QkhAKA-Oft6reyvCw5tGHgLkD6bRDpsWb_iKX8tef6s'
```
![screenshot](app/assets/images/deleted-item.png)


### Run tests

to run the test cases do:

```
bundle exec rspec
```

to update the raddocs documentation run:

```
rake docs:generate
```

- and go to localhost:3000/api_docs with your browser to get to the raddocs documentation

### Deployment

- The project raddocs documentation was deployed in [Heroku](https://boiling-cove-53950.herokuapp.com/api_docs/) 

### Built With
This project was built using these technologies.
* Ruby 2.6.3
* Rails 6.0.2.1
* Rspec
* rspec_api_documentation
* raddocs
* Rubocop
* Ubuntu 18.4+
* Stickler
* VsCode

<!-- CONTACT -->
## Authors

Audrey Emmanuella Odiaka - [@o___audrey_xo](https://twitter.com/o___audrey_xo) - [@audrey-ella-xo](https://github.com/audrey-ella-xo) - anitaudrey@gmail.com
<br />
<br />

Project [Link](https://github.com/Audrey-Ella-xo/project-tracking-api/)

## 🤝 Contributing

Contributions, issues and feature requests are welcome!

Feel free to check the [issues page](issues/).

## Show your support

Give a ⭐️ if you like this project!

<!-- ACKNOWLEDGEMENTS -->
## Acknowledgements
* [Microverse](https://www.microverse.org/)
* [Heroku](https://www.heroku.com/)
* [The Best readme Template](https://github.com/othneildrew/Best-README-Template)
* [Austin Kabiru](https://scotch.io/tutorials/build-a-restful-json-api-with-rails-5-part-one)
* [A D Vishnu Prasad](https://advishnuprasad.com/blog/2016/02/07/api-docs-using-rspecs/)
* [How to document REST APIs with Swagger and Ruby on Rails](https://medium.com/@sushildamdhere/how-to-document-rest-apis-with-swagger-and-ruby-on-rails-ae4e13177f5d)



<!-- LICENSE -->
## 📝 License

This project is [MIT](https://opensource.org/licenses/MIT) licensed.

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/Audrey-Ella-xo/project-tracking-api.svg?style=flat-square
[contributors-url]: https://github.com/Audrey-Ella-xo/project-tracking-api/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/Audrey-Ella-xo/project-tracking-api.svg?style=flat-square
[forks-url]: https://github.com/Audrey-Ella-xo/project-tracking-api/network/members
[stars-shield]: https://img.shields.io/github/stars/Audrey-Ella-xo/project-tracking-api.svg?style=flat-square
[stars-url]: https://github.com/Audrey-Ella-xo/project-tracking-api/stargazers
[issues-shield]: https://img.shields.io/github/issues/Audrey-Ella-xo/project-tracking-api.svg?style=flat-square
[issues-url]: https://github.com/Audrey-Ella-xo/project-tracking-api/issues
[product-screenshot]: /app/assets/images/projects-index.png


