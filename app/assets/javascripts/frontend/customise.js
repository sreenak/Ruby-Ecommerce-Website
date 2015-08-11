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
        Snap.load(data.angle_0, loadSvg1);

        var add_to_cart_Obj = {};
        add_to_cart_Obj.details = [];


        var present_Id_ofClickedElem;
        var present_Group_ClickedElem;

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

                //to display embellishments initially

                for (var n = 0; n < data.embelishment_groups.length; n++) {
                    for (var o = 0; o < data.embelishment_groups[n].parts.length; o++) {
                        for (var p = 0; p < data.embelishment_groups[n].parts[o].embellishment_parts.length; p++) {


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

                    };
                };

                // displaying all brocades intially without repeating

                var brocadeDetailsIds = [] // to filter only one swath from the different images url
                for (var i = 0; i < brocadeName.length; i++) {
                    $('#material').append('<div style="clear:both"></div>');
                    $('#material').append('<p class="fabric_name">' + brocadeName[i] + '</p>');
                    for (var j = 0; j < brocadeDetails.length; j++) {

                        var checkingBrocadeId = _.where(brocadeDetailsIds, {
                            id: brocadeDetails[j].brocade_id
                        });

                        if (checkingBrocadeId == 0) {
                            var obj = {};
                            obj.id = brocadeDetails[j].brocade_id;
                            brocadeDetailsIds.push(obj);
                            $('#material').append('<div class="pattern_div" data-group="' + brocadeDetails[j].group + '" id="divs' + brocadeDetails[j].pid + '" data-category="brocades" data-originalid="' + brocadeDetails[j].brocade_id + '"><img  data-pid="img' + brocadeDetails[j].pid + '" data-id="' + brocadeDetails[j].pid + '" src="' + brocadeDetails[j].swatch + '" /><p>' + brocadeDetails[j].name + '</p></div>');
                        }
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

                        for (var o = 0; o < data.fabric_groups[i].parts[j].brocade_parts.length; o++) {

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
                    for (var n = 0; n < allfabricgroupsDetails.length; n++) {
                        if (allfabricgroupsDetails[n].fabric_name == fabricPartName[l]) {
                            if (groupofpart == allfabricgroupsDetails[n].group && fabricPartId[m] == allfabricgroupsDetails[n].id) {

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

                            $('#material').append('<div class="pattern_div" data-group=' + brocadeDetails[r].group + ' id="divs' + brocadeDetails[r].pid + '" data-category="brocades" data-originalid="' + brocadeDetails[r].brocade_id + '" ><img  data-pid="img' + brocadeDetails[r].pid + '" data-id="' + brocadeDetails[r].pid + '" src="' + brocadeDetails[r].swatch + '" /><p>' + brocadeDetails[r].name + '</p></div>');
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

            var gettingCategory = $(this).attr('data-category');
            var gettingOriginalId = $(this).attr('data-originalid');

            var gettinggroup = $(this).attr('data-group');

            var gettingCost;


            // gettingCost = parseInt(gettingCost);

            $('.pattern_div').css({
                'opacity': '0.5'
            });
            $('.pattern_div').prop('disabled', true);
            for (var a = 0; a < data.fabric_groups.length; a++) {
                if (data.fabric_groups[a].name == gettinggroup) {
                    for (var b = 0; b < data.fabric_groups[a].fabric_colors.length; b++) {
                        if (data.fabric_groups[a].fabric_colors[b].id == gettingOriginalId) {

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

                }
                if (gettingCategory == 'fabrics' && gettinggroup == 'main fabric') {
                    fabriccost = gettingCost;

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
                            if ((data.fabric_groups[i].parts[j].name == pathClass) && (data.fabric_groups[i].name == gettinggroup)) {
                                // console.log(data.fabric_groups[i].id);
                                for (var q = 0; q < data.fabric_groups[i].parts.length; q++) {
                                    applicableParts.push(data.fabric_groups[i].parts[q].name);

                                };
                            }

                        };
                    };
                    //it will apply the pattern to the partcular class
                    for (var p = 0; p < applicableParts.length; p++) {
                        $('.' + applicableParts[p]).attr('fill', 'url(#' + thisPattern + ')');
                    };
                    updateUndoredo();


                }
                if (gettingCategory == 'brocades') {
                    applyBrocades(gettingOriginalId, gettinggroup);

                }
                if (gettingCategory == 'embellishments') {
                    applyEmbellishment(gettingOriginalId, gettinggroup);
                }
                updateprice();
                $('.pattern_div').css({
                    'opacity': '1'
                });
                $('.pattern_div').prop('disabled', false);
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

        function applyEmbellishment(embid, gettinggroup) {
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


            if (embIdIn_Defs.length == 0) {
                async.eachSeries(embpngimgesArray, function iterator(item, callback) {
                    convertingembImg_to_base64(item, embid, callback);
                }, function() {
                    var obj = {};
                    obj.id = embid;
                    inserted_Emb_Patternsare.push(obj);
                    $('.svg_base64loading').hide();
                    $('.pattern_div').prop("disabled", false);
                    $('.pattern_div').css({
                        'opacity': '1'
                    });
                    for (var i = 0; i < embdetailswithbase64.length; i++) {
                        for (var j = 0; j < embAllDetails.length; j++) {

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
                        $('.defsclass').append("<svg><pattern id='img_emb_" + finalEmbDeatils[k].embid + "_" + finalEmbDeatils[k].partname + "' patternUnits='objectBoundingBox' viewBox='0 0 1 1' width='100%' height='100%' preserveAspectRatio='xMidYMid slice'><image xlink:href=" + finalEmbDeatils[k].base64 + " width='1' height='1' /></pattern></svg>");

                        $('.group').find('path').each(function(index) {

                            if ($(this).attr('class') == finalEmbDeatils[k].partname) {
                                var gettingClass = finalEmbDeatils[k].partname;

                                gettingClass = gettingClass.replace('emb_', '');
                                $('.' + gettingClass + '_group').show();

                                $('.' + finalEmbDeatils[k].partname).attr('fill', 'url(#img_emb_' + finalEmbDeatils[k].embid + '_' + finalEmbDeatils[k].partname + ')');


                                embellishmentcost += parseInt(finalEmbDeatils[k].price);

                            }
                        });
                    };


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
                    $('.group').find('path').each(function(index) {

                        if (($(this).attr('class') == allEmbellishmentDetailsArray[k].partname) && (allEmbellishmentDetailsArray[k].embid == embid)) {

                            var gettingClass = allEmbellishmentDetailsArray[k].partname;

                            gettingClass = gettingClass.replace('emb_', '');

                            $('.' + gettingClass + '_group').show();

                            $('.' + allEmbellishmentDetailsArray[k].partname).attr('fill', 'url(#img_emb_' + allEmbellishmentDetailsArray[k].embid + '_' + allEmbellishmentDetailsArray[k].partname + ')');

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
                $('.pattern_div').prop("disabled", true);
                $('.pattern_div').css({
                    'opacity': '0.5'
                });
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

                embdetailswithbase64.push(obj);

                callback();
            }
            img.src = item;
        }


        var finalBrocadeDetails = [];
        var brocadePatterns = [];
        var finalBrocadesArray = [];

        function applyBrocades(brocadeId, gettinggroup) {

            var imagesArray = []; //contails all png source which has to convert from png to base64
            finalBrocadeDetails = [];
            brocadePatterns = []; //while using async to convert base 64 all base64 formate and src will be here to match with existing parts
            for (var i = 0; i < brocadeDetails.length; i++) {


                if (brocadeDetails[i].brocade_id == brocadeId) {
                    var broObj = {};
                    broObj.brocade_id = brocadeDetails[i].brocade_id;
                    broObj.image = brocadeDetails[i].image;
                    broObj.name = brocadeDetails[i].name;
                    broObj.partname = brocadeDetails[i].partname;
                    broObj.price = brocadeDetails[i].price;
                    broObj.group = brocadeDetails[i].group;
                    imagesArray.push(brocadeDetails[i].image);
                    finalBrocadeDetails.push(broObj);
                }
            };


            var brocadeId_InDef = _.where(brocadesPatternsInserted, {
                id: brocadeId
            })

            if (brocadeId_InDef.length == 0) {

                async.eachSeries(imagesArray, function iterator(item, callback) {
                    converting(item, brocadeId, callback);
                }, function() {
                    $('.svg_base64loading').hide();
                    $('.pattern_div').prop("disabled", false);
                    $('.pattern_div').css({
                        'opacity': '1'
                    });
                    var obj = {};
                    obj.id = brocadeId;
                    brocadesPatternsInserted.push(obj);

                    for (var i = 0; i < brocadePatterns.length; i++) {
                        for (var j = 0; j < finalBrocadeDetails.length; j++) {
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
                        $('.defsclass').append("<svg><pattern id='img_brocade_" + finalBrocadesArray[k].brocadeId + "_" + finalBrocadesArray[k].partname + "' patternContentUnits='objectBoundingBox' viewBox='0 0 1 1' width='100%' height='100%' preserveAspectRatio='xMidYMid slice'><image xlink:href=" + finalBrocadesArray[k].base64 + " width='1' height='1' /></pattern></svg>");
                        $('.main_parts').find('path').each(function(index) {
                            if (($(this).attr('class') == finalBrocadesArray[k].partname) && (finalBrocadesArray[k].brocadeId == brocadeId)) {

                                brocadeCost += parseInt(finalBrocadesArray[k].price);
                                $('.' + finalBrocadesArray[k].partname).attr('fill', 'url(#img_brocade_' + finalBrocadesArray[k].brocadeId + '_' + finalBrocadesArray[k].partname + ')');
                            }
                        });
                    };
                    setTimeout(function() {
                        updateUndoredo();
                    }, 1000);

                });


            } else {

                brocadeCost = 0;
                for (var k = 0; k < finalBrocadesArray.length; k++) {
                    if (finalBrocadesArray[k].brocadeId == brocadeId) {

                        $('.main_parts').find('path').each(function(index) {
                            if ($(this).attr('class') == finalBrocadesArray[k].partname) {

                                brocadeCost += parseInt(finalBrocadesArray[k].price);
                                $('.' + finalBrocadesArray[k].partname).attr('fill', 'url(#img_brocade_' + finalBrocadesArray[k].brocadeId + '_' + finalBrocadesArray[k].partname + ')');
                            }
                        });
                    }
                };

                setTimeout(function() {
                    updateUndoredo();
                }, 1000);
            }




        }



        function converting(item, brocadeId, callback) {
            var img = new Image();
            img.onload = function() {
                $('.svg_base64loading').show();
                $('.pattern_div').prop("disabled", true);
                $('.pattern_div').css({
                    'opacity': '0.5'
                });
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
            hiding_Unused_embellishment_Groups(savingObject);


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
                        $('.group').show();
                        hiding_Unused_embellishment_Groups(savingObject)
                        $(".savingJsonLoader").css('display', 'none');
                        alert("Design Saved Successfully!");
                        $(".save").removeAttr('disabled');
                        $('.prev-carousel ul').html('');

                        loadSavedDresses(data);


                    }
                })
            };
        });

        function hiding_Unused_embellishment_Groups(savingObject) {
            for (var i = 0; i < savingObject.length; i++) {
                if ((savingObject[i].partClass.indexOf('emb') > -1) && (savingObject[i].patternUrl == '#FFFFFF')) {
                    var gettingpartclass = savingObject[i].partClass;
                    gettingpartclass = gettingpartclass.replace('emb_', '');
                    gettingpartclass = gettingpartclass + '_group';
                    $('.' + gettingpartclass).hide();

                }
            };
        }

        $(document).on('click', '.overview li', function() {
            var emb_groups_enabled = [];
            $('.savedImgClass').remove();
            var retrievedImageDetails = $(this).attr('data-details');
            var savedJson = $.parseJSON(retrievedImageDetails);
            var applyPatterns = [];
            var temp = '';

            for (var i = 0; i < savedJson.length; i++) {
                //here we have to create pattern based on the saved images clicked clicked 
                temp += "<svg class='savedImgClass'><pattern id='savedimgPattern" + i + "' patternUnits='objectBoundingBox' viewBox='0 0 1 1' width='100%' height='100%' preserveAspectRatio='xMidYMid slice'><image xlink:href=" + savedJson[i].patternUrl + " width='1' height='1' /></pattern></svg>";
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
            $('.main_parts,.group').find('path').each(function(index) {
                var thisClass = $(this).attr('class');
                $.each(applyPatterns, function(index1, val) {
                    if (thisClass == val.classNames) {

                        if (val.patternUrl.length > 10) {
                            $('.' + val.classNames).attr('fill', 'url(#' + val.patternUrl + ')');
                        } else {
                            $('.' + val.classNames).attr('fill', '#FFFFFF');
                        }
                    }
                });

            });

            $('.group').show();
            hiding_Unused_embellishment_Groups(savedJson);
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