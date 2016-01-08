<%@ Page Language="C#" MasterPageFile="~/project/pages/MasterPage.master"%>
<%@ Import Namespace="System.Data.SqlClient" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        Session.Clear();
    }

    protected void Login1_Authenticate(object sender, AuthenticateEventArgs e)
    {
        string username = Login2.UserName;
        string password = Login2.Password;
        SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["swra0110ConnectionString"].ConnectionString);
        connection.Open();
        string sqlPassword, sqlId;
        sqlId = "SELECT Id FROM Login WHERE username ='" + username + "'";
        sqlPassword = "SELECT password FROM Login WHERE username ='" + username + "'";
        SqlCommand cmd = new SqlCommand(sqlPassword, connection);
        SqlCommand cmd1 = new SqlCommand(sqlId, connection);
        string pwd;
        int id;
        id = (int)cmd1.ExecuteScalar();
        pwd = (string)cmd.ExecuteScalar();
        if (pwd != null)
        {
            if (pwd.Equals(password))
            {
                e.Authenticated = true;
                Session.Clear();
                Session["UserName"] = username;
                Session["UserId"] = id;
            }
            else
            {
                e.Authenticated = false;
                Session.Clear();
            }
        }
        else
        {
            e.Authenticated = false;
            Session.Clear();
        }

    }
</script>


<asp:Content ID="ContentHead" ContentPlaceHolderID="head" runat="server">
    <link href="project/css/login.css" rel="stylesheet" type="text/css" />
</asp:Content>

<asp:Content ID="ContentBody" ContentPlaceHolderID="body" runat="server">
    <div class="container">
        <div class="main-content">
                <div class="content">
                    <h2>LOGIN</h2>
                    <asp:Login ID="Login2" runat="server" CssClass="login-content" OnAuthenticate="Login1_Authenticate" DestinationPageUrl="~/project/pages/AddCart.aspx"></asp:Login>
                </div>
        </div>
        <div id="push"></div>
    </div>
    
</asp:Content>

