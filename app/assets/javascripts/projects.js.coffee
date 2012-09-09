$(document).ready ->
  $(".typeahead").tokenInput "/users.json",
    minChars: 2
    hintText: "Type name or username..."
    theme: "facebook"
    prePopulate: $(".typeahead").data("load")
    preventDuplicates: true
    resultsFormatter: (item) ->
      "<li>" + "<img src='" + "/assets/avatar.png" + "' title='" + item.name + "' height='25px' width='25px' />" + "<div style='display: inline-block; padding-left: 10px;'><div class='name'>" + item.name + "</div></div></li>"

#$(document).ready(function () {
#  $(".typeahead").tokenInput("/users.json", {
#    minChars: 2,
#    hintText: 'Type name or username...',
#    theme: 'facebook',
#    prePopulate: $('.typeahead').data('load'),
#    preventDuplicates: true,
#    resultsFormatter: function(item) {
#      return "<li>" + "<img src='" + '/assets/avatar.png' + "' title='" + item.name + "' height='25px' width='25px' />" + "<div style='display: inline-block; padding-left: 10px;'><div class='name'>" + item.name + "</div></div></li>"
#    },
#  });
#});