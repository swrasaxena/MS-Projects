<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">

</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
         <div class="sidebar">
            <h3>Top Headlines</h3>
            <asp:XmlDataSource ID="XmlDataSource1" runat="server" DataFile="http://rssfeeds.usatoday.com/UsatodaycomNfl-TopStories" XPath="rss/channel/item[position()]"></asp:XmlDataSource>
            <asp:ListView ID="ListView1" runat="server" DataSourceID="XmlDataSource1">
                <ItemTemplate>
                    <b class="title">
                        <%# XPath("title") %>
                    </b>
                    <br />
                    <%# XPath("description") %>
                    <br />
                    <asp:HyperLink CssClass="link" ID="HyperLink1" 
                        NavigateUrl='<%# XPath("link") %>' 
                        runat="server"
                        Text="Read more >>" Target="_blank">
                    </asp:HyperLink>
                    <br />
                    <br />
                </ItemTemplate>
            </asp:ListView>
        </div>
        <div class="main">
            <b>
                Welcome to my site - Football Mania! Here, you can search for teams or players for National Football League Season 2013-2014.
                Catch the latest news on upcoming NFL Season 2014-2015 with our top headlines.
                You can also login to add any football merchandise that you may wish to in your wishlist.
                <br />
                <br />
                Don't forget to also provide your valuable feedback on "Football Mania".
            </b>
        </div>
    
    </div>
    </form>
</body>
</html>
