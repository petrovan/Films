<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Details.aspx.cs" Inherits="FilmsProject._Details" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div >
        <a href="Default.aspx">Список фильмов</a>

        <asp:DetailsView ID="FilmDetailsView" runat="server" 
            AutoGenerateRows="False" 
            DataSourceID="FilmEntityDataSource" Height="50px" Width="564px" 
            DataKeyNames="ID"  
            >
            <Fields>
                <asp:BoundField DataField="ID" HeaderText="ID"  SortExpression="ID" ReadOnly="True" Visible="false"/>
                <asp:TemplateField HeaderText="Название фильма">                
                    <ItemTemplate>
                        <asp:TextBox ID="txtName" runat="server" Text='<%# Bind("Name") %>' Width="300px" ></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvName" ControlToValidate="txtName" runat="server"
                            ErrorMessage="Введите название" ForeColor="Red"></asp:RequiredFieldValidator>
                    </ItemTemplate>                    
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Описание">                
                    <ItemTemplate>
                        <asp:TextBox ID="txtDescr" runat="server" Text='<%# Bind("Description") %>' Width="300px" Height="200px" TextMode="MultiLine"></asp:TextBox>
                    </ItemTemplate>                    
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Год выпуска">                
                    <ItemTemplate>
                        <asp:TextBox ID="txtYear" runat="server" Text='<%# Bind("Year") %>' Width="50px"></asp:TextBox>
                    </ItemTemplate>                    
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Режиссер">                
                    <ItemTemplate>
                        <asp:TextBox ID="txtDirector" runat="server" Text='<%# Bind("Director") %>' Width="300px"></asp:TextBox>
                    </ItemTemplate>                    
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Постер">                
                    <ItemTemplate>
                        <asp:Image ID="imgPoster" runat="server"  ></asp:Image>
                    </ItemTemplate>                    
                </asp:TemplateField>
                <asp:BoundField DataField="UserID" HeaderText="UserID" SortExpression="UserID" Visible="false" />

                <asp:TemplateField>
                    <EditItemTemplate >
                    <asp:FileUpload ID="PosterUpload" runat="server"  />
                    </EditItemTemplate>
                </asp:TemplateField>            
            </Fields>
                  
        </asp:DetailsView>

        <asp:Button ID="SaveFilmBtn" runat="server" Text="Сохранить" OnClick="SaveFilmBtn_Click"  />

        </div>
        <asp:EntityDataSource ID="FilmEntityDataSource" 
            runat="server" ConnectionString="name=FilmsEntities" 
            DefaultContainerName="FilmsEntities" EnableFlattening="False" EntitySetName="Films" EntityTypeFilter="Film" AutoGenerateWhereClause="True" EnableUpdate="False">
            <WhereParameters>
                <asp:QueryStringParameter QueryStringField="Id" Name="ID" Type="Int32"/>
            </WhereParameters>

            
        </asp:EntityDataSource>

</asp:Content>
