
define(['jquery', 'marionette', 'backbone', 'config', 'sweetAlert'],
  function($, Marionette, Backbone, config, Swal) {

  'use strict';
  return Marionette.AppRouter.extend({
    history: [],
    appRoutes: {
      'export(/)': 'export',

      'importFile/:type(/)': 'importFile',
      'importFile(/)' : 'importFile',

      'individuals/new(/)': 'newIndividual',
      'individuals/:id(/)': 'individual',
      'individuals(/)': 'individuals',
      'individuals/new/:type(/)': 'newIndividual',


      'monitoredSites/new(/)': 'newMonitoredSite',
      'monitoredSites/:id(/)': 'monitoredSite',
      'monitoredSites(/)': 'monitoredSites',
      'monitoredSites/new/:type(/)': 'newMonitoredSite',


      'sensors/new/:type(/)': 'newSensor',
      'sensors/:id(/)': 'sensor',
      'sensors(/)': 'sensors',

      

      
            'stations/new/:from(/)': 'newStation',
            'stations/new(/)': 'newStation',
             'stations/lastImported(/)': 'stations',

      'stations/:id?(proto=:proto&)obs=:obs(/)': 'station',
      'stations/:id(/)': 'station',
      'stations(/)': 'stations',

      //'stations/:id/release(/)': 'stationRelease',
      'release/:id(/)': 'releaseIndividuals',
      'release(/)': 'release',

      'validate(/)': 'validate',
      'validate/:type(/)': 'validateType',
      'validate/:type/:dataset(/)': 'validateDetail',


      '*route(/:page)': 'home',
    },

    initialize: function(opt) {
      this.collection = new Backbone.Collection([
      {label: 'Manual import', href: 'importFile', icon: 'reneco-import'},
      {label: 'New', href: 'stations/new', icon: 'reneco-entrykey'},
      {label: 'Release', href: 'release', icon: 'reneco-to_release'},
      {label: 'Validate', href: 'validate', icon: 'reneco-validate'},
      {label: 'Stations', href: 'stations', icon: 'reneco-stations'},
      {label: 'Observations', href: 'observations', icon: 'reneco-stations'},
      {label: 'Individuals', href: 'individuals', icon: 'reneco-individuals'},
      {label: 'Sensors', href: 'sensors', icon: 'reneco-sensors'},
      {label: 'Monitored Sites', href: 'monitoredSites', icon: 'reneco-sensors'},
      {label: 'Export', href: 'export', icon: 'reneco-export'},
      ]);
    },

    execute: function(callback, args, route) {
      // get current route
      var route = Backbone.history.fragment;

      if ((route != '') && (route != '#')){
        var allowed = this.checkRoute();
        if(!allowed) {
            return false;
        }
      }
      this.history.push(Backbone.history.fragment);
      var _this= this;
      window.checkExitForm(function(){
        _this.continueNav(callback, args);
      },function(){
        _this.previous();
      });
    },
    onRoute: function(url, patern, params) {
      var notAllowed = window.notAllowedUrl ;
      patern = patern.replace(/\(/g, '');
      patern = patern.replace(/\)/g, '');
      patern = patern.replace(/\:/g, '');
      patern = patern.split('/');

      for (var i=0; i< notAllowed.length;i++){
            if (notAllowed[i] == patern[0]) {
                return ;
            }
      }

      if (patern[0] == '*route') {
        $('#arial').html('');
        $('#arialSub').html('');
      }else {
        this.setNav(patern);
      }

      this.checkResestCurrentDatas(patern[0], params);
    },

    checkResestCurrentDatas: function(type, params) {
      if(params.length > 1){
        if(this.currentId && this.currentId != params[0]){
          window.app.currentData = null;
        }
        this.currentId = params[0];
      } else {
        this.currentId = null;
      }
      if(window.app.currentData){
        if((window.app.currentData.type != type)){
          window.app.currentData = null;
        }
      }
    },

    previous: function() {
        var href = this.history[this.history.length-2];
        var url = '#'+ href;
        Backbone.history.navigate(url,{trigger:false, replace: false});
        this.history.pop();
        var patern = href.split('/');
        this.setNav(patern);
    },
    continueNav : function(callback, args){
        $.ajax({
          context: this,
          url: 'security/has_access'
        }).done(function() {
          $.xhrPool.abortAll();
          callback.apply(this, args);
        }).fail(function(msg) {
          if (msg.status === 403) {
            document.location.href = config.portalUrl;
          }
        });
    },
    unique : function(list) {
        var result = [];
        $.each(list, function(i, e) {
            if ($.inArray(e, result) == -1) result.push(e);
        });
        return result;
    },
    setNav : function(patern){

        var url = patern[0];

        var md = this.collection.findWhere({href: patern[0]});
        $('#arial').html('<a href="#' + md.get('href') + '">| &nbsp; ' + md.get('label') + '</a>');
        if (patern[1] && patern[1] != 'id' && patern[1] != 'type') {
          $('#arialSub').html('<a href="#' + patern[0] + '/' + patern[1] + '">| &nbsp;' + patern[1] + '</a>');
        }else {
          $('#arialSub').html('');
        }
     },
     checkRoute : function(){
        var route = Backbone.history.fragment;
        var notAllowed = window.notAllowedUrl ;
        route = route.replace(/\(/g, '');
        route = route.replace(/\)/g, '');
        route = route.replace(/\:/g, '');
        route = route.split('/');
        for (var i=0; i< notAllowed.length;i++){
            if (notAllowed[i] == route[0]) {
              $('#arialSub').html('');
              Backbone.history.navigate("#",true);
              return false;
            }
        }
        return true;
      }
  });
});
