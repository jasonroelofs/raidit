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
