$(document).on 'page:change', ->
  rolesSection = $('section.roles')
  rolesCollapser = new Climbalytics.Collapser(
    trigger: rolesSection.find('i[class*="fa-toggle"]'),
    target: rolesSection.find('> p'),
    onToggle: ->
      @trigger.filter('i.fa-toggle-down').toggle()
    initialDisplayCondition: rolesSection.find('input[checked="checked"]')
  )

  nameSection = $('section.name')
  nameCollapser = new Climbalytics.Collapser(
    trigger: nameSection.find('i[class*="fa-toggle"]'),
    target: nameSection.find('> p'),
    onToggle: ->
      @trigger.filter('i.fa-toggle-down').toggle()
    initialDisplayCondition: nameSection.data('name-short-format')
  )
