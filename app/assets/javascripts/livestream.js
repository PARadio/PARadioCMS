function daysInMonth(month, year) {
    return new Date(year, month, 0).getDate();
}

function updateDaySelect(){
  // put the correct amount of days in the day select based  on the month and year
  var days = daysInMonth($("#month").val(), $("#year").val());
  var str = "";
  for(var i = 1; i <= days; i++){
    str += "<option value='" + i + "'>" + i + "</option>";
  }
  $("#day").html(str);
}

function updateSelects(){
  // get the url information
  var urlArray = window.location.href.split("/");

  // if the info exists
  if(!(typeof urlArray[7] === 'undefined')) {
    // set the selects based on the url
    $("#year option[value='"+ urlArray[5] +"']").prop('selected', true);
    $("#month option[value='"+ urlArray[6].replace(/^[0]+/g,"") +"']").prop('selected', true);
    updateDaySelect();
    $("#day option[value='"+ urlArray[7] +"']").prop('selected', true);

    // update the stream items
    updateStreamitems();
  }
}

function updateStreamitems(){
  // get json of items from server
  $.ajax({url: "/api/get/stream/" + $("#year").val() + "/" + $("#month").val() + "/" + $("#day").val() + "/items", success: function(result){
    // convert to object
    var items = JSON.parse(result);
    var streamitems_str = "";
    // loop through objects to create table
    for (var i = 0; i < items.length; i++) {
      streamitems_str += "<tr position=" + items[i].position + ">";
      streamitems_str += "   <td class='col-md-2'>" + items[i].start_time + "</td>";
      streamitems_str += "   <td class='col-md-2'>" + items[i].name + "</td>";
      streamitems_str += "   <td class='col-md-6'>" + items[i].description + "</td>";
      streamitems_str += "   <td class='col-md-2'><a rel='nofollow' data-method='delete' href='/admin/streamitems/" + items[i].id + "'>Remove</a></td>";
      streamitems_str += "</tr>";
    }
    // echo out table contents
    $("#streamitems").html(streamitems_str);
    $("#stream-form").show();
  }});

  // get json of stream metadata from server
  $.ajax({url: "/api/get/stream/" + $("#year").val() + "/" + $("#month").val() + "/" + $("#day").val() + "/metadata", success: function(result){
    // convert to object
    var metadata = JSON.parse(result);

    // set heading of page
    var objDate = new Date(metadata.year,metadata.month-1,metadata.day);
    locale = "en-us",
    month = objDate.toLocaleString(locale, { month: "long" });

    $("#livestreamHeader").html("Livestream: " + month + " " + metadata.day + ", " + metadata.year);

    // modify percent progress bar
    $("#timeTakenBar").attr("aria-valuenow", metadata.percent_taken);
    $("#timeTakenBar").css("width", metadata.percent_taken + "%");
    if(metadata.percent_taken > 90){
      $("#timeTakenBar").attr("class", "progress-bar progress-bar-danger");
    } else if(metadata.percent_taken > 75){
      $("#timeTakenBar").attr("class", "progress-bar progress-bar-warning");
    } else {
      $("#timeTakenBar").attr("class", "progress-bar progress-bar-success");
    }
    $("#progressLabel").html(metadata.percent_taken + "% Full");
    if(metadata.percent_taken < 15){
      $(".progress").append($("#progressLabel"));
    } else {
      $("#timeTakenBar").append($("#progressLabel"));
    }

    // display time left
    $("#timeAvailable").html(metadata.time_available.hours + "h " + metadata.time_available.minutes + "m " + metadata.time_available.seconds + "s left");
  }});
}

function addEpisode(){
  window.location.replace("/admin/streamitems/" + $("#year").val() + "/" + $("#month").val() + "/" + $("#day").val() + "/new");
}

var ready = function() {
  updateSelects();
  $("#month").change(function() {
    if($("#day").val() != -1){
      updateStreamitems();
    }
    updateDaySelect();
  });
  $("#year").change(function() {
    if($("#day").val() != -1){
      updateStreamitems();
    }
  });
  $("#day").change(function() {
    updateStreamitems();
  });
  $( "#streamitems" ).sortable({
    update: function(event, ui){
      // find and log position change
      var oldPosition = $(ui.item[0]).attr('position');
      var newPosition;
      if($(ui.item[0]).prev()[0] === undefined){
        newPosition = 1;
      } else if(oldPosition > $(ui.item[0]).prev().attr('position')) {
        newPosition = $(ui.item[0]).next().attr('position');
      } else if(oldPosition < $(ui.item[0]).prev().attr('position')) {
        newPosition = $(ui.item[0]).prev().attr('position');
      }
      console.log(oldPosition + " -> " + newPosition);

      // create array of old positions with new order
      var streamItemsReorg = $("#streamitems").children();
      var newPositionsArray = [];
      for(var i = 0; i < streamItemsReorg.length; i++){
        newPositionsArray.push($(streamItemsReorg[i]).attr('position'));
      }
      console.log(newPositionsArray);

      // send post request to reorder
      var parameters = {
        "old_positions[]": newPositionsArray
      };
      $.post(
        "/admin/streamitems/" + $("#year").val() + "/" + $("#month").val() + "/" + $("#day").val() + "/move",
        parameters,
        function(data, status, xhr) {
          // update stream items
          updateStreamitems();
        });
    }
  });
  $( "#streamitems" ).disableSelection();
};

$(document).ready(function() {
  // get the url information
  var urlArray = window.location.href.split("/");

  // if the info exists
  if((typeof urlArray[8] === 'undefined')) {
    console.log(urlArray);
    ready();
  }
});
$(document).on('page:load', function() {
  // get the url information
  var urlArray = window.location.href.split("/");

  // if the info exists
  if((typeof urlArray[8] === 'undefined')) {
    console.log(urlArray);
    ready();
  }
});
