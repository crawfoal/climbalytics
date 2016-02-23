# Factories
Each model should have a "base" factory that contains only what is needed to create a valid record. This factory is typically named the same as the model. To define additional attributes and associations beyond what is required for a valid record, use traits, transient attributes, and other functionality provided by FactoryGirl. These tools are described in their [Getting Started][1] guide, which you should read before modifying any of these factories (you might want to watch the [RailsCast][4] first).

## Resources
* **[Factories not Fixtures][4]** RailsCast
* **[Getting Started][1]** guide
* **[Using FactoryGirl to easily create complex data sets in Rails][2]**  
  Discusses how to use transient attributes, traits, and callbacks.
* **[FactoryGirl Tips and Tricks][3]**  
  I'm not sure how I feel about some sections of this, but the following sections are really good
  * *Use Traits for Modular Factories* - traits are to factories as mixin modules are to classes
  * *Use Aliases* - use aliases to make code cleaner when association names don't match model names
  * *Allow Setting up Common Associations* - use traits to set up common associations
  * *Test for Explicit Values* - your specs should define explicit attribute values when you're testing for their presence; note that this doesn't mean *every* spec/test should define an explicit value (in fact you should avoid it when possible)  
  * *Do Not Use Dynamic Values by Default*
  * *Do Not Manually Create Associations*  
* **[Rails Testing Antipatterns: Fixtures and Factories][5]**

[1]: http://www.rubydoc.info/gems/factory_girl/file/GETTING_STARTED.md
[2]: http://blog.thefrontiergroup.com.au/2014/12/using-factorygirl-easily-create-complex-data-sets-rails/
[3]: http://arjanvandergaag.nl/blog/factory_girl_tips.html
[4]: http://railscasts.com/episodes/158-factories-not-fixtures?autoplay=true
[5]: https://semaphoreci.com/blog/2014/01/14/rails-testing-antipatterns-fixtures-and-factories.html
