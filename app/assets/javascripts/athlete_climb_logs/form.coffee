showGradeChoices = (climbType = '') ->
  _climbType = climbType.toLowerCase()
  return unless ($.inArray(_climbType, ['boulder', 'route']) >= 0)
  gradeFormGroup = $('.grade')
  gradeFormGroup.show()
  gradeFormGroup.find('select').hide()
  gradeFormGroup.find('#' + _climbType + '_grades').show()

$(document).on 'page:change', ->
  checkedClimbTypeLabel = $('.climb-type [checked="checked"]').closest('label')
  checkedClimbTypeLabel.addClass('active')
  showGradeChoices checkedClimbTypeLabel.find('input').val()

  $('.climb-type').on 'click', 'label', ->
    climbTypeGroup = $(this).closest('.climb-type')
    climbTypeGroup.find('label').removeClass('active')
    inputElement = $(this).find('input')
    $(this).addClass('active')
    showGradeChoices inputElement.val()
