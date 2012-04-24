Raid.it
=======

The guild raiding and events calandar.

Technical
---------

To understand the design ideas in this code, please first watch Uncle Bob Martin's talk on "Architecture: The Lost Years"

http://www.confreaks.com/videos/759-rubymidwest2011-keynote-architecture-the-lost-years

The current structure is:

* app/models -- Domain models
* app/interactors -- Action objects
* app/respositories -- Repository interfaces for the domain models
* app/data_stores -- Data persistence implementations used by repositories

The public API of this application is to be the Interactors. Everything that needs to be done gets done through an Interactor.