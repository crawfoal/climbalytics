class Climbalytics.Collapser
  constructor: (args) ->
    {@trigger, @target, @initialDisplayCondition, @onToggle} = args
    @trigger.on 'click', =>
      @toggleCollapse()
    if @initialDisplayCondition # assumes that the target is expanded when the page is loaded
      @toggleCollapse()

  toggleCollapse: =>
    @target.slideToggle()
    @onToggle()
