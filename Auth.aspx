<%@ Page Title="Login" Language="C#" MasterPageFile="~/tracking_system.master" AutoEventWireup="true" CodeBehind="Auth.aspx.cs" Inherits="CourierTrackingSystem034.Auth" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

<!-- AUTH PAGE -->
<div class="page active" id="pg-auth">
<div class="auth-wrap">
    <div class="auth-bg"></div>

    <div class="auth-grid">

      <!-- LEFT -->
      <div class="auth-left">
        <div class="logo">Swift<span>Track</span></div>
        <h1>Your parcels,<br/><em>always in sight.</em></h1>
        <p>Track shipments, get updates, manage everything in one place.</p>
      </div>

      <!-- RIGHT -->
      <div class="auth-box">

        <!-- Tabs -->
        <div class="atabs">
          <div class="atab active" onclick="switchTab('login')">Log In</div>
          <div class="atab" onclick="switchTab('reg')">Register</div>
        </div>

        <!-- LOGIN -->
        <div class="aform active" id="f-login">

          <asp:Label ID="lblError" runat="server" ForeColor="Red"></asp:Label>

          <div class="fg">
            <label>Username</label>
            <asp:TextBox ID="txtUsername" runat="server" CssClass="input"></asp:TextBox>
          </div>

          <div class="fg">
            <label>Password</label>
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="input"></asp:TextBox>
          </div>

          <asp:Button ID="btnLogin" runat="server" Text="Login →" CssClass="fbtn" OnClick="btnLogin_Click" />

        </div>

        <!-- REGISTER -->
        <div class="aform" id="f-reg">

          <div id="regMessage" style="color: #f97316; margin-bottom: 10px;"></div>

          <div class="fg">
            <label>Username</label>
            <input type="text" id="rUser" />
          </div>

          <div class="fg">
            <label>Password</label>
            <input type="password" id="rPass" />
          </div>

          <button class="fbtn" type="button" onclick="doRegister()">Register →</button>

        </div>

      </div>
    </div>
</div>
</div>

<script>
function switchTab(tab) {
    document.getElementById("f-login").classList.remove("active");
    document.getElementById("f-reg").classList.remove("active");

    if (tab === "login")
        document.getElementById("f-login").classList.add("active");
    else
        document.getElementById("f-reg").classList.add("active");
}

function doRegister() {
    let username = document.getElementById("rUser").value.trim();
    let password = document.getElementById("rPass").value.trim();
    let msgDiv = document.getElementById("regMessage");

    if (!username || !password) {
        msgDiv.textContent = "❌ Enter username & password";
        return;
    }

    msgDiv.textContent = "Registering...";

    // Call server-side WebMethod
    fetch('Auth.aspx/RegisterUser', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            username: username,
            password: password
        })
    })
    .then(response => response.json())
    .then(data => {
        msgDiv.textContent = data.d;
        if (data.d.includes("✅")) {
            document.getElementById("rUser").value = "";
            document.getElementById("rPass").value = "";
            setTimeout(() => switchTab('login'), 2000);
        }
    })
    .catch(error => {
        msgDiv.textContent = "❌ Error: " + error;
    });
}
</script>

</asp:Content>