<%@ Control Language="c#" AutoEventWireup="false" CodeBehind="RegisterSuccess.ascx.cs"
    Inherits="CanhCam.Web.CustomUI.RegisterSuccess" %>

<div class="container">
    <div class="row flex flex-wrap">
        <div class="col-xs-12 col-md-10 col-lg-8 col-xl-6 offset-md-1 offset-lg-2 offset-xl-3">
            <div class="signup-panel flex flex-wrap clearfix">
                <div class="signup-form clearfix" style="margin: 40px 0;">
                    <div class="alert alert-success">
                        <strong>Success!</strong> Your account has been successfully created and is pending approval. All information we will contact your Email
                    </div>
                    <h3>Web Will Auto Back to Home after <span id="timer">10</span> seconds</h3>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    var myVar = setInterval(myTimer, 1000);
    var time = 10;
    function myTimer() {
        if (time == 0)
            location.href = "/";
        else
        {
            document.getElementById("timer").innerHTML = time;
            time = time - 1;
        }
}
</script>