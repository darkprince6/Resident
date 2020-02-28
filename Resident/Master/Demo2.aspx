<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Public.master" AutoEventWireup="true" CodeBehind="Demo2.aspx.cs" Inherits="Resident.Master.Demo2" %>
<%@ Register Src="~/Master/WebUserControl1.ascx" TagPrefix="uc" TagName="Progress" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cp1" runat="server">
    <div>

        <asp:UpdatePanel runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <asp:Button ID="btnDemo2" runat="server" CssClass="btn btn-outline-primary" Text="Click2" OnClick="btnDemo2_Click" />
                <asp:Label runat="server" ID="lblDemo2" Text="Hello Progress2" CssClass="text-danger" Visible="false" Font-Size="Large"></asp:Label>

                <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                    <ProgressTemplate>
                        <uc:Progress runat="server" />
                    </ProgressTemplate>
                </asp:UpdateProgress>
            </ContentTemplate>
        </asp:UpdatePanel>
        <p>Image at the bottom (card-img-bottom):</p>
        <div class="card" style="width: 400px">
            <div class="card-body text-center">
                <h4 class="card-title">Jane Doe</h4>
                <p class="card-text">Some example text some example text. Jane Doe is an architect and engineer</p>
                <a href="#" class="btn btn-primary">See Profile</a>
            </div>
            <img class="card-img-bottom" src="../Image/Public/Vote Icon.png" alt="Card image" style="width: 100%">
        </div>
    </div>
</asp:Content>
