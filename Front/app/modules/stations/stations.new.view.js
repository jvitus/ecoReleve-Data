define([
  'jquery',
  'underscore',
  'backbone',
  'marionette',

  'moment',
  'dateTimePicker',
  'sweetAlert',

  'ns_form/NsFormsModuleGit',
  'ns_map/ns_map',
  'exif-js',

  'i18n'

], function(
  $, _, Backbone, Marionette,
  moment, datetime, Swal,
  NsForm, NsMap, Exif
){

  'use strict';

  return Marionette.LayoutView.extend({
    template: 'app/modules/stations/stations.new.tpl.html',
    className: 'full-height white',

    events: {
      'click .js-btn-current-position': 'getCurrentPosition',
      'click .js-btn-save': 'save',
      'click .js-btn-add-photos' :'simulateClickInputFile',

      'focusout input[name="Dat e_"]': 'checkDate',
      'change input[name="LAT"], input[name="LON"]': 'getLatLng',
      'click .tab-link': 'displayTab',
      'change select[name="FieldWorker"]': 'checkUsers',
      'change input[type=file]' : 'addPhoto',
    },

    name: 'Station creation',

    ui: {
      'staForm': '.js-form',
      'inputPhoto' :'.js-photopicker-input'
    },

    initialize: function(options) {
      this.from = options.from;
      this.histoMonitoredSite = {};
      this.imgFile = document.createElement("img");
      this.flagPhoto = false;
    },

    onShow: function() {
      this.refrechView('#stWithCoords');
      this.map = new NsMap({
        popup: true,
        zoom: 16,
        element: 'map',
      });
      this.$el.i18n();
    },

    onDestroy: function() {
      this.map.destroy();
      this.nsForm.destroy();
    },

    getCurrentPosition: function() {
      var _this = this;
      if (navigator.geolocation) {
        var loc = navigator.geolocation.getCurrentPosition(function(position) {
          var lat = parseFloat((position.coords.latitude).toFixed(5));
          var lon = parseFloat((position.coords.longitude).toFixed(5));
          _this.updateMarkerPos(lat, lon);
          _this.$el.find('input[name="LAT"]').val(lat).change();
          _this.$el.find('input[name="LON"]').val(lon).change();
        });
      } else {
        Swal({
          title: 'The browser dont support geolocalization API',
          text: '',
          type: 'error',
          showCancelButton: false,
          confirmButtonColor: 'rgb(147, 14, 14)',
          confirmButtonText: 'OK',
          closeOnConfirm: true,
        });
      }
    },

    getLatLng: function() {
      var lat = this.$el.find('input[name="LAT"]').val();
      var lon = this.$el.find('input[name="LON"]').val();
      this.updateMarkerPos(lat, lon);
    },

    updateMarkerPos: function(lat, lon) {
      if (lat && lon) {
        var popup = this.imgFile;
        this.markerPhoto = this.map.addMarker(null, lat, lon,popup);
        this.markerPhoto.openPopup();
      }
    },

    checkUsers: function(e) {
      var usersFields = $('select[name="FieldWorker"]');
      var selectedUser = $(e.target).val();
      var exists = 0;
      $('select[name="FieldWorker"]').each(function() {
        var user = $(this).val();
        if (user == selectedUser) {
          exists += 1;
        }
      });
      if (exists > 1) {
        Swal({
          title: 'Fieldworker name error',
          text: 'Already selected ! ',
          type: 'error',
          showCancelButton: false,
          confirmButtonColor: 'rgb(147, 14, 14)',
          confirmButtonText: 'OK',
          closeOnConfirm: true,
        },
        function(isConfirm) {
          $(e.target).val('');
        });
      }
    },

    displayTab: function(e) {
      var _this = this;
      e.preventDefault();
      window.checkExitForm(function(){
        _this.swithTab(e);
      });

     },
     swithTab : function(e){
       var ele = $(e.target);
       var tabLink = $(ele).attr('href');
       $('.tab-ele').removeClass('active');
       $(ele).parent().addClass('active');
       $(tabLink).addClass('active in');
       this.map.map.removeLayer(this.markerPhoto._leaflet_id)
       this.refrechView(tabLink);
     },

     addPhoto : function(e) {

      this.flagPhoto = true;
      this.readFileAndDisplayImage(this.ui.inputPhoto[0].files[0])
      this.getExif();
     },

     getExif : function() {
       var _this =this;
              Exif.getData(this.ui.inputPhoto[0].files[0], function() {
                console.log(EXIF.getAllTags(this))
                var exifGPSLat = EXIF.getTag(this,'GPSLatitude');
                var exifGPSLon = EXIF.getTag(this,'GPSLongitude');
                var exifGPSAlt = EXIF.getTag(this,'GPSAltitude');
                var exifDate = EXIF.getTag(this,'DateTimeOriginal');
              if( exifGPSLat && exifGPSLon) {
                var latInDeg = exifGPSLat[0] + ( exifGPSLat[1] / 60) + ( exifGPSLat[2]/3600 );
                var longInDeg = exifGPSLon[0] + ( exifGPSLon[1] / 60) + ( exifGPSLon[2]/3600 );
                latInDeg = parseFloat((latInDeg).toFixed(5));
                longInDeg = parseFloat((longInDeg).toFixed(5));
                _this.$el.find('input[name="LAT"]').val(latInDeg).change();
                _this.$el.find('input[name="LON"]').val(longInDeg).change();
              }
              else {
                  _this.$el.find('input[name="LAT"]').addClass('error');
                  _this.$el.find('input[name="LON"]').addClass('error');
                  _this.$el.find('input[name="LAT"]').focus();

              var  msg = 'La photo ne contient pas de coordonnées GPS dans ses metadonnées\n Vous devez renseigner les valeurs pour les champs latitude longitude';
              var  type_ = 'warning';
              var  title = 'Pas de coordonnées';
                Swal({
                  title: title,
                  text: msg,
                  type: type_,
                  showCancelButton: false,
                  confirmButtonColor: 'rgb(147, 14, 14)',
                  confirmButtonText: 'OK',
                  closeOnConfirm: true,
                });
              }
              if ( exifGPSAlt) {
                var altInNumber = exifGPSAlt.numerator / exifGPSAlt.denominator;
                 _this.$el.find('input[name="ELE"]').val(parseFloat((altInNumber)).toFixed(2)).change();
              }
              if( exifDate ) {
                  var date = moment(exifDate ,"YYYY:MM:DD HH:mm:SS");
                 _this.$el.find('input[name="Date_"]').val(date.format("DD/MM/YYYY HH:mm:SS")).change();
              }
             });
     },
     updateResult : function(img, data) {
       console.log(img);
       console.log(data);
     },
     readFileAndDisplayImage: function (fileImg) {
          var _this = this;
          loadImage.parseMetaData ( fileImg,
            function(data) {
              var orientation = 0;
              if (data.exif) {
                orientation = data.exif.get('Orientation');
                _this.imgFile.width = 150;
                _this.imgFile.height = 150;
              }
              var loadingImage = loadImage(fileImg,
                function(img) {
                  _this.imgFile.src = img.toDataURL();
                  _this.imgFile.onclick =  function (event) {
                    $(".img-responsive").attr("src",  _this.imgFile.src);
                    $('#myModal').modal('show');
                  };
                  _this.imgFile.width = 150;
                  _this.imgFile.height = 150;
                }, {
                  orientation : orientation,
                  canvas : true,
                  maxHeight : ( _this.$el.height() - 110 ),
                  maxWidth : _this.$el.width()
                }
              )
          /*    loadingImage.onload = function(e) {
                console.log("event")
                console.log(e);
                _this.imgFile.src = e.path[0].src;
                _this.imgFile.onclick =  function (event) {
                  $(".img-responsive").attr("src",  _this.imgFile.src);
                  $('#myModal').modal('show');
                };
                _this.imgFile.width = 150;
                _this.imgFile.height = 150;
              };
              loadingImage.onerror = function () {

                console.log("error loading img")
              }*/
            }


          /*  function(img,data) {
              console.log(img);
              _this.imgFile.src = "";
              _this.imgFile.width = 150;
              _this.imgFile.height = 150;
            },
            {
            orientation: 1//exif.get('Orientation')
          }*/
          );
      /*    loadingImage.onload = function(event,data) {
            _this.imgFile.src = event.srcElement.src;
            _this.imgFile.onclick =  function (event) {
                $(".img-responsive").attr("src",  _this.imgFile.src);
                $('#myModal').modal('show');
            };
            _this.imgFile.width = 150;
            _this.imgFile.height = 150;
          };
          loadingImage.onerror = function () {

            console.log("error loading img")
          }*/
          //loadingImage.onload = loadingImage.onerror = null;
        /*  var reader = new FileReader();

          //TODO add a spinner for while loading
          reader.onloadstart = function () {
              _this.imgFile.src = "";
              _this.imgFile.width = 150;
              _this.imgFile.height = 150;
          }
          reader.onprogress = function (data) {
              if (data.lengthComputable) {
                  var progress = parseInt(((data.loaded / data.total) * 100), 10);
                  console.log(progress);
              }


          }
          reader.onloadend = function () {

              _this.imgFile.src = reader.result;
              _this.imgFile.onclick =  function (event) {
                  $(".img-responsive").attr("src",  _this.imgFile.src);
                  $('#myModal').modal('show');
              };
              _this.imgFile.width = 150;
              _this.imgFile.height = 150;
          }
          reader.readAsDataURL(fileImg);*/

        },

     simulateClickInputFile: function() {
      this.ui.inputPhoto.click();
     },

    refrechView: function(stationType) {
      var stTypeId;
      var _this = this;
      switch (stationType){
        case '#stWithCoords':
          stTypeId = 1;
          $('.js-get-current-position').removeClass('hidden');
          $('.js-btn-add-photos').removeClass('hidden');
          break;
        case '#stWithoutCoords':
          stTypeId = 3;
          $('.js-get-current-position').addClass('hidden');
          $('.js-btn-add-photos').addClass('hidden');
          break;
        default:
          stTypeId = 1;

          break;
      }

      if (this.nsForm) {
        this.nsForm.destroy();
      }

      this.ui.staForm.empty();

      this.nsForm = new NsForm({
        name: 'StaForm',
        modelurl: 'stations/',
        buttonRegion: [],
        formRegion: this.ui.staForm,
        displayMode: 'edit',
        objectType: stTypeId,
        id: 0,
        afterShow: function() {
          if(_this.from == 'release'){
            _this.$el.find('[name="fieldActivityId"]').val('1').change();
          }
          _this.$el.find('input[name="FK_MonitoredSite"]').on('change', function() {
              var msId = _this.$el.find('input[name="FK_MonitoredSite"]').attr('data_value');
              _this.getCoordFromMs(msId);
          });
        }
      });

      this.nsForm.savingSuccess =  function(model, resp) {
        _this.afterSave(model, resp);


      };

      this.nsForm.savingError = function (response) {
        var msg = 'An error occured, please contact an admninstrator';
        var type_ = 'error';
        var title = 'Error saving';
        if (response.status == 510) {
          msg = 'A station already exists with these parameters';
          type_ = 'warning';
          title = 'Error saving';
        }

        Swal({
          title: title,
          text: msg,
          type: type_,
          showCancelButton: false,
          confirmButtonColor: 'rgb(147, 14, 14)',
          confirmButtonText: 'OK',
          closeOnConfirm: true,
        });
      };
      this.rdy = this.nsForm.jqxhr;
    },

    getCoordFromMs: function(msId) {
      var _this = this;
      var url = 'monitoredSites/' + msId;

      $.ajax({
        context: this,
        url: url,
      }).done(function(data) {
        var lat = data['LAT'];
        var lon = data['LON'];
        _this.$el.find('input[name="LAT"]').val(lat).change();
        _this.$el.find('input[name="LON"]').val(lon).change();
      }).fail(function() {
        console.error('an error occured');
      });
    },

    afterSave: function(model, resp) {
      var _this = this;
      if (this.flagPhoto) {
        $.when( _this.uploadPhoto( _this.imgFile.src,  _this.ui.inputPhoto[0].files[0].name,model.get('ID')) )
        .then(
          function() {
           $('#myPleaseWait').modal('hide');
           setTimeout( function() {
             Backbone.history.navigate('#stations/' + model.get('ID'), {trigger: true});
           },1000);

         },
        function() {
          $('#myPleaseWait').modal('hide');
          $.ajax({
             url: 'stations/'+model.get('ID'),
             type: 'DELETE',
             cache: false,
            });

        var msg = 'Le processus de sauvegarde a échoué, si cela persiste merci de contacter un admin ';
        var type_ = 'error';
        var title = 'Erreur lors de la sauvegarde';
          Swal({
            title: title,
            text: msg,
            type: type_,
            showCancelButton: false,
            confirmButtonColor: 'rgb(147, 14, 14)',
            confirmButtonText: 'OK',
            closeOnConfirm: true,
          });
        }

        );
      }
      else {
        var id = model.get('ID');
        if(this.from == 'release') {
          Backbone.history.navigate('#release/' + id, {trigger: true});
          return;
        }
        else {
          Backbone.history.navigate('#stations/' + id, {trigger: true});
        }

      }

    },

    save: function() {
      //upload photo
      //this.uploadPhoto(this.imgFile.src, this.ui.inputPhoto[0].files[0].name,id)
      this.nsForm.butClickSave();

    },

    uploadPhoto : function(imgBase64,fileName,idStation) {
      var _this = this;
      $('#myPleaseWait').modal('show');
      return $.ajax({
        url: 'photos',
        type: 'POST',
        data: {
          base64 : imgBase64,
          fileName: fileName,
          idStation : idStation
        },
        cache: false,
        contentType: "application/x-www-form-urlencoded",
        xhr: function() {
          var myXhr = $.ajaxSettings.xhr();
          if(myXhr.upload){
              myXhr.upload.addEventListener('progress',_this.progress, false);
          }
          return myXhr;
        }
        //dataType: 'json',
        // success: function(data, textStatus, jqXHR)
        // {
        //   //ok on renvoit vers la station créé
        // },
        // error: function(jqXHR, textStatus, errorThrown)
        // {
        //     //swal pb réseau lors de l'envoi de la photo merci de réessayer
        // },
        // complete: function()
        // {
        //     // STOP LOADING SPINNER
        // }
    });
  },
  progress :  function (e){

   if(e.lengthComputable){
       var max = e.total;
       var current = e.loaded;

       var Percentage = (current * 100)/max;
       if(Percentage >= 100)
       {
         Percentage = 100;
       }
       $('.progress-bar').width(Percentage+'%');


   }
}

  });
});
