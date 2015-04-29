// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require bootstrap.min
// require cocoon

// require jquery-ui/core
// require bootstrap-sprockets
// require_tree .

//= require jquery.dataTables.min
// require dataTables.bootstrap
//= require jquery_nested_form
//= require jquery-migrate-1.2.1.min
//= require jquery.ui.touch-punch.min
//= require jquery.autosize.min
//= require jquery.placeholder.min
//= require jquery-jvectormap-1.2.2.min
//= require jquery-jvectormap-world-mill-en
//= require custom.min
//= require core.min
//= require jquery.sumoselect.min

$(document).ready(function() {
  $('.has-tooltip').tooltip({ placement: 'auto left'});
  $("input.datepicker").datepicker();
  $('.sumoselect').SumoSelect({ okCancelInMulti: true, selectAll: true });
  $(".datatable").dataTable();
});

