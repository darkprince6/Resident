<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="WebUserControl1.ascx.cs" Inherits="Resident.Master.WebUserControl1" %>

<style type="text/css">
    html, body {
        background: none !important;
    }


    #overlay {
        position: fixed;
        z-index: 99;
        top: 0px;
        left: 0px;
        background-color: #FFFFFF;
        width: 100%;
        height: 100%;
        filter: Alpha(Opacity=80);
        opacity: 0.80;
        -moz-opacity: 0.80;
    }


    #theprogress {
        /*background-color: #D3BB9C;*/
        width: 110px;
        height: 24px;
        text-align: center;
        filter: Alpha(Opacity=100);
        opacity: 1;
        -moz-opacity: 1;
    }

    #modalprogress {
        position: absolute;
        top: 50%;
        left: 50%;
        margin: -11px 0 0 -55px;
        color: white;
    }

    body > #modalprogress {
        position: fixed;
    }
</style>

<div id="overlay">
    <div id="modalprogress">
        <div id="theprogress">
            <%--<div class="spinner-grow spinner-grow-sm text-primary"></div>
                            <div class="spinner-grow spinner-grow-sm text-danger"></div>
                            <div class="spinner-grow spinner-grow-sm text-success"></div>--%>
            <div class="spinner-border spinner-border-sm text-danger"></div>

        </div>
    </div>
</div>
