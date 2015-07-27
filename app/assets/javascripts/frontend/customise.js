$(window).load(function() {
    $.getJSON(dress_detail_url, function(data) {

        // svg wrapper
        var data = data;
        var pathClass = ''; //it will get the clicked part using data-part attribute
        var clickedPath = ''; // converting clicked pathclass string to jquery object

        var allDressParts = []; //it will usefull for validation when we click on save


        var s = Snap("#svg_wrapper"); // svgs loading wrapper
        Snap.load(data.angle_0, loadSvg1);
        //loading first svg


        function loadSvg1(data1) {
            s.append(data1);
            Snap.load(data.angle_90, loadSvg2);
        }

        function loadSvg2(data2) {
            s.append(data2);
            Snap.load(data.angle_180, loadSvg3);
        }

        function loadSvg3(data3) {
            s.append(data3);
            Snap.load(data.angle_270, loadSvg4);
        }

        function loadSvg4(data4) {
            s.append(data4);

        }
        loadSavedDresses(data);
        //svg rotation four parts functionality 
        var indexposition = 1;
        $('.rotate img').click(function() {
            var rotation = ['rotationview1', 'rotationview2', 'rotationview3', 'rotationview4'];
            var indexClass = rotation[indexposition];
            indexposition++;
            $('svg').css({
                'top': '-500px',
                'left': '-500px'
            });
            $('.' + indexClass).css({
                'top': '0px',
                'left': '0px'
            });
            if (indexposition == 4) {
                indexposition = 0;
            }
        });

        //to findout what all are the parts the dress has


        //waiting to load all svg then these functions will work

        var fabricsDetails = [];
        var fabricId = [];
        var fabricNames = [];

        var brocadeDetails = [];
        var brocadeId = [];
        var brocadeName = [];
        setTimeout(function() {
            var continueLoopCount = 0; //to display the patterns in serialwise 

            for (var allparts = 0; allparts < data.fabric_groups.length; allparts++) {
                for (var chekparts = 0; chekparts < data.fabric_groups[allparts].parts.length; chekparts++) {
                    allDressParts.push(data.fabric_groups[allparts].parts[chekparts].name)
                };

            };
            // console.log(allDressParts);
            for (var i = 0; i < data.fabric_groups.length; i++) {

                //to displau the fabric colors intially
                for (var j = 0; j < data.fabric_groups[i].fabric_colors.length; j++) {
                    //checking fabric id is present or not in the array ()
                    var fabriccolorid = _.where(fabricsDetails, {
                        id: data.fabric_groups[i].fabric_colors[j].id
                    });

                    if (fabriccolorid.length == 0) {
                        continueLoopCount++;
                        var image = new Image();
                        image.src = data.fabric_groups[i].fabric_colors[j].swatch;
                        var obj = {};
                        obj.fabric_id = data.fabric_groups[i].fabric_colors[j].fabric_id;
                        obj.fabric_name = data.fabric_groups[i].fabric_colors[j].fabric_name;
                        obj.id = data.fabric_groups[i].fabric_colors[j].id;
                        obj.name = data.fabric_groups[i].fabric_colors[j].name;
                        obj.swatch = data.fabric_groups[i].fabric_colors[j].swatch;
                        obj.pid = continueLoopCount;
                        //obj.base64 = convertImgToBase64(data.fabric_groups[i].fabric_colors[j].swatch);
                        fabricsDetails.push(obj);
                        fabricId.push(data.fabric_groups[i].fabric_colors[j].id);
                        fabricNames.push(data.fabric_groups[i].fabric_colors[j].fabric_name);
                    }

                };
                // to display the brocades initially

                for (var k = 0; k < data.fabric_groups[i].parts.length; k++) {
                    for (var l = 0; l < data.fabric_groups[i].parts[k].brocade_parts.length; l++) {
                        var brocadecolorid = _.where(brocadeDetails, {
                            id: data.fabric_groups[i].parts[k].brocade_parts[l].brocade_id
                        });
                        if (brocadecolorid == 0) {
                            continueLoopCount++;
                            var bro_obj = {};
                            bro_obj.brocade_id = data.fabric_groups[i].parts[k].brocade_parts[l].brocade_id;
                            bro_obj.name = data.fabric_groups[i].parts[k].brocade_parts[l].name;
                            bro_obj.image = data.fabric_groups[i].parts[k].brocade_parts[l].image;
                            bro_obj.pid = continueLoopCount;
                            brocadeDetails.push(bro_obj);
                            brocadeId.push(data.fabric_groups[i].parts[k].brocade_parts[l].brocade_id);
                            brocadeName.push('brocade');
                        }

                    };
                };


            };

            fabricId = _.uniq(fabricId);
            fabricNames = _.uniq(fabricNames);

            brocadeId = _.uniq(brocadeId);
            brocadeName = _.uniq(brocadeName);

            //displaying all fabrics intially without repeating
            for (var i = 0; i < fabricNames.length; i++) {
                $('#material').append('<div style="clear:both"></div>');
                $('#material').append('<p class="fabric_name">' + fabricNames[i] + '</p>');
                for (var j = 0; j < fabricsDetails.length; j++) {
                    var image = new Image();
                    image.src = fabricsDetails[j].swatch;
                    // console.log('image width ' + image.width + ' and height is ' + image.height);
                    $('#material').append('<div class="pattern_div" id="divs' + fabricsDetails[j].pid + '" data-category="fabrics" data-originalid="' + fabricsDetails[j].id + '"><img  data-pid="img' + fabricsDetails[j].pid + '" data-id="' + fabricsDetails[j].pid + '" src="' + fabricsDetails[j].swatch + '" /><p>' + fabricsDetails[j].name + '</p></div>');
                    //$('.defsclass').append("<svg><pattern id='img" + fabricsDetails[j].id + "' patternUnits='userSpaceOnUse' width=" + image.width + " height=" + image.height + "><image xlink:href=" + dress_details.fabrics[i].colors[j].swatch64 + " x='0' y='0' width=" + image.width + " height=" + image.height + " /></pattern></svg>");

                    // $('.defsclass').append("<svg><pattern id='img" + fabricsDetails[j].pid + "' patternUnits='userSpaceOnUse' width='50px' height='50px'><image xlink:href=" + fabricsDetails[j].swatch + " x='0' y='0' width='50px' height='50px' /></pattern></svg>");
                };
            };

            // displaying all brocades intially without repeating

            for (var i = 0; i < brocadeName.length; i++) {
                $('#material').append('<div style="clear:both"></div>');
                $('#material').append('<p class="fabric_name">' + brocadeName[i] + '</p>');
                for (var j = 0; j < brocadeDetails.length; j++) {
                    var image = new Image();
                    image.src = brocadeDetails[j].image;
                    // console.log('image width ' + image.width + ' and height is ' + image.height);
                    $('#material').append('<div class="pattern_div" id="divs' + brocadeDetails[j].pid + '" data-category="brocades" data-originalid="' + brocadeDetails[j].brocade_id + '"><img  data-pid="img' + brocadeDetails[j].pid + '" data-id="' + brocadeDetails[j].pid + '" src="' + brocadeDetails[j].image + '" /><p>' + brocadeDetails[j].name + '</p></div>');
                    //$('.defsclass').append("<svg><pattern id='img" + fabricsDetails[j].id + "' patternUnits='userSpaceOnUse' width=" + image.width + " height=" + image.height + "><image xlink:href=" + dress_details.fabrics[i].colors[j].swatch64 + " x='0' y='0' width=" + image.width + " height=" + image.height + " /></pattern></svg>");

                    //$('.defsclass').append("<svg><pattern id='img" + brocadeDetails[j].pid + "' patternUnits='userSpaceOnUse' width='50px' height='50px'><image xlink:href=" + brocadeDetails[j].image + " x='0' y='0' width='50px' height='50px' /></pattern></svg>");
                };
            };
        }, 1000);







        //clicking functionality on svg parts

        $(document).on('click', '.part', function() {
            pathClass = $(this).attr('data-part');
            clickedPath = $("." + pathClass);
            //   console.log('clicked part name   ' + pathClass);
            filterMaterial(pathClass);
        });


        //to filter the materials or fabrics depending on the clicked part
        function filterMaterial(pathClass) {
            //displaying fabrics accoring to clicked part
            var fabricPartId = [];
            var fabricPartName = [];
            var brocadePartId = [];
            var brocadePartName = [];
            for (var i = 0; i < data.fabric_groups.length; i++) {
                for (var j = 0; j < data.fabric_groups[i].parts.length; j++) {
                    if (data.fabric_groups[i].parts[j].name == pathClass) {
                        for (var k = 0; k < data.fabric_groups[i].fabric_colors.length; k++) {
                            fabricPartId.push(data.fabric_groups[i].fabric_colors[k].id);
                            fabricPartName.push(data.fabric_groups[i].fabric_colors[k].fabric_name);
                        };

                        //to filter brocades according to the part
                        for (var o = 0; o < data.fabric_groups[i].parts[j].brocade_parts.length; o++) {
                            // console.log('brocadeid ' + data.fabric_groups[i].parts[j].brocade_parts[o].brocade_id);
                            brocadePartId.push(data.fabric_groups[i].parts[j].brocade_parts[o].brocade_id);
                            brocadePartName.push('brocade');
                        };

                    }
                };
            };

            fabricPartId = _.uniq(fabricPartId);
            fabricPartName = _.uniq(fabricPartName);
            brocadePartId = _.uniq(brocadePartId);
            brocadePartName = _.uniq(brocadePartName);

            $('#material').html('');
            for (var l = 0; l < fabricPartName.length; l++) {
                $('#material').append('<div style="clear:both"></div>');
                $('#material').append('<p class="fabric_name">' + fabricPartName[l] + '</p>');
                for (var m = 0; m < fabricPartId.length; m++) {
                    for (var n = 0; n < fabricsDetails.length; n++) {
                        if (fabricPartId[m] == fabricsDetails[n].id) {
                            $('#material').append('<div class="pattern_div" id="divs' + fabricsDetails[m].pid + '" data-category="fabrics" data-originalid="' + fabricsDetails[m].id + '"><img  data-pid="img' + fabricsDetails[m].pid + '" data-id="' + fabricsDetails[m].pid + '" src="' + fabricsDetails[m].swatch + '" /><p>' + fabricsDetails[m].name + '</p></div>');
                        }
                    };
                };
            };
            for (var p = 0; p < brocadePartName.length; p++) {
                $('#material').append('<div style="clear:both"></div>');
                $('#material').append('<p class="fabric_name">' + brocadePartName[p] + '</p>');
                for (var q = 0; q < brocadePartId.length; q++) {
                    for (var r = 0; r < brocadeDetails.length; r++) {
                        if (brocadePartId[q] == brocadeDetails[r].brocade_id) {
                            $('#material').append('<div class="pattern_div" id="divs' + brocadeDetails[r].pid + '" data-category="brocades" data-originalid="' + brocadeDetails[r].brocade_id + '" ><img  data-pid="img' + brocadeDetails[r].pid + '" data-id="' + brocadeDetails[r].pid + '" src="' + brocadeDetails[r].image + '" /><p>' + brocadeDetails[r].name + '</p></div>');
                        }
                    };
                };
            };





        }
        var alreadyPatternAppened = [];

        $(document).on('click', '.pattern_div', function() {
            var applicableParts = [];
            var thisPattern = $(this).find('img').attr('data-pid');

            var image = $(this).find('img');
            var img_width = image.width();
            var img_height = image.height();
            var imagesrc = $(this).find('img').attr('src');
            var thisId = $(this).find('img').attr('data-id');
            // console.log('width is ' + img_width + ' and height is ' + img_height);
            var gettingCategory = $(this).attr('data-category');
            var gettingOriginalId = $(this).attr('data-originalid');

            var img = new Image();

            img.onload = function() {
                var canvas = document.createElement("canvas");
                canvas.width = this.width;
                canvas.height = this.height;
                var ctx = canvas.getContext("2d");
                ctx.drawImage(this, 0, 0);
                var dataURL = canvas.toDataURL("image/png");
                dataURL.replace(/^data:image\/(png|jpg);base64,/, "");
                var patternIdLength = _.where(alreadyPatternAppened, {
                    id: thisId
                }); //it will check the id which is already appened svg pattern to defsclass

                if (patternIdLength == 0) { //if thisid pattern is not appened to defs class then it will append that pattern id 
                    $('.defsclass').append("<svg><pattern id='img" + thisId + "' patternUnits='userSpaceOnUse' width=" + img_width + " height=" + img_height + "><image xlink:href=" + dataURL + " x='0' y='0' width=" + img_width + " height=" + img_height + " /></pattern></svg>");
                    var obj = {};
                    obj.id = thisId;
                    alreadyPatternAppened.push(obj);
                }
                //searching clickable parts using fabric id or brocade id or embellishment id

                if (gettingCategory == 'fabrics') {
                    for (var i = 0; i < data.fabric_groups.length; i++) {
                        for (var j = 0; j < data.fabric_groups[i].parts.length; j++) {
                            if (data.fabric_groups[i].parts[j].name == pathClass) {
                                for (var q = 0; q < data.fabric_groups[i].parts.length; q++) {
                                    //  console.log('parts are --' + data.fabric_groups[i].parts[q].name);
                                    applicableParts.push(data.fabric_groups[i].parts[q].name);
                                };
                            }

                        };
                    };
                }
                if (gettingCategory == 'brocades') {
                    for (var k = 0; k < data.fabric_groups.length; k++) {
                        for (var l = 0; l < data.fabric_groups[k].parts.length; l++) {

                            if (data.fabric_groups[k].parts[l].svg_path_id == pathClass) {
                                applicableParts.push(data.fabric_groups[k].parts[l].svg_path_id);
                            }
                            /*for (var m = 0; m < data.fabric_groups[k].parts[l].brocade_parts.length; m++) {
                                if(data.fabric_groups[k].parts[l].brocade_parts){

                                }
                            };*/
                        };
                    };
                }

                //console.log(applicableParts);
                //applicableParts = _.uniq(applicableParts);
                for (var p = 0; p < applicableParts.length; p++) {
                    $('.' + applicableParts[p]).attr('fill', 'url(#' + thisPattern + ')');
                }; //it will apply the pattern to the partcular class
            };
            img.src = imagesrc;
        });
        //add to cart functionality starts here

        $('.add-cart').click(function(event) {
            var a = [];
            var b = [];
            $('#frontview .main_parts').find('path').each(function(index) {
                if ($(this).attr('fill') == '#FFFFFF') {
                    var thisclass = $(this).attr('class');
                    a.push(thisclass);
                }
            });

            for (var i = 0; i < a.length; i++) {
                for (var j = 0; j < allDressParts.length; j++) {

                    if (allDressParts[j] == a[i]) {
                        b.push(a[i]);
                    }
                };
            };
            a = _.uniq(a); //a arry represent all the pathclass with attribute #FFFFF classes
            b = _.uniq(b); //b array represents how many parts are empty inthe sence not applied any pattern
            if (b.length == 0) {
                addcart();
            } else {
                alert('Please complete the customisation of your dress');
            }
            //  
        });

        function addcart() {

            $.ajax({
                url: '/cart/add-dress',
                type: 'POST',
                data: {
                    id: data.id,
                    total_price: data.base_price
                },
                dataType: 'json',
                error: function() {
                    alert('error');
                },
                success: function(result) {
                    alert('successfully added to your cart');
                    window.location.replace("/cart");

                }
            })
        }

        var savingObject = [];
        $(document).on('click', '.save', function(e) {
            $('.group').css('display', 'none');
            $(this).attr('disabled', 'disabled');
            $(".savingJsonLoader").css('display', 'block')
            $(".savingJsonLoader .loader").css({
                'left': ($(window).width() / 2 - 64),
                'top': ($(window).height() / 2 - 10)
            });

            //to findout what are the clicked parts and applied pattern based on that get base 64
            $('#frontview .main_parts').find('path').each(function(index) {
                var filledPattern = $(this).attr('fill');
                filledPattern = filledPattern.replace('url(#', '');
                filledPattern = filledPattern.replace(')', '');
                //console.log(filledPattern);

                if (filledPattern.indexOf('img') > -1) {
                    filledPattern = $('.defsclass svg #' + filledPattern + ' image').attr('xlink:href');
                } else {
                    filledPattern = '#FFFFFF';
                }
                var saveObj = {};
                saveObj.partClass = $(this).attr('class');
                // saveObj.wid = $('.defsclass svg #' + filledPattern + ' image').width();
                // saveObj.hei = $('.defsclass svg #' + filledPattern + ' image').height();

                // filledPattern = $('.defsclass svg #' + filledPattern + ' image').attr('xlink:href');
                saveObj.patternUrl = filledPattern;
                savingObject.push(saveObj);

            });



            //$('.defsclass svg #img3 image').attr('xlink:href');  important
            var svg = document.getElementById("frontview");
            var svgData = new XMLSerializer().serializeToString(svg);

            var canvas = document.createElement("canvas");
            var svgSize = svg.getBoundingClientRect();
            console.log('width ' + svgSize.width + ' and height is ' + svgSize.height);
            canvas.width = svgSize.width - 110; //empty space is more after generating svg to png to reduce empty space -110 
            canvas.height = svgSize.height;
            var ctx = canvas.getContext("2d");

            var img = document.createElement("img");

            img.setAttribute("src", "data:image/svg+xml;base64," + btoa(svgData));

            img.onload = function() {
                ctx.drawImage(img, 0, 0);
                var frontViewData = canvas.toDataURL("image/png");

                $.ajax({
                    url: '/customised_dresses.json',
                    type: 'POST',
                    data: {
                        dress_id: data.id,
                        image_data_uri: frontViewData,
                        details: JSON.stringify(savingObject)
                    },
                    error: function() {
                        $(".savingJsonLoader").css('display', 'none');
                        alert("Could not save design, are you logged in?");
                    },
                    success: function(result) {
                        $(".savingJsonLoader").css('display', 'none');
                        alert("Design Saved Successfully!");
                        $(".save").removeAttr('disabled');

                        $('.prev-carousel ul').html('');
                        loadSavedDresses(data);


                    }
                })
            };
        });

        $(document).on('click', '.overview li', function() {
            //console.log($(this).attr('data-details'));
            $('.savedImgClass').remove();
            var retrievedImageDetails = $(this).attr('data-details');
            var savedJson = $.parseJSON(retrievedImageDetails);
            var applyPatterns = [];
            var temp = ''
            for (var i = 0; i < savedJson.length; i++) {
                //here we have to create pattern based on the saved images clicked clicked 
                // $('.defsclass').after("<svg><pattern id='savedimg" + i + "' patternUnits='userSpaceOnUse' width=" + savedJson[i].wid + " height=" + savedJson[i].hei + "><image xlink:href=" + savedJson[i].patternUrl + " x='0' y='0' width=" + savedJson[i].wid + " height=" + savedJson[i].hei + " /></pattern></svg>");
                temp += "<svg class='savedImgClass'><pattern id='savedimgPattern" + i + "' patternUnits='userSpaceOnUse' width='50px' height='50px'><image xlink:href=" + savedJson[i].patternUrl + " x='0' y='0' width='50px' height='50px' /></pattern></svg>";
                var finalObj = {};
                finalObj.classNames = savedJson[i].partClass;
                if (savedJson[i].patternUrl == '#FFFFFF') {
                    finalObj.patternUrl = '#FFFFFF';
                } else {
                    finalObj.patternUrl = 'savedimgPattern' + i;
                }

                applyPatterns.push(finalObj);

            };

            $('.defsclass').append(temp);



            $('#frontview .main_parts').find('path').each(function(index) {
                var thisClass = $(this).attr('class');

                $.each(applyPatterns, function(index1, val) {

                    // console.log(val.patternUrl.length);
                    if (thisClass == val.classNames) {

                        if (val.patternUrl.length > 10) {
                            console.log('pattern url length ' + val.patternUrl.length + ' and classname is' + thisClass)
                            $('.' + val.classNames).attr('fill', 'url(#' + val.patternUrl + ')');
                        } else {
                            $('.' + val.classNames).attr('fill', '#FFFFFF');
                        }
                    }
                });

            });




        });
        //loading previousely saved items while page loading
        function loadSavedDresses(data) {
            $.getJSON('/customised_dresses.json?id=' + data.id + '', function(data) {
                $('.prev-carousel ul').html('');
                $.each(data, function(index, el) {
                    //console.log(index + ' and ' + el.angle_0.angle_0.url);

                    var template = "<li data-details=" + el.details + "><img style='height:195px' src=" + el.image + "/></li>";
                    $('.prev-carousel ul').append(template);
                    //  console.log('image paths ' + el.image);

                    $('#slider1').tinycarousel({
                        animationTime: 300
                    });

                });

            });
        }





    }); //get json end
}); //onload end