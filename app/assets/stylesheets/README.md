# Stylesheets

## The organization of our stylesheets

### `application.scss`
This file imports all application wide Sass and CSS files.

If there is no stylesheet for a particular controller-action combo, this is the stylesheet that will be included by the application layout.

### `base`
This folder contains Sass files that are used throughout our application, e.g. `forms.scss`, `typography.scss`, etc.

### `helpers`
This folder contains Sass partials that can be included in page specific stylesheets, e.g. `_panel_sections.scss`, a Sass partial that styles HTML `section` tags as panels.

### `pages`
This folder contains page-specific stylesheets.

Within this folder, there should be a folder for each controller, and those folders should contain stylesheets corresponding to the action name for the particular view they style. For example, `HomeController` has an action of `show` - the stylesheet for the corresponding view should be called `show.scss` and should be in the folder `stylesheets/pages/home`.

For namespaced controllers, like `Users::RegistrationsController`, just match the controller folder naming convention - the stylesheet for `Users::RegistrationsController#edit` should be called `edit.scss`, and should be in the folder `stylesheets/pages/users/registrations/edit.scss`.

It is important to follow this convention because the application layout uses the convention to determine what stylesheet to require.

## Why Sprockets require directives don't play well with Sass imports

In a default Rails application, the `application.scss` file includes these lines:

```scss
*= require_self
*= require_tree
```

When assets are compiled, the first line takes the contents of the `application.scss` file itself and inserts them at the top, and then the second line inserts the contents of every file in the stylesheets directory below the contents of `application.scss`. These directives come from the `sprockets` gem.

When using these directives, each file that is included via that `require_tree` must be self-contained, that is they can't access any information outside of the stylesheet unless you import. As a result, if you want to have shared files, you need to import them into every stylesheet. For example:

```scss
// users.scss
@import "partials/variables";
@import "partials/typography";
@import "vendor/mixins";

.some-class {
  color: WizardPurple;
}

// ...
```

Not only is this annoying to have to do / remember, it can be harmful (and usually is). When you use Sass's `@import`, anything that is renderable CSS (anything excluding variables, placeholders and mixin definitions) will be included in the file every time it is imported. In the context of our Rails application that is using Sprokets require directives, this means that we end up including a lot of duplicated content. To understand why, imagine what `application.scss` looks like before the Sass processor is run:

```scss
// Contents from the original, unprocessed application.scss:
.class-to-override {
  color: red;
}
// ...

// Contents from other files (either from require_tree, or individually listed files):

// ----------------------------------------
//  From users.scss:
@import "partials/variables";
@import "partials/typography";
@import "vendor/mixins";

.name {
  color: blue; // overridden by the next file
}
// ...
// ----------------------------------------

// ----------------------------------------
//  From gyms.scss:
@import "partials/variables";
@import "partials/typography";
@import "vendor/mixins";

.name {
  color: green;
}
// ...
// ----------------------------------------

//...
```

Because of this, it is common to use Sass imports instead. For more information, see *[Structure your SASS files with @import][1]* by Ward Penney. In that article, he also mentions that this practice is recommend in both the Rails Guides, and in the sass-rails gem readme.

As is shown in the example above, another issue that arises with the default Rails setup is that all CSS ends up in the same application wide scope. In my research, I've found that there are generally two ways to handle this:

1. In the application layout, apply a class to the body tag that describes the current controller and (optionally) action. Have stylesheets specific to the controller and action, and wrap the whole sheet in a select for the class that was placed on the body tag. These stylesheets would be included in the application manifest (and therefore in the final, compiled `application.css`).
2. Have page specific stylesheets that **are not** included in the application manifest and therefore not in the final, compiled `application.css`.

I've read that option 1 is generally considered a code smell, but I can't remember where I read that and I don't think they gave a reason as to why this is bad. Regardless, I've gone with option 2, yet I've done it in a way that makes it easy to switch back to option 1 if we want to at some point.

## Our replacement for the typical asset-pipeline setup
The file `application.scss` serves as the manifest for the application, just as the default Rails setup does. The difference is that we use Sass imports to require the application wide stylesheets and vendor stylesheets (e.g. Bootstrap stylesheets).

Application wide stylesheets must be placed in the `base` folder or one of it's subdirectories. From a technical standpoint, the reason is that we import them into `application.scss` via

```scss
@import "./base/*";
```

but this requirement also helps keep our files and thoughts organized.

The page specific stylesheets all include `application.scss`, so they have access to the application wide styles and to the vendor styles.

