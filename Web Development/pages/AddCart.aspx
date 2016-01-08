<%@ Page Language="C#" MasterPageFile="~/project/pages/MasterPage.master" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if ((Session["UserName"]) == null)
        {
            LinkButton1.Text = "Login";
            GridView1.Visible = false;
            btnAddItems.Visible = false;
            btnViewCart.Visible = false;
            lblSuccess.Visible = false;
        }
        else
        {
            LinkButton1.Text = "Logout";
        }
    }

    protected void btnAddItems_Click(object sender, EventArgs e)
    {
        SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["swra0110ConnectionString1"].ConnectionString);
        int id;
        bool flag = false;
        if ((Session["UserId"]) == null)
        {
            id = 0;
        }
        else 
        {
            id = (int)(Session["UserId"]);
        }
        string sqlItemID, query, sqlCartID, query1;
        TextBox txtquant = null;
        int quantity, ItemID;
        foreach (GridViewRow grdRow in GridView1.Rows)
        {
            ItemID = int.Parse(GridView1.Rows[grdRow.RowIndex].Cells[0].Text);
            txtquant = (TextBox)(GridView1.Rows[grdRow.RowIndex].Cells[4].FindControl("txtQuantity"));
            if (txtquant.Text != null && txtquant.Text != "")
            {
                quantity = int.Parse(txtquant.Text);
            }
            else
            {
                quantity = 0;
            }
            
            if (quantity > 0)
            {
                sqlItemID = "Select ItemId from ShoppingItem where ItemId = " + ItemID;
                sqlCartID = "Select ItemId from Cart where UserId = " + id + " and ItemId = " + ItemID;
                SqlCommand cmd2;
                connection.Open();
                cmd2 = new SqlCommand(sqlCartID, connection);
                SqlCommand cmd = new SqlCommand(sqlItemID, connection);
                
                int itemIDSI = (int)cmd.ExecuteScalar();
                object result = cmd2.ExecuteScalar();
                int itemIDCart;
                if (result == null)
                {
                    itemIDCart = 0;
                }
                else
                {
                    itemIDCart = (int)cmd2.ExecuteScalar();
                }
                

                if (itemIDCart != itemIDSI)
                {
                    query = "INSERT INTO dbo.Cart VALUES (" + itemIDSI + "," + id + "," + quantity + ")";
                    SqlCommand cmd1 = new SqlCommand(query, connection);
                    if(id != 0)
                    {
                        cmd1.ExecuteNonQuery();
                    }
                    
                    flag = true;
                }
                else
                {
                    query1 = "UPDATE dbo.Cart SET Quantity = " + quantity + " WHERE ItemId = " + itemIDCart + " and UserId = " + id;
                    SqlCommand cmd4 = new SqlCommand(query1, connection);
                    if (id != 0)
                    {
                        cmd4.ExecuteNonQuery();
                    }
                    
                    flag = true;
                }
                
                connection.Close();
            }
            
        }
        
        if (flag == true)
        {
            lblSuccess.Attributes["style"] = "color: green; font-weight: bold;";
            lblSuccess.Text = "Items added/updated successfully to the Cart.";
        }
        else
        {
            lblSuccess.Attributes["style"] = "color: red; font-weight: bold;";
            lblSuccess.Text = "Items not added to the Cart, please try again later.";
        }
       

    }

    protected void btnViewCart_Click(object sender, EventArgs e)
    {
        Server.Transfer("ViewCart.aspx");
    }

    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        Response.Redirect(Page.ResolveUrl("~/Login.aspx"));

    }
</script>

<asp:Content ID="ContentHead" ContentPlaceHolderID="head" runat="server">
    <link href="../css/addcart.css" rel="stylesheet" type="text/css" />
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
             <br />
             <br />
             <h4>If you would like to purchase any of the below items, mention the "Quantity" against that item and click on "Add Items" below. Go ahead and shop now!</h4>
             <br />
             <div class="cart img-responsive">
                 <asp:GridView CssClass="table-responsive table" ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="3" DataKeyNames="ItemId" DataSourceID="SqlDataSource1" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="2px">
                    <Columns>
                        <asp:BoundField DataField="ItemId" HeaderText="ItemId" InsertVisible="False" ReadOnly="True" SortExpression="ItemId" />
                        <asp:BoundField DataField="Name" HeaderText="Name" ReadOnly="True" SortExpression="Name" />
                        <asp:BoundField DataField="Price" HeaderText="Price" ReadOnly="True" SortExpression="Price" />
                        <asp:TemplateField HeaderText="Image" SortExpression="Image">
                            <ItemTemplate>
                                <asp:Image ID="Image1" runat="server" ImageUrl='<%# Bind("Image") %>'/>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Quantity" SortExpression="Quantity">
                            <ItemTemplate>
                                <asp:TextBox ID="txtQuantity" runat="server" MaxLength="3" Columns="3"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <FooterStyle BackColor="White" ForeColor="#000066" />
                    <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Justify" />
                    <RowStyle ForeColor="#000066" />
                    <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                    <SortedAscendingHeaderStyle BackColor="#007DBB" />
                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                    <SortedDescendingHeaderStyle BackColor="#00547E" />
                </asp:GridView>
    
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:swra0110ConnectionString1 %>" SelectCommand="SELECT * FROM [ShoppingItem]"></asp:SqlDataSource>
                <br />
                 <div class="align">
                     <asp:Button CssClass="btn btn-primary" ID="btnAddItems" runat="server" Text="Add Items" OnClick="btnAddItems_Click" ToolTip="To add items, click here"/>
                     &nbsp; &nbsp; &nbsp; &nbsp;
                     <asp:Button CssClass="btn btn-primary" ID="btnViewCart" runat="server" Text="View Cart" OnClick="btnViewCart_Click" ToolTip="To view cart items, click here" />
                      <br />
                      <br />
                      <asp:Label ID="lblSuccess" runat="server" Text=""></asp:Label>
                 </div>
               
                
             </div>
         </div>
    </div>
</asp:Content>
