# A Comparison of Different Ways to Generate Sample Data
### *February 16, 2016*

## Modify Test Factories
The test factories (those defined in `spec/factories`) contain just the bare minimum needed in order to create valid records. One option is to supplement these factories. FactoryGirl has functionality to open and modify existing factories. We would do this in files that would only be loaded during the rake task that generates the data, and we already have the specs for this task's helpers isolated from the other specs, so we wouldn't be affecting any other tests.

Things I don't like about this approach:
* specifying the number of records to be created could get a little messy
* we'd have to define a lot traits in order to get all of the associated records created, or we'd have to create bottom up (starting with the most deeply nested record) and that is just weird
* we wouldn't get the benefit of the rich inheritance functionality that comes with Ruby classes; factories have inheritance as well, but it isn't as rich / complete (e.g. no super)

## Create Generator Classes
This idea is a lot like what I had previously, but there would be a couple key differences. For one, the classes would create records via FactoryGirl, not from scratch.

The previous approach required that you pass in the parent model(s) when creating child records, and I didn't like this (but I'm not really sure why...). This could be avoided by creating the top level records first, and then when you create lower level records, you could loop over the existing parent records, or grab random records, or some combination. This could get a little tricky though - the test factories already define some associations by default. It would be a pain to pass in nil for every predefined factory (and if you don't, then an extra parent record would get created every time). One option would be to combine this with the above approach and modify the factories to not define any associations. This sounded kind of like a nice idea at first, but now that I think about it more, I don't think I like this idea either. For one, I think it will be annoying to have to remember to do this every time you create a new model who's test factory has an association defined by default. And it kind of just feels messy.

## Create Factories Specifically for Data Generation
These could inherit from the test factories, or not.

With test factories, we create the minimum data needed for the record to be valid. These data generation factories would be completely different - we would create data in a way that resembled real-world data.

If at some point we wanted to remove `Faker` from our factories, this approach would make that possible.

Downsides to this approach:
* If we don't inherit from existing factories, we could have quite a bit of code duplication.
* Inheritance could have a weird feel to it because the test factories were created for a different use case.
* It isn't clear where we'd define how many records of each type should be defined. Also will there be helper modules or classes? If not, how will we test? We probably don't want to only be able to test the rake task; we want to be able to test subcomponents of it. Will those subcomponents be modules, classes, or just the factories themselves?

Could we have a configurations file of some sort? The factory definitions could just read from this file, and the numbers of records and stuff would then be defined in one place.

Maybe at first we could just call FactoryGirl methods in the rake task. Or have one module that defines broad generator methods like `generate_user_data` and `generate_gym_data` and these methods would create all corresponding children records.
