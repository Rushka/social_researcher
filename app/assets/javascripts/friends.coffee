# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  
  url = '/friends/validate'
  #successHandler = () -> 

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