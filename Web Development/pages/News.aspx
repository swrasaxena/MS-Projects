<%@ Page Language="C#" MasterPageFile="~/project/pages/MasterPage.master"%>

<script runat="server">
</script>


<asp:Content ID="ContentHead" ContentPlaceHolderID="head" runat="server"> 
    <link rel="stylesheet" href="//code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css"/>
    <link rel="stylesheet" type="text/css" href="../css/news.css" />
    <script src="//code.jquery.com/jquery-1.9.1.js"></script>
    <script src="//code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
    <script src="../javascript/teamNews.js"></script>
    <script src="../javascript/news.js"></script>
    <script type="text/javascript" src="https://www.google.com/jsapi"></script>
    <script>
        google.load("feeds", "1");
        google.setOnLoadCallback(initialize);
    </script>
    
</asp:Content>

<asp:Content ID="ContentBody" ContentPlaceHolderID="body" runat="server">
    <div class="container col-xs-12">
        <ul id="myTab" class="nav nav-tabs" style="margin-bottom: 15px;">
            <li class="active"><a href="#general" data-toggle="tab">General News</a></li>
            <li class=""><a href="#team" data-toggle="tab">NFL Season 2013 Top 2 Team's News</a></li>
        </ul>
        <div id="myTabContent" class="tab-content">
            <div class="tab-pane fade active in" id="general">
                <div id="accordion">
               
                </div>
            </div>
            <div class="tab-pane fade" id="team">
                <div class="container col-xs-12">
                    <div class="col-xs-2"></div>
                    <div class="panel col-xs-3 panel-info">
                      <div class="panel-heading">
                        <h3 class="panel-title">Seattle Seahawks</h3>
                      </div>
                      <div class="panel-body text">
                          <div id="feed"></div>
                      </div>
                    </div>
                    <div class="col-xs-2"></div>
                    <div class="panel col-xs-3 panel-info">
                      <div class="panel-heading">
                        <h3 class="panel-title">Denver Broncos</h3>
                      </div>
                      <div class="panel-body text">
                          <asp:XmlDataSource ID="XmlDataSource1" runat="server" DataFile="http://www.denverbroncos.com/cda-web/rss-module.htm?tagName=News" XPath="rss/channel/item[position()]"></asp:XmlDataSource>
                          <asp:ListView ID="ListView1" runat="server" DataSourceID="XmlDataSource1">
                            <ItemTemplate>
                                <asp:HyperLink CssClass="news" ID="HyperLink1" 
                                    NavigateUrl='<%# XPath("link") %>' 
                                    runat="server"
                                    Text='<%# XPath("title") %>' Target="_blank">
                                </asp:HyperLink>
                                <br />
                                <br />
                            </ItemTemplate>
                          </asp:ListView>
                      </div>
                    </div>
                    <div class="col-xs-2"></div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
