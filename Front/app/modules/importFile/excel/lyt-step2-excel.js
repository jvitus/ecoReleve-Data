define([
  'jquery',
  'underscore',
  'backbone',
  'marionette',
  'config',
  'ns_form/NSFormsModuleGit',
  'sweetAlert',
  'models/excelForm',
  'i18n'

], function($, _, Backbone, Marionette, config, NsForm, Swal,ExcelForm) {

  'use strict';

  return Marionette.LayoutView.extend({

    className: 'full-height',
    template: 'app/modules/importFile/excel/templates/tpl-step2-excel.html',

    name: 'File selection',

    ui: {
      'form': '#form'
    },

    events: {
      'change input[type="file"]': 'importFile',
    },

    initialize: function(options) {
      this.model = options.model;

    },

    onShow: function() {
      this.displayForm();

    },


    onDestroy: function() {
    },

    check: function() {

    },
    validate: function() {

    },
    displayForm : function(){

      var model = new ExcelForm();
      this.nsform = new NsForm({
        model: model,
        buttonRegion: [],
        formRegion: this.ui.form,
        reloadAfterSave: false,
        disabled : false,
      });
    },
    importFile: function(e) {
      window.app.checkFormSaved = false;
      var _this = this;
      var file = e.target.files[0];
      var fileName = file.name;
      var tab = fileName.split('.');
      var fileType = tab[1].toUpperCase();
      if (fileType != 'XLSX') {
        this.swalError('error file type');
        this.model.set('data_FileName', '');
        this.errors = true;
        $('#importGpxMsg').removeClass('hidden');
      } else {
        var formData = new FormData();
        formData.append("excelFile", file);
        formData.append("protoId",this.model.get('protoID'));
        formData.append("protoName",this.model.get('protoName'));
        $.ajax({
          url: config.coreUrl + 'file_import/getExcelFile',
          type: 'POST',
          data: formData,
          processData: false, // Don't process the files
          contentType: false, // Set content type to false as jQuery will tell the server its a query string request
          success: function(data, textStatus, jqXHR){
                if ((data=='station columns error') || ( data=='protocol columns error') ){
                  _this.swalError(data);

                }
                if(textStatus=='success') {
                  Swal({
                    title: 'Success',
                    text: 'File import is successfully done.',
                    type: 'success',
                    showCancelButton: false,
                    confirmButtonColor: 'green',
                    confirmButtonText: 'OK',
                    closeOnConfirm: true,
                  });
                }
          },
          error: function(jqXHR, textStatus, errorThrown){
                 _this.swalError('error server side');
          }
          });
      }

    },
    swalError: function(title) {
      var _this = this;
      Swal({
        title: title,
        text: 'error',
        type: 'error',
        showCancelButton: false,
        confirmButtonColor: 'rgb(147, 14, 14)',
        confirmButtonText: 'OK',
        closeOnConfirm: true,
      },
      function(isConfirm) {
        $('form')[0].reset();

      });
    }

  });
});