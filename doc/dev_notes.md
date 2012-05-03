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
