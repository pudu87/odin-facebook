## Odin Facebook

_A clone of Facebook as final project of the Rails course._

* Check it out [here](https://polar-stream-93232.herokuapp.com/)
* From The Odin Project's [curriculum](https://www.theodinproject.com/paths/full-stack-ruby-on-rails/courses/ruby-on-rails/lessons/final-project)

### Features

* Basic facebook functionality:
  * Posts (editable, deletable)
  * Comments (deleteable)
  * Liking and Unliking Posts
  * Profile (editable)
  * Adding and removing Friends
* Uploading pictures for Posts or Profile
* User authentication with Devise
* Authentication through the real Facebook with Omniauth

### Issues

I had no account/plan for Amazon S3 and SendGrid at the time of constructing this app. Hence,
* Any uploaded pictures will not be saved persistently
* Mailing service is only functioning locally
