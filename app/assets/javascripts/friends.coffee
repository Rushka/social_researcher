# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->  
  url = '/friends/validate'
  $('.userform').validate(
        onkeyup: false
        rules:
          'user1':
            required: true
            remote:
              url: url
              type: 'post'
          'user2':
            required: true
            remote:
              url: url
              type: 'post'
      )

  $('.userform').submit ->
    container = $(this).parents('form')

    data = {
      user1: container.find('input[name=user1]').val()
      user2: container.find('input[name=user2]').val()
    }

    $.ajax
      url: '/friends/build'
      type: 'get'
      data: data

    return false