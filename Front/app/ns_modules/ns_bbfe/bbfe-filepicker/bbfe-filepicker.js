define([
    'underscore',
    'jquery',
    'backbone',
    'backbone-forms',
    'bootstrap',
    'requirejs-text!./tpl-bbfe-filepicker.html',
], function (_, $, Backbone, Form,bs, Tpl) {
    'use strict';
    return Form.editors.FilePicker = Form.editors.Base.extend({
        tagName: 'div',
        className: '',

        events: {
            'change input[type=file]': function () {
                // The 'change' event should be triggered whenever something happens
                // that affects the result of `this.getValue()`.
                this.trigger('change', this);
                this.change();
            },
            'focus': function () {
                // The 'focus' event should be triggered whenever an input within
                // this editor becomes the `document.activeElement`.
                this.trigger('focus', this);
                // This call automatically sets `this.hasFocus` to `true`.
            },
            'blur': function () {
                // The 'blur' event should be triggered whenever an input within
                // this editor stops being the `document.activeElement`.
                this.trigger('blur', this);
                // This call automatically sets `this.hasFocus` to `false`.
            }
        },

        initialize: function (options) {
            console.log(options)
            Form.editors.Base.prototype.initialize.call(this, options);
            this.model = new Backbone.Model();
            this.template = _.template(Tpl, this.model.attributes);
            this.listFileToIgnore = [];
            console.log(this.key)
            this.path = 'Station_'+this.form.model.get('FK_Station')+'/'+'Obs_'+this.form.model.get('id')+'/'
            this.editable = options.schema.editable;
            //TODO pb with id, need to move file after we get an id default id = 0


        },


        render: function (options) {
           // Form.editors.Base.prototype.render.apply(this, options);
            this.$el.html(this.template);
            console.log("value ")
            console.log(this.value)

            this.$hiddenInput = this.$el.find(".js-bbfe-filepicker-input-hidden");
            this.$inputFiles = this.$el.find(".js-bbfe-filepicker-input");
            this.$list = this.$el.find(".js-bbfe-filepicker-list");
            this.$gallery = this.$el.find(".imageGallery");
            if( !this.editable ) {
                this.$hiddenInput.remove();
                this.$inputFiles.remove();
                this.displayGallery();
            }

            return this;
        },

        displayGallery: function() {
            var tabPhotos = this.value.split(";");
            for( var i = 0 ; i < tabPhotos.length ; i++ ) {
                var img = document.createElement("img");
                img.src = tabPhotos[i]; /*set property of img*/
                img.width = 150;
                img.height = 150;
                img.onclick =  function (event) {
                    $(".img-responsive").attr("src",  img.src);
                    $('#myModal').modal('show');
                };  
                this.$gallery.append(img);

            }

        },

        uploadPhoto : function(file) {
            //if not present
             //$.get()
            //upload it

        },

        getValue: function () {
            console.log(this)
            console.log("toto")
            // TODO UPLOADER LES PHOTOS 
            var _this = this;
            var tabFileList = [].slice.call(this.$inputFiles[0].files)

            var tabreturned = tabFileList.map(function (elem, index, arr) {
                if (_this.listFileToIgnore.indexOf(index) === -1) {
                    return elem.name
                }
            })
            return tabreturned.join(';');//tabreturned;
        },

        setValue: function (value) {
            console.log("bim set value")
            console.log(value)
            var str, files = value;
            if (_(value).isObject()) {
                str = JSON.stringify(value);
            } else {
                files = value ? JSON.parse(value) : [];
            }
            this.$hiddenInput.val(str);
        },

        change: function () {
            this.readFileAndDisplayImage(this.$inputFiles[0].files);
            this.updateList();
        },
        readFileAndDisplayImage: function (tabFiles) {
            var _this = this;
            for (var i = 0; i < tabFiles.length; i++) {
                /* anonymous function for new fileReader() */
                (function (file) {
                    var reader = new FileReader();
                    var img = document.createElement("img");
                    var elemLi = document.createElement("li");
                    var removeElem = document.createElement("a");

                    //TODO add a spinner for while loading
                    reader.onloadstart = function () {
                        elemLi.innerHTML = '<span class="js-file-name">' + file.name + '</span>' + ' ' + '<span class="js-file-size">' + _this.bytesToKo(file.size) + ' </span>'; //content of li

                        img.src = ""; /*set property of img*/
                        img.width = 150;
                        img.height = 150;

                        removeElem.className = 'reneco reneco-trash remove'
                        removeElem.onclick = function (event) {
                            var index = $(this.parentNode).index();
                            _this.hideElem(this, index);
                            return false;
                        }

                        elemLi.insertBefore(img, elemLi.firstChild) //insert img first elem of list
                        elemLi.appendChild(removeElem)
                        _this.$list.append(elemLi) // li to lu


                    }
                    reader.onprogress = function (data) {
                        if (data.lengthComputable) {
                            var progress = parseInt(((data.loaded / data.total) * 100), 10);
                            console.log(progress);
                        }


                    }
                    reader.onloadend = function () {
                        img.src = reader.result; /*set property of img*/
                        img.onclick =  function (event) {
                            $(".img-responsive").attr("src",  img.src);
                            $('#myModal').modal('show');
                        };                       
                        img.width = 150;
                        img.height = 150;
                    }
                    reader.readAsDataURL(file);
                })(tabFiles[i])

            }
        },

        updateList: function () {
            // var tabFiles = this.$inputFiles[0].files
            // for (var i = 0 ; i < tabFiles.length ; i++ ) {

            //     console.log(tabFiles[i])
            //     this.$list.append("<li>"+tabFiles[i].name+" "+this.bytesToKo(tabFiles[i].size) +" </li>")
            // }        
        },

        bytesToKo: function (bytes) {
            return Math.floor(bytes / 1024) + 'Ko';
        },

        focus: function () {
            if (this.hasFocus) return;
            this.$el.focus();
        },

        blur: function () {
            if (!this.hasFocus) return;
            this.$el.blur();
        },

        hideElem: function (elem, index) {
            /*hide li from list front*/
            elem.parentNode.style.display = 'none';
            /*update  liste files to ignore when save*/
            this.updateListFileToIgnore(index)
        },
        updateListFileToIgnore: function (index) {
            if (this.listFileToIgnore.indexOf(index) === -1) {
                this.listFileToIgnore.push(index)
            }

        }

    });

});
