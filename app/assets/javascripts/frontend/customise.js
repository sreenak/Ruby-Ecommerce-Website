$(document).ready(function() {
    $('.loadingcustomizepage').show();
    var w = $(window).width() / 2;
    var h = $(window).height() / 2;
    w = w - 50;
    h = h - 50;
    $('.loading').css({
        'top': h + 'px',
        'left': w + 'px',
        'display': 'block'
    });
});
$(window).load(function() {

    $.getJSON(dress_detail_url, function(data) {

        var allfabricgroupsDetails = []; //it containes all the fabric details with group names 
        var fabriccost = 0;

        var brocadeCost = 0;

        var embellishmentcost = 0;

        var basePrice = data.base_price;
        var totalprice = basePrice + fabriccost + brocadeCost + embellishmentcost;

        // console.log(pricing.fabriccost);
        var data = data;
        var pathClass = ''; //it will get the clicked part using data-part attribute
        var clickedPath = ''; // converting clicked pathclass string to jquery object

        var allDressParts = []; //it will usefull for validation when we click on save

        var fabricsDetails = [];
        var fabricId = [];
        var fabricNames = [];

        var brocadeDetails = [];
        var brocadeId = [];
        var brocadeName = [];

        var brocadesPatternsInserted = [];
        var embDetails = [];
        var s = Snap("#svg_wrapper"); // svgs loading wrapper

        var historyObj = {};

        historyObj.eachclick = [];


        // console.log(data.angle_0)
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
            $('#svg_wrapper').append('<div class="svg_base64loading"><p>Please wait ...</p></div>');
            Snap.load(data.angle_270, loadSvg4);
        }

        function loadSvg4(data4) {
            s.append(data4);
            setTimeout(function() {

                var continueLoopCount = 0; //to display the patterns in serialwise 
                $('.price').html(totalprice + ' INR');
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
                        var conntinuepidis;
                        if (fabriccolorid.length == 0) {
                            conntinuepidis = continueLoopCount++;
                            continueLoopCount++
                            var image = new Image();
                            image.src = data.fabric_groups[i].fabric_colors[j].swatch;
                            var obj = {};
                            obj.fabric_id = data.fabric_groups[i].fabric_colors[j].fabric_id;
                            obj.fabric_name = data.fabric_groups[i].fabric_colors[j].fabric_name;
                            obj.id = data.fabric_groups[i].fabric_colors[j].id;
                            obj.name = data.fabric_groups[i].fabric_colors[j].name;
                            obj.swatch = data.fabric_groups[i].fabric_colors[j].swatch;
                            obj.price = data.fabric_groups[i].fabric_colors[j].price;
                            obj.pid = data.fabric_groups[i].fabric_colors[j].id;
                            obj.group = data.fabric_groups[i].name;
                            fabricsDetails.push(obj);
                            fabricId.push(data.fabric_groups[i].fabric_colors[j].id);
                            fabricNames.push(data.fabric_groups[i].fabric_colors[j].fabric_name);
                        }


                        var obj1 = {};
                        obj1.fabric_id = data.fabric_groups[i].fabric_colors[j].fabric_id;
                        obj1.fabric_name = data.fabric_groups[i].fabric_colors[j].fabric_name;
                        obj1.id = data.fabric_groups[i].fabric_colors[j].id;
                        obj1.name = data.fabric_groups[i].fabric_colors[j].name;
                        obj1.swatch = data.fabric_groups[i].fabric_colors[j].swatch;
                        obj1.price = data.fabric_groups[i].fabric_colors[j].price;
                        obj1.pid = data.fabric_groups[i].fabric_colors[j].id;
                        obj1.group = data.fabric_groups[i].name;
                        allfabricgroupsDetails.push(obj1);



                    };



                    // console.log(allfabricgroupsDetails);
                    // to display the brocades initially

                    for (var k = 0; k < data.fabric_groups[i].parts.length; k++) {
                        for (var l = 0; l < data.fabric_groups[i].parts[k].brocade_parts.length; l++) {
                            var brocadecolorid = _.where(brocadeDetails, {
                                id: data.fabric_groups[i].parts[k].brocade_parts[l].brocade_id
                            });
                            // console.log(data.fabric_groups[i].parts[k].brocade_parts[l].brocade_id);
                            if (brocadecolorid == 0) {
                                continueLoopCount++;
                                var bro_obj = {};
                                bro_obj.brocade_id = data.fabric_groups[i].parts[k].brocade_parts[l].brocade_id;
                                bro_obj.name = data.fabric_groups[i].parts[k].brocade_parts[l].name;
                                bro_obj.swatch = data.fabric_groups[i].parts[k].brocade_parts[l].swatch;
                                bro_obj.image = data.fabric_groups[i].parts[k].brocade_parts[l].image;
                                bro_obj.partname = data.fabric_groups[i].parts[k].name;
                                bro_obj.price = data.fabric_groups[i].parts[k].brocade_parts[l].price;
                                bro_obj.pid = continueLoopCount;
                                bro_obj.group = data.fabric_groups[i].name;
                                brocadeDetails.push(bro_obj);
                                brocadeId.push(data.fabric_groups[i].parts[k].brocade_parts[l].brocade_id);
                                brocadeName.push('brocade');
                            }

                        };
                    };
                };

                console.log(brocadeDetails);
                //to display embellishments initially

                for (var n = 0; n < data.embelishment_groups.length; n++) {
                    for (var o = 0; o < data.embelishment_groups[n].parts.length; o++) {
                        for (var p = 0; p < data.embelishment_groups[n].parts[o].embellishment_parts.length; p++) {
                            // console.log('names are ' + data.embelishment_groups[n].parts[o].embellishment_parts[p].name);

                            var obj = {};
                            obj.embid = data.embelishment_groups[n].parts[o].embellishment_parts[p].id; //this id is embellishment id
                            obj.partname = data.embelishment_groups[n].parts[o].name;
                            obj.plainImg = data.embelishment_groups[n].parts[o].embellishment_parts[p].name;
                            obj.price = data.embelishment_groups[n].parts[o].embellishment_parts[p].price;
                            obj.png = data.embelishment_groups[n].parts[o].embellishment_parts[p].image;
                            obj.displayname = data.embelishment_groups[n].name;
                            embDetails.push(obj);

                        };
                    };

                };

                //appending sizes to sizing wrapper
                for (var s = 0; s < data.sizes.length; s++) {
                    $('#sizing').append('<p><input type="radio" name="size" value=' + data.sizes[s].id + ' /> ' + data.sizes[s].name + '</p>')
                }



                fabricId = _.uniq(fabricId);
                fabricNames = _.uniq(fabricNames);

                brocadeId = _.uniq(brocadeId);
                //  console.log(brocadeId);
                brocadeName = _.uniq(brocadeName);

                //displaying all fabrics intially without repeating

                for (var i = 0; i < fabricNames.length; i++) {
                    $('#material').append('<div style="clear:both"></div>');
                    $('#material').append('<p class="fabric_name">' + fabricNames[i] + '</p>');
                    for (var j = 0; j < fabricsDetails.length; j++) {
                        var image = new Image();
                        image.src = fabricsDetails[j].swatch;

                        if (fabricNames[i] == fabricsDetails[j].fabric_name) {
                            $('#material').append('<div class="pattern_div" id="divs' + fabricsDetails[j].pid + '" data-category="fabrics" data-originalid="' + fabricsDetails[j].id + '"><img  data-pid="img' + fabricsDetails[j].pid + '" data-id="' + fabricsDetails[j].pid + '" src="' + fabricsDetails[j].swatch + '" /><p>' + fabricsDetails[j].name + '</p></div>');
                        }
                        // console.log('image width ' + image.width + ' and height is ' + image.height);

                        //$('.defsclass').append("<svg><pattern id='img" + fabricsDetails[j].id + "' patternUnits='userSpaceOnUse' width=" + image.width + " height=" + image.height + "><image xlink:href=" + dress_details.fabrics[i].colors[j].swatch64 + " x='0' y='0' width=" + image.width + " height=" + image.height + " /></pattern></svg>");

                        // $('.defsclass').append("<svg><pattern id='img" + fabricsDetails[j].pid + "' patternUnits='userSpaceOnUse' width='50px' height='50px'><image xlink:href=" + fabricsDetails[j].swatch + " x='0' y='0' width='50px' height='50px' /></pattern></svg>");
                    };
                };

                // displaying all brocades intially without repeating
                //console.log(brocadeDetails);
                var brocadeDetailsIds = [] // to filter only one swath from the different images url
                for (var i = 0; i < brocadeName.length; i++) {
                    $('#material').append('<div style="clear:both"></div>');
                    $('#material').append('<p class="fabric_name">' + brocadeName[i] + '</p>');
                    for (var j = 0; j < brocadeDetails.length; j++) {

                        var checkingBrocadeId = _.where(brocadeDetailsIds, {
                            id: brocadeDetails[j].brocade_id
                        });
                        //  console.log(checkingBrocadeId);
                        if (checkingBrocadeId == 0) {
                            var obj = {};
                            obj.id = brocadeDetails[j].brocade_id;
                            brocadeDetailsIds.push(obj);
                            $('#material').append('<div class="pattern_div" data-group="' + brocadeDetails[j].group + '" id="divs' + brocadeDetails[j].pid + '" data-category="brocades" data-originalid="' + brocadeDetails[j].brocade_id + '"><img  data-pid="img' + brocadeDetails[j].pid + '" data-id="' + brocadeDetails[j].pid + '" src="' + brocadeDetails[j].swatch + '" /><p>' + brocadeDetails[j].name + '</p></div>');
                        }


                        // $('#material').append('<div class="pattern_div" id="divs' + brocadeDetails[j].pid + '" data-category="brocades" data-originalid="' + brocadeDetails[j].brocade_id + '"><img  data-pid="img' + brocadeDetails[j].pid + '" data-id="' + brocadeDetails[j].pid + '" src="' + brocadeDetails[j].swatch + '" /><p>' + brocadeDetails[j].name + '</p></div>');
                    };
                };

                var displayedemdids = [];

                for (var w = 0; w < embDetails.length; w++) {
                    var checkthisemdid = _.where(displayedemdids, {
                        id: embDetails[w].embid
                    });
                    if (checkthisemdid.length == 0) {
                        var obj = {};
                        obj.id = embDetails[w].embid;
                        displayedemdids.push(obj);
                        $('#embellishment').append('<div class="pattern_div" id="divs' + embDetails[w].embid + '" data-category="embellishments" data-originalid="' + embDetails[w].embid + '"><img  data-pid="img' + embDetails[w].embid + '" data-id="' + embDetails[w].embid + '" src="' + embDetails[w].plainImg + '" /><p>' + embDetails[w].displayname + '</p></div>');

                    }
                };
                $('.loadingcustomizepage,.loading').hide();
            }, 1000);
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

            var groupofpart;
            for (var i = 0; i < data.fabric_groups.length; i++) {
                for (var j = 0; j < data.fabric_groups[i].parts.length; j++) {
                    if (data.fabric_groups[i].parts[j].name == pathClass) {
                        for (var k = 0; k < data.fabric_groups[i].fabric_colors.length; k++) {
                            fabricPartId.push(data.fabric_groups[i].fabric_colors[k].id);
                            fabricPartName.push(data.fabric_groups[i].fabric_colors[k].fabric_name);
                            groupofpart = data.fabric_groups[i].name;
                        };

                        //to filter brocades according to the part
                        //  console.log(data.fabric_groups[i].parts[j].brocade_parts.length);
                        for (var o = 0; o < data.fabric_groups[i].parts[j].brocade_parts.length; o++) {
                            // console.log('brocadeid ' + data.fabric_groups[i].parts[j].brocade_parts[o].brocade_id);
                            brocadePartId.push(data.fabric_groups[i].parts[j].brocade_parts[o].brocade_id);
                            brocadePartName.push('brocade');
                        };

                    }
                };
            };

            //  console.log(groupofpart);

            fabricPartId = _.uniq(fabricPartId);
            fabricPartName = _.uniq(fabricPartName);
            brocadePartId = _.uniq(brocadePartId);
            brocadePartName = _.uniq(brocadePartName);

            $('#material').html('');

            //to find clicked class is belongs to which group


            /*for (var l = 0; l < fabricPartName.length; l++) {
                $('#material').append('<div style="clear:both"></div>');
                $('#material').append('<p class="fabric_name">' + fabricPartName[l] + '</p>');
                for (var m = 0; m < fabricPartId.length; m++) {
                    for (var n = 0; n < fabricsDetails.length; n++) {
                        if (fabricPartId[m] == fabricsDetails[n].id) {
                            $('#material').append('<div class="pattern_div" data-group="' + fabricsDetails[m].group + '"  data-price="' + fabricsDetails[m].price + '" id="divs' + fabricsDetails[m].pid + '" data-category="fabrics" data-originalid="' + fabricsDetails[m].id + '"><img  data-pid="img' + fabricsDetails[m].pid + '" data-id="' + fabricsDetails[m].pid + '" src="' + fabricsDetails[m].swatch + '" /><p>' + fabricsDetails[m].name + '</p></div>');
                        }
                    };
                };
            };*/


            for (var l = 0; l < fabricPartName.length; l++) {
                $('#material').append('<div style="clear:both"></div>');
                $('#material').append('<p class="fabric_name">' + fabricPartName[l] + '</p>');
                for (var m = 0; m < fabricPartId.length; m++) {
                    for (var n = 0; n < allfabricgroupsDetails.length; n++) {
                        if (allfabricgroupsDetails[n].fabric_name == fabricPartName[l]) {
                            if (groupofpart == allfabricgroupsDetails[n].group && fabricPartId[m] == allfabricgroupsDetails[n].id) {
                                //  console.log('swatches are --'+allfabricgroupsDetails[n].swatch);
                                $('#material').append('<div class="pattern_div" data-group="' + allfabricgroupsDetails[n].group + '" id="divs' + allfabricgroupsDetails[n].pid + '" data-category="fabrics" data-originalid="' + allfabricgroupsDetails[n].id + '"><img  data-pid="img' + allfabricgroupsDetails[n].pid + '" data-id="' + allfabricgroupsDetails[n].pid + '" src="' + allfabricgroupsDetails[n].swatch + '" /><p>' + allfabricgroupsDetails[n].name + '</p></div>');
                            }
                        }

                    };

                };

            };

            var brocadeDetailsIds = [];
            for (var p = 0; p < brocadePartName.length; p++) {
                $('#material').append('<div style="clear:both"></div>');
                $('#material').append('<p class="fabric_name">' + brocadePartName[p] + '</p>');
                for (var q = 0; q < brocadePartId.length; q++) {
                    for (var r = 0; r < brocadeDetails.length; r++) {
                        var checkingBrocadeId = _.where(brocadeDetailsIds, {
                            id: brocadeDetails[r].brocade_id
                        })

                        if (checkingBrocadeId.length == 0) {
                            var obj = {};
                            obj.id = brocadeDetails[r].brocade_id;
                            brocadeDetailsIds.push(obj);
                            $('#material').append('<div class="pattern_div" id="divs' + brocadeDetails[r].pid + '" data-category="brocades" data-originalid="' + brocadeDetails[r].brocade_id + '" ><img  data-pid="img' + brocadeDetails[r].pid + '" data-id="' + brocadeDetails[r].pid + '" src="' + brocadeDetails[r].swatch + '" /><p>' + brocadeDetails[r].name + '</p></div>');
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

            var gettinggroup = $(this).attr('data-group');

            var gettingCost;

            // gettingCost = parseInt(gettingCost);

            $('.pattern_div').attr('disabled', 'disabled');
            for (var a = 0; a < data.fabric_groups.length; a++) {
                if (data.fabric_groups[a].name == gettinggroup) {
                    for (var b = 0; b < data.fabric_groups[a].fabric_colors.length; b++) {
                        if (data.fabric_groups[a].fabric_colors[b].id == gettingOriginalId) {
                            //  console.log('price is ' + data.fabric_groups[a].fabric_colors[b].price);
                            gettingCost = data.fabric_groups[a].fabric_colors[b].price;
                        }
                    };
                }

            };


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


                //searching clickable parts using fabric id or brocade id or embellishment id
                if (gettinggroup == 'highlight fabric') {
                    brocadeCost = gettingCost;
                    console.log(' id id ' + gettingOriginalId + 'highlight fabric cost is ' + brocadeCost);
                }
                if (gettingCategory == 'fabrics' && gettinggroup == 'main fabric') {
                    fabriccost = gettingCost;
                    console.log('fabric id is ' + gettingOriginalId + ' main fabric cost ' + fabriccost);
                }
                if (gettingCategory == 'fabrics') {
                    if (patternIdLength == 0) { //if thisid pattern is not appened to defs class then it will append that pattern id 
                        $('.defsclass').append("<svg><pattern id='img" + thisId + "' patternUnits='userSpaceOnUse' width=" + img_width + " height=" + img_height + "><image xlink:href=" + dataURL + " x='0' y='0' width=" + img_width + " height=" + img_height + " /></pattern></svg>");
                        var obj = {};
                        obj.id = thisId;
                        alreadyPatternAppened.push(obj);
                    }
                    //this for loop is used to apply directly to main fabric parts, but not based on id 
                    for (var i = 0; i < data.fabric_groups.length; i++) {
                        for (var j = 0; j < data.fabric_groups[i].parts.length; j++) {
                            if (data.fabric_groups[i].parts[j].name == pathClass) {
                                for (var q = 0; q < data.fabric_groups[i].parts.length; q++) {
                                    applicableParts.push(data.fabric_groups[i].parts[q].name);
                                    // console.log('apllicable parts are ' + data.fabric_groups[i].parts[q].name);
                                };
                            }

                        };
                    };

                    //this will be useful to check the applicable patterns based on id
                    /*for (var i = 0; i < data.fabric_groups.length; i++) {
                        for (var j = 0; j < data.fabric_groups[i].fabric_colors.length; j++) {
                            if (gettingOriginalId == data.fabric_groups[i].fabric_colors[j].id) {
                                for (var k = 0; k < data.fabric_groups[i].parts.length; k++) {
                                    console.log('part names are ' + data.fabric_groups[i].parts[k].name);
                                    applicableParts.push(data.fabric_groups[i].parts[k].name);
                                };
                            }
                        };
                    };*/



                    //it will apply the pattern to the partcular class
                    for (var p = 0; p < applicableParts.length; p++) {
                        $('.' + applicableParts[p]).attr('fill', 'url(#' + thisPattern + ')');
                    };
                    updateUndoredo();


                }
                if (gettingCategory == 'brocades') {
                    applyBrocades(gettingOriginalId);
                }
                if (gettingCategory == 'embellishments') {
                    applyEmbellishment(gettingOriginalId);
                }
                updateprice();
                $('.pattern_div').removeAttr('disabled');
            };
            img.src = imagesrc;
        });

        function updateUndoredo() {
            var totallength = historyObj.eachclick.length;
            var currentIndex = historyObj.presentindex;
            if (totallength > currentIndex + 1) {
                historyObj.eachclick.splice(currentIndex + 1);
            }

            var eachclickDetails = [];
            updateprice();
            $('.main_parts,.group').find('path').each(function(index) {
                var object = {};
                object.partname = $(this).attr('class');
                object.pattern = $(this).attr('fill');

                if (object.pattern.indexOf('url') > -1) {
                    object.pattern = object.pattern.replace('url(#', '');
                    object.pattern = object.pattern.replace(')', '');
                }
                object.price = totalprice;
                eachclickDetails.push(object);
            });
            if (historyObj.eachclick.length > 0) {
                var gettinglength = historyObj.eachclick.length;
                var getlastIndex = historyObj.eachclick.length - 1;

                var historystring = JSON.stringify(historyObj.eachclick[getlastIndex]) || JSON.stringify(historyObj.eachclick[currentIndex]);
                var presentstring = JSON.stringify(eachclickDetails);
                if (historystring === presentstring) {
                    alert('This pattern is already applied');
                    return;
                } else {
                    historyObj.eachclick.push(eachclickDetails);
                    historyObj.presentindex = historyObj.eachclick.length - 1;
                }
            }
            if (historyObj.eachclick.length == 0) {
                historyObj.eachclick.push(eachclickDetails);
                historyObj.presentindex = historyObj.eachclick.length - 1;
            }

            //  console.log(JSON.stringify(historyObj));



        }


        $('.undo').click(function() {
            $('.main_parts,.group').find('path').each(function(index) {
                $(this).attr('fill', '#FFFFFF');

            });

            $('.group').hide();
            var undoindex = historyObj.presentindex;
            if (undoindex == 0 || undoindex < 0) {
                embellishmentcost = 0;
                fabriccost = 0;
                brocadeCost = 0;
                totalprice = data.basePrice;
                updateprice();

                historyObj.presentindex = -1;
                return;
            }
            undoindex = undoindex - 1;
            historyObj.presentindex = undoindex;
            for (var i = 0; i < historyObj.eachclick[undoindex].length; i++) {
                var partname = historyObj.eachclick[undoindex][i].partname;
                var pattern = historyObj.eachclick[undoindex][i].pattern;
                var totalpriceis = historyObj.eachclick[undoindex][i].price;

                totalpriceis = parseInt(totalpriceis);
                undoredoprice(totalpriceis);



                var embClass = partname;
                embClass = embClass.replace('emb_', '');

                if (partname.indexOf('emb') > -1 && pattern == '#FFFFFF') {
                    $('.' + embClass + '_group').hide();
                }
                if (partname.indexOf('emb') > -1 && pattern != '#FFFFFF') {
                    $('.' + embClass + '_group').show();
                }
                if (pattern == '#FFFFFF') {
                    $('.' + partname).attr('fill', '#FFFFFF');
                } else {
                    $('.' + partname).attr('fill', 'url(#' + pattern + ')');
                }
            }
        });

        $('.redo').click(function() {

            //  console.log('total length is ' + historyObj.eachclick.length + ' and present index is ' + historyObj.presentindex);

            if (historyObj.eachclick.length == historyObj.presentindex + 1) {
                return;
            }
            $('.main_parts,.group').find('path').each(function(index) {
                $(this).attr('fill', '#FFFFFF');
            });
            var redoindex = historyObj.presentindex;
            redoindex = redoindex + 1;
            if (redoindex == historyObj.eachclick.length) {
                return;
            }
            historyObj.presentindex = redoindex;
            for (var i = 0; i < historyObj.eachclick[redoindex].length; i++) {
                var partname = historyObj.eachclick[redoindex][i].partname;
                var pattern = historyObj.eachclick[redoindex][i].pattern;

                var totalpriceis = historyObj.eachclick[redoindex][i].price;

                totalpriceis = parseInt(totalpriceis);
                undoredoprice(totalpriceis);

                if (partname.indexOf('emb') > -1 && pattern != '#FFFFFF') {
                    var embClass = partname;
                    embClass = embClass.replace('emb_', '');
                    $('.' + embClass + '_group').show();
                }

                if (pattern == '#FFFFFF') {
                    $('.' + partname).attr('fill', '#FFFFFF');
                } else {
                    $('.' + partname).attr('fill', 'url(#' + pattern + ')');
                }
            }
        });

        var embAllDetails = [];
        var inserted_Emb_Patternsare = [];
        var embdetailswithbase64 = [];
        var finalEmbDeatils = [];

        var allEmbellishmentDetailsArray = [];

        function applyEmbellishment(embid) {
            var embpngimgesArray = [];
            finalEmbDeatils = [];
            embdetailswithbase64 = [];
            embAllDetails = [];

            for (var i = 0; i < embDetails.length; i++) {

                if (embDetails[i].embid == embid) {
                    var embobj = {};
                    embobj.embid = embDetails[i].embid;
                    embobj.plainImg = embDetails[i].plainImg;
                    embobj.png = embDetails[i].png;
                    embobj.partname = embDetails[i].partname;
                    embobj.price = embDetails[i].price;
                    embpngimgesArray.push(embobj.png);
                    embAllDetails.push(embobj);
                }
            };
            var embIdIn_Defs = _.where(inserted_Emb_Patternsare, {
                id: embid
            });
            embpngimgesArray = _.uniq(embpngimgesArray);
            // console.log(embpngimgesArray);

            if (embIdIn_Defs.length == 0) {
                async.eachSeries(embpngimgesArray, function iterator(item, callback) {
                    convertingembImg_to_base64(item, embid, callback);
                }, function() {
                    var obj = {};
                    obj.id = embid;
                    inserted_Emb_Patternsare.push(obj);
                    $('.svg_base64loading').hide();
                    $('.pattern_div').removeAttr('disabled');
                    for (var i = 0; i < embdetailswithbase64.length; i++) {
                        for (var j = 0; j < embAllDetails.length; j++) {
                            //  console.log('imgsrc ' + embdetailswithbase64[i].imgsrc + '   ' + embAllDetails[j].png)
                            if (embdetailswithbase64[i].imgsrc.indexOf(embAllDetails[j].png) > -1) {
                                var f_obj = {};
                                f_obj.embid = embAllDetails[j].embid;
                                f_obj.partname = embAllDetails[j].partname;
                                f_obj.price = embAllDetails[j].price;
                                f_obj.width = embdetailswithbase64[i].width;
                                f_obj.base64 = embdetailswithbase64[i].base64;
                                f_obj.height = embdetailswithbase64[i].height;
                                finalEmbDeatils.push(f_obj);
                                allEmbellishmentDetailsArray.push(f_obj);
                            }
                        };
                    };
                    embellishmentcost = 0;
                    for (var k = 0; k < finalEmbDeatils.length; k++) {
                        // $('.defsclass').append("<svg><pattern id='img_emb_" + finalEmbDeatils[k].embid + "_" + finalEmbDeatils[k].partname + "' patternContentUnits='objectBoundingBox' viewBox='0 0 1 1' width='100%' height='100%' preserveAspectRatio='xMidYMid slice'><image preserveAspectRatio='xMidYMid slice' xlink:href=" + finalEmbDeatils[k].base64 + " width='1' height='1' /></pattern></svg>");
                        $('.defsclass').append("<svg><pattern x='0' y='0' id='img_emb_" + finalEmbDeatils[k].embid + "_" + finalEmbDeatils[k].partname + "'  patternUnits='userSpaceOnUse' width=" + finalEmbDeatils[k].width + " height=" + finalEmbDeatils[k].height + "><image xlink:href=" + finalEmbDeatils[k].base64 + " x='0' y='0' width=" + finalEmbDeatils[k].width + " height=" + finalEmbDeatils[k].height + " /></pattern></svg>");
                        $('.group').find('path').each(function(index) {
                            // console.log('partname ' + finalEmbDeatils[k].partname + ' class name' + $(this).attr('class'));
                            if ($(this).attr('class') == finalEmbDeatils[k].partname) {
                                var gettingClass = finalEmbDeatils[k].partname;
                                //  console.log('class name is ' + finalEmbDeatils[k].partname);
                                gettingClass = gettingClass.replace('emb_', '');
                                $('.' + gettingClass + '_group').show();

                                $('.' + finalEmbDeatils[k].partname).attr('fill', 'url(#img_emb_' + finalEmbDeatils[k].embid + '_' + finalEmbDeatils[k].partname + ')');

                                console.log('part name ' + finalEmbDeatils[k].partname + ' and price is ' + finalEmbDeatils[k].price);
                                embellishmentcost += parseInt(finalEmbDeatils[k].price);
                                console.log('embellishment part name is :' + finalEmbDeatils[k].partname + ' and cost is = ' + parseInt(finalEmbDeatils[k].price));
                            }
                        });
                    };

                    console.log('EMBELLISHMENT TOTAL COST IS : ' + embellishmentcost);
                    setTimeout(function() {
                        updateUndoredo();
                    }, 1000);

                });

            } else {

                var dill = _.where(allEmbellishmentDetailsArray, {
                    embid: embid
                });

                embellishmentcost = 0;
                for (var k = 0; k < allEmbellishmentDetailsArray.length; k++) {

                    // $('.defsclass').append("<svg><pattern id='img_emb_" + finalEmbDeatils[k].embid + "_" + finalEmbDeatils[k].partname + "' patternContentUnits='objectBoundingBox' viewBox='0 0 1 1' width='100%' height='100%' preserveAspectRatio='xMidYMid slice'><image preserveAspectRatio='xMidYMid slice' xlink:href=" + finalEmbDeatils[k].base64 + " width='1' height='1' /></pattern></svg>");
                    $('.group').find('path').each(function(index) {

                        if (($(this).attr('class') == allEmbellishmentDetailsArray[k].partname) && (allEmbellishmentDetailsArray[k].embid == embid)) {

                            var gettingClass = allEmbellishmentDetailsArray[k].partname;
                            //  console.log('class name is ' + finalEmbDeatils[k].partname);
                            gettingClass = gettingClass.replace('emb_', '');

                            $('.' + gettingClass + '_group').show();

                            $('.' + allEmbellishmentDetailsArray[k].partname).attr('fill', 'url(#img_emb_' + allEmbellishmentDetailsArray[k].embid + '_' + allEmbellishmentDetailsArray[k].partname + ')');

                            console.log('part name ' + allEmbellishmentDetailsArray[k].partname + ' and price is ' + allEmbellishmentDetailsArray[k].price);
                            embellishmentcost += parseInt(allEmbellishmentDetailsArray[k].price);

                        }
                    });
                };
                setTimeout(function() {
                    updateUndoredo();
                }, 1000);
            }
            updateprice();




        }

        function convertingembImg_to_base64(item, embid, callback) {
            var img = new Image();
            img.onload = function() {
                $('.svg_base64loading').show();
                $('.pattern_div').attr('disabled', 'disabled');
                var canvas = document.createElement("canvas");
                canvas.width = this.width;
                canvas.height = this.height;
                var ctx = canvas.getContext("2d");
                ctx.drawImage(this, 0, 0);
                var dataURL = canvas.toDataURL("image/png");
                dataURL.replace(/^data:image\/(png|jpg);base64,/, "");

                var obj = {};
                obj.imgsrc = img.src;
                obj.width = img.width;
                obj.height = img.height;
                obj.base64 = dataURL;
                // console.log('base 64 ' + dataURL);
                embdetailswithbase64.push(obj);

                callback();
            }
            img.src = item;
        }


        var finalBrocadeDetails = [];
        var brocadePatterns = [];
        var finalBrocadesArray = [];

        function applyBrocades(brocadeId) {
            //  console.log(brocadeDetails);
            var imagesArray = []; //contails all png source which has to convert from png to base64
            finalBrocadeDetails = [];
            brocadePatterns = []; //while using async to convert base 64 all base64 formate and src will be here to match with existing parts
            for (var i = 0; i < brocadeDetails.length; i++) {
                // console.log('brocade_id ' + brocadeDetails[i].brocade_id + ' brocadeId' + brocadeId);
                if (brocadeDetails[i].brocade_id == brocadeId) {
                    var broObj = {};
                    broObj.brocade_id = brocadeDetails[i].brocade_id;
                    broObj.image = brocadeDetails[i].image;
                    broObj.name = brocadeDetails[i].name;
                    broObj.partname = brocadeDetails[i].partname;
                    broObj.price = brocadeDetails[i].price;
                    imagesArray.push(brocadeDetails[i].image);
                    finalBrocadeDetails.push(broObj);
                }
            };
            console.log(brocadeDetails);

            var brocadeId_InDef = _.where(brocadesPatternsInserted, {
                id: brocadeId
            })
            console.log(brocadeId_InDef);
            if (brocadeId_InDef.length == 0) {

                async.eachSeries(imagesArray, function iterator(item, callback) {
                    converting(item, brocadeId, callback);
                }, function() {
                    $('.svg_base64loading').hide();
                    $('.pattern_div').removeAttr('disabled');
                    var obj = {};
                    obj.id = brocadeId;
                    brocadesPatternsInserted.push(obj);

                    console.log('brocade patterns ');
                    console.log(brocadePatterns)
                    for (var i = 0; i < brocadePatterns.length; i++) {
                        for (var j = 0; j < finalBrocadeDetails.length; j++) {
                            console.log((brocadePatterns[i].imgsrc.indexOf(finalBrocadeDetails[j].image) > -1) && (brocadePatterns[i].brocadeId == brocadeId));
                            if ((brocadePatterns[i].imgsrc.indexOf(finalBrocadeDetails[j].image) > -1) && (brocadePatterns[i].brocadeId == brocadeId)) {
                                var obj1 = {};
                                obj1.brocadeId = finalBrocadeDetails[j].brocade_id;
                                obj1.partname = finalBrocadeDetails[j].partname;
                                obj1.price = finalBrocadeDetails[j].price;
                                obj1.base64 = brocadePatterns[i].base64;
                                obj1.width = brocadePatterns[i].width;
                                obj1.height = brocadePatterns[i].height;
                                finalBrocadesArray.push(obj1);

                            }

                        };
                    };

                    brocadeCost = 0;
                    for (var k = 0; k < finalBrocadesArray.length; k++) {
                        $('.defsclass').append("<svg><pattern id='img_brocade_" + finalBrocadesArray[k].brocadeId + "_" + finalBrocadesArray[k].partname + "' patternContentUnits='objectBoundingBox' viewBox='0 0 1 1' width='100%' height='100%' preserveAspectRatio='xMidYMid slice'><image preserveAspectRatio='xMidYMid slice' xlink:href=" + finalBrocadesArray[k].base64 + " width='1' height='1' /></pattern></svg>");
                        //$('.defsclass').append("<svg><pattern id='img_brocade_" + finalBrocadesArray[k].brocadeId + "_" + finalBrocadesArray[k].partname + "' patternUnits='userSpaceOnUse' x='0' y='0'  width=" + finalBrocadesArray[k].width + " height=" + finalBrocadesArray[k].height + " preserveAspectRatio='xMidYMid slice'><image preserveAspectRatio='xMidYMid slice' xlink:href=" + finalBrocadesArray[k].base64 + " width=" + finalBrocadesArray[k].width + " height=" + finalBrocadesArray[k].height + " /></pattern></svg>");
                        $('.main_parts').find('path').each(function(index) {
                            if (($(this).attr('class') == finalBrocadesArray[k].partname) && (finalBrocadesArray[k].brocadeId == brocadeId)) {

                                brocadeCost += parseInt(finalBrocadesArray[k].price);
                                console.log(' brocade part name inside:' + finalBrocadesArray[k].partname + ' and cost is ' + parseInt(finalBrocadesArray[k].price));
                                $('.' + finalBrocadesArray[k].partname).attr('fill', 'url(#img_brocade_' + finalBrocadesArray[k].brocadeId + '_' + finalBrocadesArray[k].partname + ')');
                            }
                        });
                    };
                    console.log('BROCADE TOTAL COST is inside : ' + brocadeCost);
                    setTimeout(function() {
                        updateUndoredo();
                    }, 1000);

                });


            } else {
                //console.log(finalBrocadesArray);
                brocadeCost = 0;
                for (var k = 0; k < finalBrocadesArray.length; k++) {
                    //$('.defsclass').append("<svg><pattern id='img_brocade_" + finalBrocadesArray[k].brocadeId + "_" + finalBrocadesArray[k].partname + "' patternContentUnits='objectBoundingBox' viewBox='0 0 1 1' width='100%' height='100%' preserveAspectRatio='xMidYMid slice'><image preserveAspectRatio='xMidYMid slice' xlink:href=" + finalBrocadesArray[k].base64 + " width='1' height='1' /></pattern></svg>");

                    if (finalBrocadesArray[k].brocadeId == brocadeId) {

                        $('.main_parts').find('path').each(function(index) {
                            if ($(this).attr('class') == finalBrocadesArray[k].partname) {
                                console.log(' brocade part name outside :' + finalBrocadesArray[k].partname + ' and cost is ' + parseInt(finalBrocadesArray[k].price));
                                brocadeCost += parseInt(finalBrocadesArray[k].price);
                                $('.' + finalBrocadesArray[k].partname).attr('fill', 'url(#img_brocade_' + finalBrocadesArray[k].brocadeId + '_' + finalBrocadesArray[k].partname + ')');
                            }
                        });
                    }
                };
                console.log('BROCADE TOTAL COST is outside : ' + brocadeCost);
                setTimeout(function() {
                    updateUndoredo();
                }, 1000);
            }


            // console.log('brocade cost is ' + brocadeCost);

        }



        function converting(item, brocadeId, callback) {
            var img = new Image();
            img.onload = function() {
                $('.svg_base64loading').show();
                $('.pattern_div').attr('disabled', 'disabled');
                var canvas = document.createElement("canvas");
                canvas.width = this.width;
                canvas.height = this.height;
                var ctx = canvas.getContext("2d");
                ctx.drawImage(this, 0, 0);
                var dataURL = canvas.toDataURL("image/png");
                dataURL.replace(/^data:image\/(png|jpg);base64,/, "");

                var obj = {};
                obj.imgsrc = img.src;
                obj.width = img.width;
                obj.height = img.height;
                obj.base64 = dataURL;
                obj.brocadeId = brocadeId;
                // console.log('base 64 ' + dataURL);
                brocadePatterns.push(obj);

                callback();
            }
            img.src = item;

        }
        //after concerting 

        $('.add-cart').click(function(event) {
            var selectedsize;
            if ($('#sizing input[type=radio]:checked').size() < 1) {
                alert('Please select any size');
                return;
            } else {
                selectedsize = $('#sizing input[type=radio]:checked').val();
            }
            updateprice()
            var a = [];
            var b = [];
            $('.main_parts').find('path').each(function(index) {
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
                addcart(selectedsize);
            } else {
                alert('Please complete the customisation of your dress');
            }
            //  
        });

        function addcart(selectedsize) {

            $.ajax({
                url: '/cart/add-dress',
                type: 'POST',
                data: {
                    id: data.id,
                    size: selectedsize,
                    total_price: totalprice
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
            savingObject = [];
            $('.group').css('display', 'none');
            $(this).attr('disabled', 'disabled');
            $(".savingJsonLoader").css('display', 'block')
            $(".savingJsonLoader .loader").css({
                'left': ($(window).width() / 2 - 64),
                'top': ($(window).height() / 2 - 10)
            });

            //to findout what are the clicked parts and applied pattern based on that get base 64
            $('.main_parts,.group').find('path').each(function(index) {
                var filledPattern = $(this).attr('fill');
                filledPattern = filledPattern.replace('url(#', '');
                filledPattern = filledPattern.replace(')', '');
                var saveObj = {};
                saveObj.partClass = $(this).attr('class');
                if (filledPattern.indexOf('img') > -1) {
                    var imagePatternUrl = filledPattern;
                    filledPattern = $('.defsclass svg #' + filledPattern + ' image').attr('xlink:href');
                    saveObj.wid = $('.defsclass svg pattern#' + imagePatternUrl + '').attr('width');
                    saveObj.hei = $('.defsclass svg pattern#' + imagePatternUrl + '').attr('height');

                } else {
                    filledPattern = '#FFFFFF';
                    saveObj.wid = 50;
                    saveObj.hei = 50;
                }
                saveObj.patternUrl = filledPattern;
                savingObject.push(saveObj);
            });

            var svg = document.getElementById("frontview");
            var svgData = new XMLSerializer().serializeToString(svg);

            var canvas = document.createElement("canvas");
            var svgSize = svg.getBoundingClientRect();

            canvas.width = svgSize.width - 110; //empty space is more after generating svg to png to reduce empty space -110 
            canvas.height = svgSize.height;
            var ctx = canvas.getContext("2d");

            var img = document.createElement("img");

            img.setAttribute("src", "data:image/svg+xml;base64," + btoa(svgData));




            img.onload = function() {
                ctx.drawImage(img, 0, 0);
                var frontViewData = canvas.toDataURL("image/png");

                for (var i = 0; i < savingObject.length; i++) {
                    if ((savingObject[i].partClass.indexOf('emb') > -1) && (savingObject[i].patternUrl == '#FFFFFF')) {
                        var gettingpartclass = savingObject[i].partClass;
                        gettingpartclass = gettingpartclass.replace('emb_', '');
                        gettingpartclass = gettingpartclass + '_group';
                        $('.' + gettingpartclass).hide();
                    }
                };

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
            var emb_groups_enabled = [];
            $('.savedImgClass').remove();
            var retrievedImageDetails = $(this).attr('data-details');
            var savedJson = $.parseJSON(retrievedImageDetails);
            var applyPatterns = [];
            var temp = ''
            for (var i = 0; i < savedJson.length; i++) {
                //here we have to create pattern based on the saved images clicked clicked 
                temp += "<svg class='savedImgClass'><pattern id='savedimgPattern" + i + "' patternUnits='userSpaceOnUse' width=" + savedJson[i].wid + " height=" + savedJson[i].hei + "><image xlink:href=" + savedJson[i].patternUrl + " x='0' y='0' width=" + savedJson[i].wid + " height=" + savedJson[i].hei + " /></pattern></svg>";
                var finalObj = {};
                finalObj.classNames = savedJson[i].partClass;
                if (savedJson[i].patternUrl == '#FFFFFF') {
                    finalObj.patternUrl = '#FFFFFF';
                } else {
                    finalObj.patternUrl = 'savedimgPattern' + i;
                }
                /* if (savedJson[i].partClass.indexOf('emb') > -1) {
                    var withgroupclassname = savedJson[i].partClass + '_group';
                    withgroupclassname = withgroupclassname.replace('emb_', '');
                    emb_groups_enabled.push(withgroupclassname);
                }*/


                //to display embellishment groups


                applyPatterns.push(finalObj);

            };

            $('.defsclass').append(temp);
            $('.main_parts').find('path').each(function(index) {
                var thisClass = $(this).attr('class');

                $.each(applyPatterns, function(index1, val) {

                    // console.log(val.patternUrl.length);
                    if (thisClass == val.classNames) {

                        if (val.patternUrl.length > 10) {
                            // console.log('pattern url length ' + val.patternUrl.length + ' and classname is' + thisClass)
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
                    $('#slider1').tinycarousel();
                    var slider = $("#slider1").data("plugin_tinycarousel");


                    var template = "<li data-details=" + el.details + "><img style='height:195px' src='" + el.image + "'/></li>";
                    $('.prev-carousel ul').append(template);
                    slider.update();

                });

            });
        }
        $('#slider1').tinycarousel({
            animationTime: 300
        });

        function undoredoprice(undoredototalprice) {
            totalprice = undoredototalprice;
            $('.price').html(undoredototalprice + ' INR');
        }

        function updateprice() {
            totalprice = basePrice + fabriccost + brocadeCost + embellishmentcost;
            $('.price').html(totalprice + ' INR');
        }
        //undo redo functionality starts here ====================================



        //getting what are the filled patterns accoring to the body parts



        // ==================================== undo redo functionality ends here

    }); //get json end


    $('#dressname').on("input", function() {
        var dInput = this.value;
        $('.dress_name').text(dInput);
        if (dInput.length > 0) {
            $('.lable_card,.designinput').show();
        } else {
            $('.lable_card,.designinput').hide();
        }
    });
    $('#designername').on("input", function() {
        var dInput = this.value;
        $('.designbyname p').text(dInput);
        if (dInput.length > 0) {
            $('.designby,.designbyname').show();
        } else {
            $('.designby,.designbyname').hide();
        }
    });

}); //onload end