# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'turbolinks:load', ->
  $('.update_campaign input').bind 'blur', ->
    $('.update_campaign').submit()

  $('.update_campaign').on 'submit', (e) ->
    $.ajax e.target.action,
        type: 'PUT'
        dataType: 'json',
        data: $(".update_campaign").serialize()
        success: (data, text, jqXHR) ->
          M.toast({html: 'Campanha atualizada', classes: 'rounded teal lighten-2', 4000})
        error: (jqXHR, textStatus, errorThrown) ->
          M.toast({html: 'Problema na atualização da Campanha', classes: 'rounded red accent-2', 4000})
    return false

  $('.remove_campaign').on 'submit', (e) ->
    $.ajax e.target.action,
        type: 'DELETE'
        dataType: 'json',
        data: {}
        success: (data, text, jqXHR) ->
          $(location).attr('href','/campaigns');
        error: (jqXHR, textStatus, errorThrown) ->
          M.toast({html: 'Problema na remoção da Campanha', classes: 'rounded red accent-2', 4000})
    return false

  $('.raffle_campaign').on 'submit', (e) ->
    $.ajax e.target.action,
        type: 'POST'
        dataType: 'json',
        data: {}
        success: (data, text, jqXHR) ->
          M.toast({html: 'Tudo certo, em breve os participantes receberão um email!', classes: 'rounded teal lighten-2', 4000})
        error: (jqXHR, textStatus, errorThrown) ->
          M.toast({html: jqXHR.responseText, classes: 'rounded red accent-2', 4000})
    return false
