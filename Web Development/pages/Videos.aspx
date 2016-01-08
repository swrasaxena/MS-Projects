<%@ Page Language="C#" MasterPageFile="~/project/pages/MasterPage.master" %>

<script runat="server">

</script>

<asp:Content ID="ContentHead" ContentPlaceHolderID="head" runat="server"> 
    <link rel="stylesheet" href="../css/videos1.css" type="text/css" />
    <script src="//code.jquery.com/jquery-1.9.1.js"></script>
    <script src="//code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
    <script src="../javascript/videosNow.js"></script>
    
</asp:Content>

<asp:Content ID="ContentBody" ContentPlaceHolderID="body" runat="server">
    <div class="container col-xs-12">
        <div class="col-xs-3"></div>
        <div class="panel panel-info col-xs-6">
            <div class="panel-heading">
                <h3 class="panel-title">ESPN Now Videos</h3>
            </div>
            <div class="panel-body">
            </div>
        </div>
        <div class="col-xs-3"></div>
        <div class="video-modals">
        </div>
    </div>
    
    
</asp:Content>