The application layout looks for the page specific stylesheet based on the current controller and action. If one isn't found, then `application.scss` is used:

```ruby
# embedded in application.html.erb

if Rails.application.assets.find_asset(ps = page_stylesheet(params[:controller], params[:action]))
  stylesheet_link_tag ps, media: 'all', 'data-turbolinks-track' => true
else
  stylesheet_link_tag 'application', media: 'all', 'data-turbolinks-track' => true
end
```

We have to tell the asset pipeline to compile the page specific stylesheets:

```ruby
# .../initializers/assets.rb

# ...

# Page specific assets
page_assets_folder = Rails.root.join(*%w(app assets stylesheets pages)).to_s
Dir.glob("#{page_assets_folder}/**/*") do |file|
  next unless file['.css'] or file['.scss'] or file['.sass']
  file[page_assets_folder] = 'pages'
  Rails.application.config.assets.precompile += [ file ]
end
```

### Concerns regarding this approach

#### Performance for end users
With the typical approach, there is just one final product CSS file - `application.css`. This has some drawbacks (e.g. all CSS is in the same namespace), but one benefit is that there is only one CSS file for the client or middlemen to cache.

With our approach, there are tens (maybe even hundreds) of files to be cached. Worst of all, these files are all large and largely the same - they all have the contents of `application.css`. I'm guessing this isn't a huge concern for the caches on the "middlemen", but the cache for a browser on a smart phone is probably pretty small, and I'd guess that we're running through it.

One of the best things about the Asset Pipeline (with Rail's default set up) is that it speeds up "perceived performance" by

1. allowing only one stylesheet to be requested and loaded from the server for each page load
2. utilizing smart caching - the browser (or middlemen) can keep a copy `application.css` so that they don't need to re-request it with every page load

In our approach, we still get the first benefit but we are potentially negating the benefits of the smart caching as is described above.

#### Performance during development

As is described in *[A Tale of Front-end Sanity: Beware the Sass @import][2]*, using Sass imports can cause page-reloading in the development environment to be extremely slow because the asset pipeline will recompile the entire stylesheet every time something within an `@import`ed file is changed. With sprockets require directives this isn't the case. I'm guessing that sprockets uses the require directives to determine the order in which to include the contents of each stylesheet and to determine what needs to be recompiled based on dependencies (but that is truly just a guess... I should look it up).

The treehouse article is pretty convincing, and if we can use sprockets require directives to include the Bootstrap stuff, I think we should look into using it in our application. Doing so would require that each stylesheet have require directives specifying what stylesheets and partials it needs - is there an elegant way to handle this? Obviously, we would also need to make sure we don't use Sass imports for anything "renderable".

### An ideal solution

A big problem with our current approach is that we import `application.scss` into each of our page specific stylesheets. The reason that we do this is that it allows us to use stuff from Bootstrap and from our application wide stylesheets.

Alternatively, we could import the specific vendor / application wide stylesheets that we need for that particular page, however I don't like this approach. For one, it is messy and a pain to include everything you need. More importantly though, we still end up with a lot of the same stuff in each of our page specific stylesheets.

What would be really nice is if we could say "Hey Sass compiler - this stylesheet needs some stuff from these other stylesheets. Just use them to make the CSS file, don't actually include any of their CSS unless you're inserting it as a mixin / variable / placeholder / etc." I should look into sprockets more - it sounds like it might do just that with the require directives.

If we could what I described above, then we wouldn't need to include `application.scss` in every page specific stylesheet - instead we could just have every page request both `application.css` *and* the (much smaller) page specific stylesheet. Then the browser could cache `application.css` as usual, and each page load would really just require one stylesheet to be loaded from the server - the page specific one. It still wouldn't be as performant as having everything in `application.css` (pulling one stylesheet from the server takes longer than pulling zero), but it would probably be closer than our current approach.

I still think we should consider the scoping via the class on the body tag in the application layout - the only reason I see it potentially being an issue is that it adds a required level of nesting to the CSS selectors, and having too deeply nested of selectors can be bad because they are hard to override. But this level would be required consistently through out our application, so it should have no affect on the "ability to override"... right? What are some other concerns with this issue?

## Resources
[Organizing CSS & Sass in Rails][3] - interesting because they use a combination of Sass imports and require directives; as long as you were careful, I think this could work well

[1]: https://blog.pivotal.io/labs/labs/structure-your-sass-files-with-import
[2]: http://blog.teamtreehouse.com/tale-front-end-sanity-beware-sass-import
