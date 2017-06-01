define([
  'jquery',
  'underscore',
  'backbone',
  'marionette',
  'sweetAlert',
  'translater',

  'ns_map/ns_map',
  'ns_grid/grid.view',
  'ns_form/NsFormsModuleGit',

  'modules/objects/detail.view',
  './monitored_site.model',


], function(
  $, _, Backbone, Marionette, Swal, Translater,
  NsMap, GridView, NsForm,
  DetailView, MonitoredSiteModel
){

  'use strict';

  return DetailView.extend({
    ModelPrototype: MonitoredSiteModel,

    displayGrids: function(){
      this.displayHistoryGrid();
      this.displayEquipmentGrid();
      this.displayStationsGrid();
    },

    reload: function(options) {
      this.model.set('id', options.id);

      this.com.addModule(this.map);
      this.map.com = this.com;
      this.map.url = this.model.get('type') + '/' + this.model.get('id')  + '/history/?geo=true'; //only this one
      this.map.updateFromServ();
      this.map.url = false;

      this.displayForm();
      this.displayGrids();
    },

    displayMap: function(geoJson) {
      this.map = new NsMap({
        url: 'monitoredSites/' + this.model.get('id')  + '/history/?geo=true', ////only this one
        zoom: 4,
        element: 'map',
        popup: true,
        cluster: true
      });
    },

    displayHistoryGrid: function() {
      this.rgHistoryGrid.show(this.historyGrid = new GridView({
        //columns: this.model.get('historyColumnsDefs'),
        name: 'MonitoredSiteGridHistory',
        type: this.model.get('type'),
        url: this.model.get('type') + '/' + this.model.get('id')  + '/history/',
        clientSide: true,
      }));
      this.gridViews.push(this.historyGrid);
    },

    displayEquipmentGrid: function() {
      this.rgEquipmentGrid.show(this.equipmentGrid = new GridView({
        columns: this.model.get('equipmentColumnDefs'),
        type: this.model.get('type'),
        url: this.model.get('type') + '/' + this.model.get('id')  + '/equipment',
        clientSide: true,
      }));
      this.gridViews.push(this.equipmentGrid);
    },

    displayStationsGrid: function() {
      this.rgStationsGrid.show(this.stationsGrid = new GridView({
        columns: this.model.get('stationsColumnDefs'),
        type: this.model.get('type'),
        url: this.model.get('type') + '/' + this.model.get('id')  + '/stations',
        clientSide: true,
      }));
      this.gridViews.push(this.stationsGrid);
    },

  });
});
