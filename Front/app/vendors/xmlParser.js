define([
	'backbone',
	'moment',
], function(
	Backbone, moment
) {
  'use strict';
  return {
    gpxParser: function(xml) {
      var _this = this;
      try {
        var waypointList = new Backbone.Collection();
        var errors = [];
        // id waypoint
        var id = 0;  // used to get number of valid waypoint
        var nbWaypoints = 0; // used to get number of  waypoints in gpx file
        $(xml).find('wpt').each(function() {
          var waypoint = new Backbone.Model();
          var lat = $(this).attr('lat');
          var lon = $(this).attr('lon');
          var ele = $(this).find('ele').text() || 0 ;
          ele = parseFloat(ele);
          // convert lat & long to number and round to 5 decimals
          var latitude = parseFloat(lat);// parseFloat(lat).toFixed(5);
          var longitude = parseFloat(lon);
          var waypointName = $(this).find('name').text();
          var waypointTime, time;
          // if tag "cmt" exisits, take date from it, else use tag "time"
          var waypointTimeTag = $(this).find('cmt').text();
          var dateStr;
          // check if date is valid, else use time tag to get date
          if (_this.isValidDate(waypointTimeTag)) {
            // possible formats   // <cmt>25-FEB-16 18:02</cmt> or <cmt>04-03-16 12:04</cmt>  <cmt>2010-04-27T08:02:00Z</cmt>
                var tm = waypointTimeTag.split('-');
                var tab = waypointTimeTag.split(' ');
               
                if(tm[0].length == 4 ){
                  //<cmt>2010-04-27T08:02:00Z</cmt>
                  dateStr = moment(waypointTimeTag).format('DD/MM/YYYY HH:mm');
                } else if ((tm[0].length == 2 ) && (tab.length == 2)) {
                  // <cmt>25-FEB-16 18:02</cmt> or <cmt>04-03-16 12:04</cmt>
                  var month = waypointTimeTag.substring(3,5);
                  // format  : <cmt>25-FEB-16 18:02</cmt>
                  if(month != parseInt(month, 10)) {
                        dateStr = moment(waypointTimeTag, 'DD-MMM-YY HH:mm').format('DD/MM/YYYY HH:mm');
                  } else {
                      //<cmt>04-03-16 12:04</cmt>
                      dateStr = moment(waypointTimeTag, 'DD-MM-YY HH:mm').format('DD/MM/YYYY HH:mm');
                  }
               } else {
                //<cmt>2010-04-27T08:02:00Z</cmt>
                  dateStr = moment(waypointTimeTag).format('DD/MM/YYYY HH:mm');
               }    
          } else {
            waypointTimeTag = $(this).find('time').text();
            dateStr = moment(waypointTimeTag).format('DD/MM/YYYY HH:mm');
          }
          var timestamp =  moment(dateStr, 'DD/MM/YYYY HH:mm').unix();
          nbWaypoints += 1;
          if (lat != '' && lon != '' && dateStr != 'Invalid date' && time != ' Invalid date') {
            id += 1;
            //var idwpt = id;
            waypoint.set('id', id);
            waypoint.set('name', waypointName);
            waypoint.set('latitude', latitude);
            waypoint.set('longitude', longitude);
            waypoint.set('elevation', ele);
            waypoint.set('waypointTime', dateStr);
            waypoint.set('displayDate', timestamp);
            waypoint.set('time', time);
            waypoint.set('fieldActivity', '');
            waypoint.set('import', false);
            waypoint.set('FieldWorkers', []);
            waypoint.set('precision', 10);
            waypointList.add(waypoint);
          } else {
            errors.push(waypointName);
          }
        });
        console.log(waypointList);
        // check if all wayponits are imported
        if (id != nbWaypoints) {
          //alert("some waypoints are not imported, please check coordinates and date for each waypoint");
        }
        return [waypointList , errors];

      } catch (e) {
        alert('error loading gpx file');
        //waypointList.reset();
        return [waypointList,0];
      }
    },
    protocolParser: function(xml) {

    }, isValidDate : function(strDate) {
        var isvalid = false;
        if(moment(strDate,"DD-MM-YY HH:mm").isValid()){
          isvalid = true;
        }
        if(moment(strDate,"DD-MM-YY HH:mm:ss").isValid()){
          isvalid = true;
        }
         if(moment(strDate,"DD-MM-YYYY HH:mm:ss").isValid()){
          isvalid = true;
        }
         if(moment(strDate,"DD-MM-YYYY HH:mm").isValid()){
          isvalid = true;
        }
         if(moment(strDate,"YYYY-MM-DD HH:mm").isValid()){
          isvalid = true;
        }
         if(moment(strDate,"YYYY-MM-DD HH:mm:ss").isValid()){
          isvalid = true;
        }
        if(moment(strDate,"YY-MMM-DD HH:mm:ss").isValid()){
          isvalid = true;
        }
        if(moment(strDate,"YY-MMM-DD HH:mm").isValid()){
          isvalid = true;
        }
        if(moment(strDate).isValid()){
          isvalid = true;
        }
       return isvalid;

    }
  };
});

