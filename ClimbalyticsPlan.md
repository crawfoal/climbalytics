# Climbalytics Application Outline

## Content Summary

### Athlete

#### Dashboard

* List of recent ascents (logged as sent).
* List of projects (logged as attempted).
* List of active, recommended boulders / routes at their "home gym".

Links to boulders / routes in this dashboard will link to a form for the athlete to create / edit a log of an attempt on the boulder problem.

### Setter

#### Dashboard

* **Personal Page**
  * Create a route / boulder problem.
  * Active routes / boulder problems for this setter (more detailed than below).
  * Expandable section for reviewing historical routes and boulder problems for this setter.
  * The setter's average rating for boulders and routes.
* **Gym Logistics** - looks the same for all setters, setters don't edit content here
  * Active routes / boulder problems for all setters.
  * Pie graph of current grade distribution for boulders and routes.
  * Pie graph of current style distribution for boulders and routes (maybe).
  * Expandable section for reviewing historical routes and boulder problems for all setters.
  * Highlight top three rated route setters.

Links to boulders / routes in this dashboard will link to a form for the setter view the boulder problem.

## Design Considerations and Goals

* Simplistic look
* Keep it simple at first. As you develop more features, keep the basic functionality up front and obvious to the user, and insert new functionality where the user would expect it and don't overcrowd things like the dashboard and other frequently visited pages.
* Only display statistics once there is enough data.

## Random Details Section

* Have an assigned color theme for each role; when the user changes roles, the color theme switches. The color theme for each role should tie in well with the company's color scheme.
* Favor glyphicons and/or vector images over text. E.g. when the setter is selecting an angle for the climb, display glyphicons instead of text.
* For displaying tape color and grade, use the tape color as the background. For multicolored tape, use a striped background.
