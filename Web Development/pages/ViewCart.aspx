<%@ Page Language="C#" MasterPageFile="~/project/pages/MasterPage.master" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<script runat="server">
    protected int id;
    protected void Page_Load(object sender, EventArgs e)
    {
        if ((Session["UserName"]) == null)
        {
            LinkButton1.Text = "Login";
            GridView2.Visible = false;
            btn_Delete.Visible = false;
            lblText.Visible = false;
            lblWarning.Visible = false;
            lblSum.Visible = false;
            lblMessage.Visible = false;
        }
        else
        {
            LinkButton1.Text = "Logout";
        }
        if(!IsPostBack)
        {
            ShowPrice();
        }
        
        btn_Delete.Attributes.Add("onclick", "javascript: return deleteConfirm()");
        
    }
    
    public void ShowPrice()
    {
        SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["swra0110ConnectionString1"].ConnectionString);
        if ((Session["UserId"]) == null)
        {
            id = 0;
        }
        else
        {
            id = (int)(Session["UserId"]);
        }
        string sqlPrice, sqlQuantity;
        Label lblTotal;
        int ItemID, price, quantity, total, sum=0;
        
        foreach (GridViewRow grdRow in GridView2.Rows)
        {
            bool result = int.TryParse(GridView2.Rows[grdRow.RowIndex].Cells[1].Text, out ItemID);
            if (result)
            {
                ItemID = int.Parse(GridView2.Rows[grdRow.RowIndex].Cells[1].Text);
            }
            lblTotal = (Label)(GridView2.Rows[grdRow.RowIndex].Cells[4].FindControl("lblTotalPrice"));
            sqlPrice = "Select Price from ShoppingItem where ItemId = " + ItemID;
            sqlQuantity = "Select Quantity from Cart where ItemId = " + ItemID + " and UserId = " + id;
            SqlCommand cmd, cmd1;
            connection.Open();
            cmd = new SqlCommand(sqlPrice, connection);
            cmd1 = new SqlCommand(sqlQuantity, connection);
            price = (int)cmd.ExecuteScalar();
            if(id != 0)
            {
                quantity = (int)cmd1.ExecuteScalar();
                total = price * quantity;
                lblTotal.Text = "$" + total.ToString();
                sum = sum + total;
                lblSum.Text = "Total Price: $" + sum.ToString();
            }
            
            connection.Close();
        }
    }

    protected void btn_Delete_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow grdRow in GridView2.Rows)
        {
            CheckBox chkdelete = (CheckBox)grdRow.FindControl("chkDelete");
            bool flag = false;
            if (chkdelete.Checked)
            {
                int ItemID = int.Parse(GridView2.Rows[grdRow.RowIndex].Cells[1].Text);
                flag = DeleteRecordByID(ItemID);
            }
            if (flag)
            {
                lblMessage.Attributes["style"] = "color: green; font-weight: bold;";
                lblMessage.Text = "Row deleted.";
            }
            else
            {
                lblMessage.Attributes["style"] = "color: red; font-weight: bold;";
                lblMessage.Text = "No row deleted.";
            }
        }
        GridView2.DataBind();
        ShowPrice();
    }
    
    public bool DeleteRecordByID(int ItemID)
    {
        if ((Session["UserId"]) == null)
        {
            id = 0;
        }
        else
        {
            id = (int)(Session["UserId"]);
        }
        SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["swra0110ConnectionString1"].ConnectionString);
        string sqlDelete = "Delete from Cart where UserId = " + id + " and ItemId = " + ItemID;
        SqlCommand cmd = new SqlCommand(sqlDelete, connection);
        connection.Open();
        if (id != 0)
        {
            cmd.ExecuteNonQuery();
        }
        connection.Close();
        return true;
    }

    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        Response.Redirect(Page.ResolveUrl("~/Login.aspx"));

    }

   
</script>

<asp:Content ID="ContentHead" ContentPlaceHolderID="head" runat="server">
    <link href="../css/addcart.css" rel="stylesheet" type="text/css" />
    <link href="../css/viewcart.css" rel="stylesheet" type="text/css" />
    <script src="//code.jquery.com/jquery-1.9.1.js"></script>
    <script src="../javascript/viewcart.js"></script>
</asp:Content>
<asp:Content ID="ContentBody" ContentPlaceHolderID="body" runat="server">
    <div class="container">
         <div class="well well-sm">
             <h3>Online Shopping - Accessories</h3>
             <%string uname = (string)(Session["UserName"]);  %>
             <h4>
                 <asp:LinkButton CssClass="btn btn-success" ID="LinkButton1" runat="server" OnClick="LinkButton1_Click"></asp:LinkButton>
             </h4>
             <h3 class="text">Welcome, <%= uname %></h3>
             <br />
             <div class="cart img-responsive">
                <asp:GridView CssClass="table text-center" ID="GridView2" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EmptyDataText="There are no data records to display." BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3">
                    <Columns>
                        <asp:TemplateField HeaderText="Delete">
                            <ItemTemplate>
                                <asp:CheckBox ID="chkDelete" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="ItemId" HeaderText="ItemId" SortExpression="ItemId" />
                        <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                        <asp:BoundField DataField="Quantity" HeaderText="Quantity" SortExpression="Quantity" />

                        <asp:TemplateField HeaderText="Total Price">
                            <ItemTemplate>
                                <asp:Label ID="lblTotalPrice" runat="server" Text=""></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                    
                    </Columns>
                    <FooterStyle BackColor="White" ForeColor="#000066" />
                    <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                    <RowStyle ForeColor="#000066" />
                    <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                    <SortedAscendingHeaderStyle BackColor="#007DBB" />
                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                    <SortedDescendingHeaderStyle BackColor="#00547E" />
                </asp:GridView>
                <br />
                <div class="align">
                    <asp:Label CssClass="label label-info" ID="lblSum" runat="server" Text=""></asp:Label>
                    <br />
                    <br />
                    <asp:Button CssClass="btn btn-primary" ID="btn_Delete" runat="server" Text="Delete from Cart" OnClick="btn_Delete_Click" />
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <a href="AddCart.aspx" class="link"><< Click here to go back and edit the cart</a>
                    <br />
                    <br />
                    <asp:Label ID="lblMessage" runat="server" Text=""></asp:Label>
                </div>
                
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:swra0110ConnectionString1 %>" 
                    SelectCommand="SELECT c.[ItemId], s.Name, c.[Quantity] FROM [Cart] c, ShoppingItem s WHERE ([UserId] = @UserId) and c.ItemId = s.ItemId" >
                    <SelectParameters>
                        <asp:SessionParameter Name="UserId" SessionField="UserId" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </div>
            <br />
             <asp:Label CssClass="label-default" ID="lblText" runat="server" Text="If you are satisfied with your order, please proceed to checkout and pay with Paypal by clicking the button below."></asp:Label>
            <br />
            <br />
            <asp:Label CssClass="warning" ID="lblWarning" runat="server" Text="NOTE: This is to let you know that Paypal would ask for credentials to login and make payment to my account. Pay at your own risk!"></asp:Label>
            <br />
            <br />
        </div> 
   </div>
   </asp:Content>