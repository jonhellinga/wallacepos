<!-- WallacePOS: Copyright (c) 2014 WallaceIT <micwallace@gmx.com> <https://www.gnu.org/licenses/lgpl.html> -->
<div class="page-header">
    <h1>
        Utilities
        <small>
            <i class="icon-double-angle-right"></i>
            Manage Application Data
        </small>
    </h1>
</div><!-- /.page-header -->
<div class="row">
    <div class="col-sm-5">
        <div class="widget-box transparent">
            <div class="widget-header widget-header-flat">
                <h4 class="lighter">
                    <i class="icon-bullhorn blue"></i>
                    Feed Server
                </h4>
            </div>

            <div class="widget-body">
                <div class="widget-main no-padding" style="text-align: center;">
                        <div style="padding: 10px;">
                            <h3 style="display: inline-block">Status:</h3>&nbsp;&nbsp;
                            <i id="nodestaticon" class="icon-lightbulb icon-2x"></i>
                            <h4 style="display: inline-block" id="nodestattxt">Loading...</h4>
                        </div>
                        <button id="nodebootbtn" style="display: none;" class="btn btn-success" onclick="startNode();">Start</button>&nbsp;
                        <button class="btn btn-warning hidden" onclick="restartNode();">Restart</button>
                </div>
            </div>
        </div>
    </div>
    <div class="col-sm-7">
        <div class="widget-box transparent">
            <div class="widget-header widget-header-flat">
                <h4 class="lighter">
                    <i class="icon-briefcase blue"></i>
                    Database
                </h4>
            </div>

            <div class="widget-body" style="height: 200px;">
                <h3 style="display: inline-block;">Backup Database:</h3>
                <button class="btn btn-primary" onclick="exportDB();">Backup</button>
                <iframe id="dlframe" style="display: none; width: 0; height: 0;" src=""></iframe>
            </div>
        </div>
    </div>

    <div class="col-sm-5">
            <div class="widget-box transparent">
                <div class="widget-header widget-header-flat">
                    <h4 class="lighter">
                        <i class="icon-edit blue"></i>
                        Logs
                    </h4>
                </div>

                <div class="widget-body">
                    <div class="widget-main no-padding" style="text-align: center;">
                        <select id="loglist" size="10" style="width: 300px;">
                            <option>Loading...</option>
                        </select>
                    </div>
                </div>
            </div>
    </div>
</div>
<div id="logdialog" style="display:none; padding:10px; background-color: white;" title="Log Contents">
    <div id="logcontents" style="font-family: monospace; white-space: pre;"></div>
</div>
<script type="text/javascript">
    function restartNode(){
        var answer = confirm("Are you sure you want to restart the feed server?");
        if (answer){
            // show loader
            WPOS.util.showLoader();
            var stat = WPOS.getJsonData("node/restart");
            if (stat==true){
                setUIStatus(true);
                alert("Feed server successfully restarted!");
            } else {
                setUIStatus(false);
            }
            // hide loader
            WPOS.util.hideLoader();
        }
    }
    function stopNode(){
        var answer = confirm("Are you sure you want to stop the feed server?");
        if (answer){
            // show loader
            WPOS.util.showLoader();
            if (WPOS.getJsonData("node/stop")!==false){
                setUIStatus(false);
            } else {
                setUIStatus(true);
            }
            // hide loader
            WPOS.util.hideLoader();
        }
    }
    function startNode(){
        // show loader
        WPOS.util.showLoader();
        if (WPOS.getJsonData("node/start")!==false){
            setUIStatus(true);
        } else {
            setUIStatus(false);
        }
        // hide loader
        WPOS.util.hideLoader();
    }
    function getNodeStatus(){
        if (WPOS.getJsonData("node/status")!==false){
            setUIStatus(true);
        } else {
            setUIStatus(false);
        }
    }
    function setUIStatus(online){
        var nodebtn = $("#nodebootbtn");
        var nodestattxt = $("#nodestattxt");
        var nodestaticon = $("#nodestaticon");
        if (online){
            // set button
            nodebtn.text("Stop");
            nodebtn.removeClass("btn-success");
            nodebtn.addClass("btn-danger");
            nodebtn.attr("onclick", "stopNode();");
            nodebtn.hide(); // hide for production we don't ever want to stop it
            // set status
            nodestattxt.text("Online");
            nodestaticon.removeClass("red");
            nodestaticon.addClass("green");
        } else {
            nodebtn.text("Start");
            nodebtn.removeClass("btn-danger");
            nodebtn.addClass("btn-success");
            nodebtn.attr("onclick", "startNode();");
            nodebtn.show();

            nodestattxt.text("Offline");
            nodestaticon.removeClass("green");
            nodestaticon.addClass("red");
        }
    }

    function populateLogs(){
        var logs = WPOS.getJsonData("logs/list");
        if (logs!==false){
            $("#loglist").html('');
            for (var i in logs){
                $("#loglist").append('<option onclick="viewLog($(this).val())" value="'+logs[i]+'">'+logs[i].split('.')[0]+'</option>');
            }
        }
    }

    function viewLog(filename){
        var log = WPOS.sendJsonData("logs/read", JSON.stringify({filename: filename}));
        if (log!=false){
            log = log.replace(/\n/g, "<br/>");
            $("#logcontents").html(log);
            $("#logdialog").dialog('open');
        }
    }

    function exportDB(){
        $("#dlframe").attr('src', 'https://'+document.location.host+'/api/wpos.php?a=db%2Fbackup');
    }

    $(function(){
        $("#logdialog").dialog({
            height       : 420,
            width        : 'auto',
            maxWidth: 650,
            modal        : true,
            closeOnEscape: false,
            autoOpen     : false,
            open         : function (event, ui) {
            },
            close        : function (event, ui) {
            },
            create: function( event, ui ) {
                // Set maxWidth
                $(this).css("maxWidth", "650px");
            }
        });

        getNodeStatus();
        populateLogs();
        // hide loader
        WPOS.util.hideLoader();
    });

</script>