$(document).ready(function () {
var project_box = $(".project_box");
var project_contents = project_box.find("#project_content").clone();
$("#filter").keyup(function() {
    var regex = new RegExp($(this).val(), 'i');
    project_box.find("#project_content").remove();
    project_box.append(project_contents.filter(function(i, #project_content) {
        return regex.test(#project_content.innerHTML);
    }));
  });
});