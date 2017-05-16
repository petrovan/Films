<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="FilmsProject._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        
        <asp:GridView ID="GridViewFilms" runat="server" AllowPaging="True" PageSize="5" AutoGenerateColumns="False" DataSourceID="EntityDataSource1">
            <Columns>
                <asp:BoundField DataField="ID" HeaderText="ID" ReadOnly="True" SortExpression="ID" Visible="false" />

                <asp:TemplateField HeaderText="Название фильма">
                    <ItemTemplate>
                        <asp:HyperLink runat="server" NavigateUrl='<%# Eval("ID", "~/Details.aspx?Id={0}") %>'
                            Text='<%# Eval("Name") %>' />

                       
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>

        <asp:EntityDataSource ID="EntityDataSource1" runat="server" OrderBy="it.Name"
            ConnectionString="name=FilmsEntities" 
            DefaultContainerName="FilmsEntities" 
            EnableFlattening="False" EntitySetName="Films" Select="it.[ID], it.[Name]">
        </asp:EntityDataSource>
        
    </div>

</asp:Content>
