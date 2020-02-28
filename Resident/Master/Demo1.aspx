<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Public.master" AutoEventWireup="true" CodeBehind="Demo1.aspx.cs" Inherits="Resident.Master.Demo1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cp1" runat="server">
    <div>
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                <asp:Button ID="btnDemo1" runat="server" CssClass="btn btn-outline-primary" Text="Click1" OnClick="btnDemo1_Click" />
                <asp:Label runat="server" ID="lblDemo1" Text="Hello Progress" CssClass="text-danger" Visible="false" Font-Size="Large"></asp:Label>
            </ContentTemplate>
        </asp:UpdatePanel>
        <h2>Card Image</h2>
        <p>Image at the top (card-img-top):</p>
        <div class="card text-center" style="width: 400px">
            <img class="card-img-top" src="../Image/Public/Vote-Stamp-512.png" alt="Card image" style="width: 100%">
            <div class="card-body">
                <h4 class="card-title">John Doe</h4>
                <p class="card-text">Some example text some example text. John Doe is an architect and engineer</p>
                <a href="#" class="btn btn-primary">See Profile</a>
            </div>
        </div>
    </div>
</asp:Content>
