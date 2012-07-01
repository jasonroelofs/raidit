Developer Notes
===============

As this project is a tool for experimenting with lots of different technologies, I'm going to keep a list of what I've tried and learned here.

Persistence
-----------

The first experiment is around persistence and the known patterns for abstracting it away from your Domain models.

## Repository

The Repository pattern has an explicit object that does the Domain Model => Persistence mapping, and exposes methods to query and modify data. This is the first pattern I played with

I'm not liking how many objects this is requiring me to make, a new Repository for every data model I want to handle. While it's easy to see in the code what is getting called and when, it feels like too much work for what you gain, particularly given that we're working in Ruby.

## Data Mapper

Not to be confused with the data_mapper gem, Data Mapper is another PoEEA pattern on abstracting persistence from the data models. The main benefit of this pattern, if I'm reading things right, is that the persistence abstraction is hidden and as best as possible, automaticly handled underneath.

## Repository IOC

So after a ton of reading and discussing about the Repository and Data Mapper patterns, I came to the conclusion that in the end the two are very, very similar, and I have now, using Ruby, have implemented what's more of an Inversion of Control setup, where I have a top level Repository object, the app will query this object for the appropriate Repository implementation for the given Domain model (e.g. Data Mapping to a Repository, for a link to the above discussions). This is working out really well and lets me work on the app without worrying about repository interfaces or implementations. As the tests and code build, the interface to the repositories in question will grow into what they need to be!


API Design and Structure
------------------------

As said in the README, I'm trying to follow the Interactor / Entity design that Uncle Bob Martin talked (well, raved) about in his Midwest Ruby Conf talk. The basic gist is the following:

  * Interactors are the public API of the application. All actions go through them
  * Interactors know about Entities
  * Interactors can get Entities through the Repository interface (so persistence is an afterthought)
  * Entities do not know about Interactors OR Repositories
  * All business-specific logic goes in Interactors
  * All non business-specific logic goes in the Entities

That's all well and good, but it's a bugger of a thing to find someone who's actually *done* this and released their code for all to see and learn from. This is goal #1 of my work here, to give people something to look at.

On top of this, I've taken on the mantra that "Everything I've done with Rails up to now is wrong". Yes it's an extreme position, but I need this hard line to ensure I evaluate every design decision I'm making to be sure I'm doing what I feel is right instead of what I know and am comfortable with. I fully expect to come back to the center quickly enough, where a lot of Rails stuff is good and I'll find out what really doesn't work.

From that, I haven't even included Rails at all in the application yet, and I don't plan to for a while. On top of helping with the first point, where I'm forced to rethink and reimplement everything I need, it also ensures that I think hard about the application first and ignore all web-side and persistence-side details for now.

On to details!

## Implementing Interactors

Nothing is more important than managing dependencies of these things. With that, I'm putting in place the rule that no Interactor constructor or method will take a hash. Hashes-as-keyword-arguments leads to laziness and hides pain related to long parameter lists. If parameters are getting painful, there's a problem with the design.

I started going the exact opposite: no parameters at all. Everything was done through setters:

``` ruby
action = UpdateSignup.new
action.current_user = user
action.action = :enqueue
action.signup = signup

action.run
```

This makes it very obvious what the action needs, but I felt that it put too much of the burden of Doing It Right on the user of the action instead of letting Ruby handle the requirements. It also required a bunch of developer-style error handling that warned if a given value wasn't set before #run was called. This felt cumbersome for the few actions implemented already.

So I changed to using parameters. My new rule is that all "current state" values go in the constructor, and all action-specific parameters are given to #run. Like so:

``` ruby
action = UpdateSignup.new current_user, signup
action.run :enqueue
```

Now it's still just as easy to see what values are required, but it now also documents which ones are exactly required, and with this I was able to remove the ugly developer error handling entirely, leading to less, cleaner code. So yeah, use parameters, that's what they're there for, and let them tell you when dependencies are getting untennable. Also, when Ruby 2.0 comes out with named parameters (possibly), they'll just work.


Front End vs API
----------------

I started this project without any framework, any system at all to build on. I put together a number of use cases, fleshed out the details of these cases and started implementing Interactors that implemented these use cases. Thus, the application is pure Ruby and only plain Ruby. This also has the side effect that tests are really, really fast.

Unfortunately this is *really* hard to develop with. I'm used to top-down driven development, where the UI drives which features I implement next. Now that I have a few interactors implemented and a basic structure for how to create others, I'm going to pull Rails into the app and start implementing a UI, and from that driving which features I implement next.

The main rule for the Rails side is that Rails controllers have as little logic as possible. They get information from the user, run the interactors, and return the results. That's it.

Also I won't be including a database yet. I don't know what my data structure needs to be.

2012-06-30: Another point for full Top-Down development: I just refactored the SignUpToRaid to no longer assume that it is going to be given the Raid and Character objects, but to find those objects for itself. When trying to integrate the existing interactor into the Rails stack, I found that I would need to create new interactors just for finding these objects, and potentially duplicating logic. When stepping back I realized that I'm giving the Controller too much reponsibility here, and realized that I can let the Interactor handle everything.

Mocking
-------

Moching is a tough topic. On one hand, you can mock everything that's not your current object. On the other hand, you can choose to mock nothing at all and just ensure that all objects are set up appropriately. There are problems with both of these approaches. If you mock too much, you've made your tests very coupled to your code's implementation, and have set yourself up to making tests hard to maintain, as well as the situation where changing your code still passes all tests, but when run the code dies horribly, because all calls to dependencies have been mocked out and you missed a changed dependency call. On the contrary, never mocking anything can lead to forcing tests in one area to know about intimate data details about other code for the code under test to properly work, leading to messy test setup requirements. Both of these situations are serious test smell, though the "no mocks ever" make it easy to see where the test pain is very quickly.

My main rule with raidit is to not mock objects I own. This is starting to get tricky as I implement controllers as I'm finding myself needing to set up multiple objects in the Repository for controllers to be able to use certain interactors. This goes against the whole "Rails is simply a user of your application" ideal. In this case I will start playing with mocking out interactor usage in the controllers, aka the Rails app does not own the Application, so I can mock the interaction. To protect myself from mock tests passing but the code itself failing, I shall start putting together a cucumber (Rack::Test) suite that hits the site proper to ensure that things are hooked up properly.
