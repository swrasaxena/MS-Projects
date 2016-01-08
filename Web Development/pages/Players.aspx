<%@ Page Language="C#" MasterPageFile="~/project/pages/MasterPage.master" %>

<script runat="server">

</script>

<asp:Content ID="ContentHead" ContentPlaceHolderID="head" runat="server">  
    <link rel="stylesheet" href="../css/players.css" type="text/css" />
    <script src="//code.jquery.com/jquery-1.9.1.js"></script>
    <script src="../javascript/searchPlayer.js" type="text/javascript"></script>
</asp:Content>

<asp:Content ID="ContentBody" ContentPlaceHolderID="body" runat="server">
    <div class="main-content">
        <div class="content">
            <h3>Search for player(s) with last name starting with A</h3>
            <input class="textbox" id="txtPlayer" type="text" placeholder="Enter the last name of the player" size="30" autocomplete="on"/>
            <button type="button">Search Player(s)</button>
            <br />
            <br />
            <br />
            <div class="display-result">

            </div>
        </div>
    </div>
</asp:Content>