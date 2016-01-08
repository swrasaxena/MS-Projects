<%@ Page Language="C#" MasterPageFile="~/project/pages/MasterPage.master" %>

<asp:Content ID="ContentHead" ContentPlaceHolderID="head" runat="server">  
    <link href="../css/teams.css" rel="stylesheet" type="text/css" />
    <script src="//code.jquery.com/jquery-1.9.1.js"></script>
    <script src="../javascript/teamDisplay.js"></script>
</asp:Content>

<asp:Content ID="ContentBody" ContentPlaceHolderID="body" runat="server">
    <img src="http://jetpartners.aero/wp-content/uploads/2014/01/800x300xSuper-Bowl.jpg.pagespeed.ic.ZFSs5ai0Ea.jpg" class="img-responsive img-rounded" />
    <div class="container col-xs-12">
        <div class="col-xs-3"></div>
        <div class="col-xs-6">
            <h3 class="leaguename"></h3>
            <table class="table table-bordered table-condensed table-responsive">
                <thead>
                    <tr>
                        <th>Team ID</th>
                        <th>Team Name</th>
                        <th>Location</th>
                        <th>External Link</th>
                    </tr>
                </thead>
                <tbody class="data"></tbody>
            </table>
        </div>
        <div class="col-xs-3"></div>
    </div>
</asp:Content>