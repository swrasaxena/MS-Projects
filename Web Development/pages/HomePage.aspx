<%@ Page Language="C#" MasterPageFile="~/project/pages/MasterPage.master" %>

<asp:Content ID="ContentHead" ContentPlaceHolderID="head" runat="server">  
    <link rel='stylesheet' id='camera-css'  href='../css/camera.css' type='text/css' media='all'/>
    <link href="../css/home.css" rel="stylesheet" type="text/css" />
    <script type='text/javascript' src='../javascript/jquery.min.js'></script>
    <script type='text/javascript' src='../javascript/jquery.mobile.customized.min.js'></script>
    <script type='text/javascript' src='../javascript/jquery.easing.1.3.js'></script> 
    <script type='text/javascript' src='../javascript/camera.min.js'></script> 
    
    <script>
        jQuery(function () {

            jQuery('#camera_wrap_1').camera({
                thumbnails: false,
                playPause: false,
                transPeriod: 1000,
                time: 2000,
                hover: false,
                height: '450px',
                portrait: true,
                loader: false
            });


        });
	</script>
</asp:Content>

<asp:Content ID="ContentBody" ContentPlaceHolderID="body" runat="server">
       <div class="container-fluid col-xs-12">
            <div class="camera_wrap camera_azure_skin" id="camera_wrap_1">
                    <div data-src="../images/1.png">
                
                    </div>
                    <div data-src="../images/2.jpg">
                
                    </div>
                    <div data-src="../images/3.jpg">
                
                    </div>
                    <div data-src="../images/4.jpg">
                
                    </div>
                    <div data-src="../images/5.jpg">
                
                    </div>
                    <div data-src="../images/6.jpg">
                
                    </div>
                    <div data-src="../images/7.jpg">

                    </div>
           </div>
           <div>
               <h3>To play NFL Theme Song, click on Play button below!</h3>
           </div>
           <br />
           <br />
           <audio class="img-responsive center-block" controls="controls">
                <source src="../fox_nfl_theme.mp3" type="audio/mpeg"/>
                <embed hidden="hidden" height="50" width="100" src="../fox_nfl_theme.mp3"/>
           </audio>
           <br />
           <br />
        </div>
</asp:Content>