<%@ Page Language="C#" MasterPageFile="~/project/pages/MasterPage.master" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<script runat="server">
    
    protected void submit_Click(object sender, EventArgs e)
    {
        SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["swra0110ConnectionString"].ConnectionString);
        string user = txtName.Text;
        string comments = txtComments.Text;
        string q1 = "Insert into Feedback values ('" + user + "','" + comments + "')";
        connection.Open();
        SqlCommand cmd = new SqlCommand(q1, connection);
        if( user!= null && user!="" && comments!=null && comments!="")
        {
            cmd.ExecuteNonQuery();
        }
        else
        {
            lblWarning.Text = "Please provide your name and valuable feedback.";
        }
        
        connection.Close();
        lstFeedback.DataBind();
        txtComments.Text = "";
        txtName.Text = "";
            
    }


</script>

<asp:Content ID="ContentHead" ContentPlaceHolderID="head" runat="server"> 
</asp:Content>

<asp:Content ID="ContentBody" ContentPlaceHolderID="body" runat="server">
    <div class="container col-xs-12">
        <div class="col-xs-2"></div>
        <div class="col-xs-4"><img src="https://usu.edu/career/images/uploads/feedback.jpg" class="img-responsive" /></div>
        <div class="form-group well well-sm col-xs-3">
            <asp:Label ID="Label2" runat="server" Text="*" ForeColor="Red"></asp:Label>
            <asp:Label ID="lblName" runat="server" Text="Your Name:"></asp:Label>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="txtName" runat="server" CssClass="img-responsive"></asp:TextBox>
            <br />
            <br />
            <asp:Label ID="Label1" runat="server" Text="*" ForeColor="Red"></asp:Label>
            <asp:Label ID="lblComments" runat="server" Text="Your Feedback:" CssClass="lblComment"></asp:Label>
            <asp:TextBox ID="txtComments" runat="server" Height="150px" Width="250px" TextMode="MultiLine" CssClass="img-responsive"></asp:TextBox>
            <br />
            <br />
            <asp:Button ID="submit" runat="server" Text="Submit" OnClick="submit_Click" CssClass="btn btn-primary center-block" />
            <br />
            <asp:Label ID="lblWarning" CssClass="alert-warning" runat="server" Text=""></asp:Label>
        </div>
        <div class="col-xs-3"></div>
    </div>
    <br />
    <br />
    <div class="container">
        <div class="col-xs-5"></div>
        <div class="well well-sm col-xs-2">
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:swra0110ConnectionString %>" 
            SelectCommand="SELECT [Id], [User], [Comment] FROM [Feedback]">
            </asp:SqlDataSource>
            <asp:DataList CssClass="form-control-feedback" ID="lstFeedback" runat="server" CellPadding="3" DataKeyField="Id" DataSourceID="SqlDataSource1" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" GridLines="None">
                <AlternatingItemStyle BackColor="#DCDCDC" />
                <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
                <ItemStyle BackColor="#EEEEEE" ForeColor="Black" />
                <ItemTemplate>
                    Given By:
                    <asp:Label ID="UserLabel" runat="server" Text='<%# Eval("User") %>' />
                    <br />
                    Feedback:
                    <asp:Label ID="CommentLabel" runat="server" Text='<%# Eval("Comment") %>' />
                    <br />
                    <br />
                </ItemTemplate>
                <SelectedItemStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
            </asp:DataList>
        </div>
        <div class="col-xs-5"></div>
    </div>
</asp:Content>