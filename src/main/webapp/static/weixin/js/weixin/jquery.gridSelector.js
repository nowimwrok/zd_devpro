(function ($) {

    $.fn.gridSelector = function (options) {
        var settings = {
            id: "",
            data: [],
            idKey:"id",
            textKey:"text",
            colNum: 3,
            multiSelect: true,
            cellWidth: 120,
            cellHeight: 36,
            position: "lb", //"lb" "lt" "rb" "rt"
            icon: "static/images/ok.png",//选中项的图片标示，要求大小为24*24,否则会错位
            complete: function (data) {   ////回调数据
            }
        };

        $.extend(settings, options);

        if (!settings.id) {
            settings.id = ++ $.fn.gridSelector.unique
        }

        var $this = $(this);
        return new gridsel($this, settings);
    };

    $.fn.gridSelector.unique = 1000;

    function gridsel($this, settings) {

        appendCommonStyle(settings);
        var $element = initElement($this, settings);
        var $element_td = $element.find("td");

        var $top = $(window.top);

        $this.click(function () {
            initStyle($element, $this, settings);
            $(".gridsel").each(function () {
                if ($(this).attr("id") != $element.attr("id")) {
                    $(this).hide();
                }
            });

            $element.show();
            $top.mousedown(topdown);
            $("body").mousedown(topdown);
        });

       
        /// 华丽的分割线
        $element_td.mouseover(function () {
            if ($(this).attr("id") == "gridsel-close") {
                return;
            }
            $(this).addClass("gridsel-over");
        });

        $element_td.mouseout(function () {
            if ($(this).attr("id") == "gridsel-close") {
                return;
            }
            if (!$(this).data("seled")) {
                $(this).removeClass("gridsel-over");
            }
        });

        $element_td.click(function () {
            // 点击关闭按钮，只有在多选的时候才会出现的
            if ($(this).attr("id") == "gridsel-close") {
                close();
                return;
            }

            // 如果单选的话
            if (!settings.multiSelect) {
                $element_td.each(function () {
                    $(this).data("seled", false);
                })
                $(this).data("seled", true);
                updataStyle($element, settings);

                close();
            } else {// 如果是多选的话
                $(this).data("seled", !$(this).data("seled"));
                updataStyle($element, settings);
            }
        });

        function topdown(e) {
            var left = $element.offset().left;
            var top = $element.offset().top;
            var width = $element.width();
            var height = $element.height();
            var right = left + width;
            var bottom = top + height;
            if (e.pageX > left && e.pageX < right && e.pageY > top && e.pageY < bottom) {
                return;
            }
            close(true);
        }

        function close(flag) {
            $element.hide();
            $top.unbind("mousedown", topdown);
            $("body").unbind("mousedown", topdown);
            if(flag){
            	return;
            }
            
            var ids = [];
            var cnt = 0;
            var datas = [];
            $element_td.each(function () {
                if ($(this).data("seled")) {
                    ids[cnt++] = $(this).attr("id");
                }
            });
            for (var i = 0; i < settings.data.length; i++) {
                for (var j = 0; j < ids.length; j++) {
                    for (var key in settings.data[i]) {
                        if (key == settings.idKey) {
                            if (settings.data[i][key] == ids[j]) {
                                datas[j] = settings.data[i];
                                break;
                            }
                        }
                    }
                }
            }
            if(settings.multiSelect){
            	settings.complete(datas);
            }else{
            	settings.complete(datas[0]);
            }
        }       
    }

    function updataStyle($element, opts) {
        $element.find(".gridsel-seled").remove();
        $element.find("td").removeClass("gridsel-over");
        $element.find("td").each(function () {
            if ($(this).attr("id") == "gridsel-close") {
                return;
            }
            if ($(this).data("seled")) {// 已经选择的样式
                $(this).append("<span id='span" + $(this).attr("id") + "' class='gridsel-seled'></span>");
                var left = $(this).offset().left - $element.offset().left;
                var top = $(this).offset().top - $element.offset().top;
                var wid = opts.cellWidth - 24;
                var hei = ($(this).height() - 24) / 2;
                top = top + hei;
                left = left + wid;
                $element.find("#span" + $(this).attr("id")).css("left", left + "px");
                $element.find("#span" + $(this).attr("id")).css("top", top + "px");
                $(this).addClass("gridsel-over");
            }
        });
    }

    function appendCommonStyle(opts) {
        if ($("#gridsel-style").length <= 0) {
            var bg = "background:url('"+ opts.icon +"') no-repeat";
            var style = "<style id='gridsel-style' type='text/css'>";
            style += ".gridsel {position: absolute;background:#fff;border: solid 1px #00a2e9;z-index:9999;margin-top:3px;}";
            style += ".gridsel td {text-align: center;border-right: dashed 1px #ccc;border-bottom: dashed 1px #ccc;cursor: pointer;color: #00a2e9;}";
            style += ".gridsel-seled {position:absolute;left:30px;top:10px;display:block;width:24px;height:24px;" + bg + "}";
            style += ".gridsel-over {background:#ddd;}";
            style += "</style>";
            $("head").append(style);
        }
    }

    function initStyle($element, $this, opts) {
        var rowNum = Math.ceil(opts.data.length / opts.colNum);
        var colNum = opts.colNum;
        if (opts.multiSelect) {
            rowNum = Math.ceil((opts.data.length + 1) / opts.colNum);
        }
        if (colNum > opts.data.length) {
            colNum = opts.data.length;
            if (opts.multiSelect) {
                colNum = opts.data.length + 1;
            }
        }
        var width = opts.colNum + 1 + opts.colNum * opts.cellWidth;
        var height = rowNum + 1 + rowNum * opts.cellHeight;
        var left = $this.offset().left;
        var top = $this.offset().top;

        $element.css("width", width);
        $element.css("height", height);
        if (opts.position[0]=='r' || left + width > $(document).width()) {
            var right = $(document).width() - (left + $this.outerWidth());
            //$element.css("right", right + "px");
        } else {
            $element.css("left", left + "px");
        }
        if (opts.position[0]=='b' || top + $this.outerHeight() + height > $(document).height()) {
            var bottom = $(document).height() - top;
            $element.css("bottom", bottom + "px");
        } else {
            top = top + $this.outerHeight();
            $element.css("top", top + "px");
        }
    }

    function initElement($this, opts) {
        $("body").append("<table id='gridsel" + opts.id + "' cellspacing='0' cellpdding='0' class='gridsel' style='display:none;'></table>")
        var $element = $("#gridsel" + opts.id);

        var html = "";
        var rowNum = Math.ceil(opts.data.length / opts.colNum);
        var colNum = opts.colNum;
        if (opts.multiSelect) {
            rowNum = Math.ceil((opts.data.length + 1) / opts.colNum);
        }
        if (colNum > opts.data.length) {
            colNum = opts.data.length;
            if (opts.multiSelect) {
                colNum = opts.data.length + 1;
            }
        }

        $element.children().remove();
        var rn = "style='width:"+ opts.cellWidth +"px;height:"+ opts.cellHeight +"px;border-right:none;'";
        var bn = "style='width:"+ opts.cellWidth +"px;height:"+ opts.cellHeight +"px;border-bottom:none;'";
        var rbn = "style='width:"+ opts.cellWidth +"px;height:"+ opts.cellHeight +"px;border-right:none;border-bottom:none;'";
        var c = "style='width:"+ opts.cellWidth +"px;height:"+ opts.cellHeight +"px;color:#fff;background:#f74000;border-bottom:none;border-right:none;'";
        var crn = "style='width:"+ opts.cellWidth +"px;height:"+ opts.cellHeight +"px;color:#fff;background:#f74000;border-bottom:none;'";
        for (var i = 0; i < rowNum; i++) {
            html += "<tr>";
            for (var j = 0; j < colNum; j++) {
                var index = i * colNum + j;
                if (index < opts.data.length) {
                    if (j != colNum - 1 && i == rowNum - 1) {
                        html += "<td id = '" + opts.data[index][opts.idKey] + "' "+ bn +"><span>" + opts.data[index][opts.textKey] + "</span></td>";
                    } else if (j == colNum - 1 && i != rowNum - 1) {
                        html += "<td id = '" + opts.data[index][opts.idKey] + "' "+ rn +"><span>" + opts.data[index][opts.textKey] + "</span></td>";
                    } else if (j == colNum - 1 && i == rowNum - 1) {
                        html += "<td id = '" + opts.data[index][opts.idKey] + "' "+ rbn +"><span>" + opts.data[index][opts.textKey] + "</span></td>";
                    } else {
                        html += "<td id = '" + opts.data[index][opts.idKey] + "'><span>" + opts.data[index][opts.textKey] + "</span></td>";
                    }
                } else if (opts.multiSelect && index == opts.data.length) {
                    if (index == colNum * rowNum - 1) {
                        html += "<td id = 'gridsel-close' "+ c +">确定</td>";
                    } else {
                        html += "<td id = 'gridsel-close' "+ crn +">确定</td>";
                    }
                }
            }
            html += "</tr>";
        }
        $element.append(html);
        return $element;
    }


})(jQuery);