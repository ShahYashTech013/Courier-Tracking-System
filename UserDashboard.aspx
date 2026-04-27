<%@ Page Title="User Dashboard" Language="C#" MasterPageFile="~/tracking_system.master" AutoEventWireup="true" CodeBehind="UserDashboard.aspx.cs" Inherits="CourierTrackingSystem034.UserDashboard" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

<style>
.user-page { padding: 20px; max-width: 1200px; margin: auto; }
.topbar {
    display: flex; justify-content: space-between; align-items: center;
    padding: 15px 20px; background: #111827; color: white;
    border-radius: 10px; margin-bottom: 20px;
}
.logo { font-size: 22px; font-weight: bold; }
.logo span { color: #f97316; }
.user-box { display: flex; align-items: center; gap: 10px; }
.avatar {
    width: 40px; height: 40px; border-radius: 50%;
    background: #f97316; display: flex; align-items: center;
    justify-content: center; color: white; font-weight: bold;
}
.card {
    background: white; padding: 20px; border-radius: 12px;
    box-shadow: 0 4px 20px rgba(0,0,0,0.1); margin-bottom: 20px;
}
.track-input {
    padding: 10px; width: 60%; border-radius: 8px;
    border: 1px solid #ccc; font-size: 14px;
}
.track-btn {
    padding: 10px 20px; background: #f97316; color: white;
    border: none; border-radius: 8px; cursor: pointer;
    font-size: 14px; font-weight: bold; margin-left: 8px;
}
.track-btn:hover { background: #ea6c00; }
.logout-btn {
    background: #f97316; color: white; padding: 8px 15px;
    border: none; border-radius: 5px; cursor: pointer;
    text-decoration: none; font-size: 13px;
}
.info-box {
    margin-top: 14px; padding: 14px;
    background: #f9fafb; border-radius: 8px;
    border: 1px solid #e5e7eb; font-size: 14px; line-height: 2;
}
.error-box { color: red; margin-top: 10px; font-weight: bold; font-size: 14px; }
.loading-box { color: #888; margin-top: 10px; font-style: italic; }

/* Stage Bar */
.stage-bar {
    display: flex; flex-wrap: wrap;
    gap: 6px; margin-top: 16px; align-items: center;
}
.stage-chip {
    padding: 8px 16px; border-radius: 20px;
    font-size: 13px; font-weight: 600;
    background: #e5e7eb; color: #6b7280;
    border: 2px solid transparent;
}
.stage-chip.done {
    background: #dcfce7; color: #16a34a;
    border: 2px solid #16a34a;
}
.stage-chip.active {
    color: white;
    box-shadow: 0 4px 12px rgba(0,0,0,0.2);
}
.stage-arrow { color: #9ca3af; font-size: 18px; font-weight: bold; }

/* Table */
.ship-table { width: 100%; border-collapse: collapse; font-size: 14px; }
.ship-table th {
    padding: 10px; text-align: left;
    background: #f3f4f6; border-bottom: 2px solid #e5e7eb;
    font-size: 13px; color: #374151;
}
.ship-table td { padding: 10px; border-bottom: 1px solid #f3f4f6; }
.ship-table tr:hover { background: #fafafa; }
.badge {
    padding: 4px 10px; border-radius: 12px;
    font-size: 12px; font-weight: 700;
}
</style>

<div class="user-page">

    <!-- TOP BAR -->
    <div class="topbar">
        <div class="logo">Swift<span>Track</span></div>
        <div class="user-box">
            <div class="avatar" id="uAv">U</div>
            <span id="uName">User</span>
            <a href="Default.aspx" class="logout-btn">Logout</a>
        </div>
    </div>

    <!-- TRACK CARD -->
    <div class="card">
        <h2>📦 Track Your Parcel</h2>
        <p style="color:#6b7280; margin-bottom:12px;">
            Enter your Tracking ID to view live delivery status
        </p>
        <div>
            <input type="text" id="trackId"
                placeholder="e.g. CT123456"
                class="track-input"
                onkeydown="if(event.key==='Enter') trackParcel()" />
            <button class="track-btn" onclick="trackParcel()">🔍 Track</button>
        </div>
        <div id="trackResult"></div>
    </div>

    <!-- MY SHIPMENTS -->
    <div class="card">
        <h2>📋 My Shipments</h2>
        <div id="shipmentSection">
            <p style="color:#999;">Loading your shipments...</p>
        </div>
    </div>

    <asp:HiddenField ID="hfUsername" runat="server" />

</div>

<script type="text/javascript">

    var STAGES = [
        { label: "Pickup", color: "#22c55e" },
        { label: "Parcel Hub", color: "#3b82f6" },
        { label: "In Transit", color: "#8b5cf6" },
        { label: "Destination Hub", color: "#06b6d4" },
        { label: "Out for Delivery", color: "#f97316" },
        { label: "Delivered", color: "#16a34a" }
    ];

    window.onload = function () {
        var uname = document.getElementById('<%= hfUsername.ClientID %>').value;
        if (uname) {
            document.getElementById('uName').textContent = uname;
            document.getElementById('uAv').textContent = uname.charAt(0).toUpperCase();
        }
        loadMyShipments();
    };

    // ── Track Parcel ──────────────────────────────────────
    function trackParcel() {
        var id = document.getElementById("trackId").value.trim().toUpperCase();
        var resultDiv = document.getElementById("trackResult");

        if (!id) {
            resultDiv.innerHTML = '<p class="error-box">⚠️ Please enter a Tracking ID.</p>';
            return;
        }

        resultDiv.innerHTML = '<p class="loading-box">🔍 Searching...</p>';

        var xhr = new XMLHttpRequest();
        xhr.open("GET", "ShipmentHandler.ashx?action=track&trackId=" 
                 + encodeURIComponent(id), true);

        xhr.onload = function () {
            if (xhr.status === 200) {
                try {
                    var s = JSON.parse(xhr.responseText);

                    if (!s.success) {
                        resultDiv.innerHTML = '<p class="error-box">❌ Tracking ID not found. Please check and try again.</p>';
                        return;
                    }

                    var badgeColor = STAGES[s.stage] ? STAGES[s.stage].color : "#888";

                    var html = '<div class="info-box">' +
                        '<p>📍 <b>Status:</b> <span style="color:' + badgeColor + ';font-weight:700;">' + s.status + '</span></p>' +
                        '<p>🏙️ <b>From:</b> ' + s.origin + ' &nbsp;→&nbsp; <b>To:</b> ' + s.destination + '</p>' +
                        '<p>👤 <b>Sender:</b> ' + s.senderName + ' &nbsp;|&nbsp; <b>Receiver:</b> ' + s.receiverName + '</p>' +
                        '<p>⚖️ <b>Weight:</b> ' + s.weight + ' kg</p>' +
                        '</div>';

                    // Stage Bar
                    html += '<div class="stage-bar">';
                    for (var i = 0; i < STAGES.length; i++) {
                        var cls = "";
                        var style = "";
                        if (i < s.stage) {
                            cls = "done";
                        } else if (i === s.stage) {
                            cls = "active";
                            style = 'style="background:' + STAGES[i].color + ';"';
                        }
                        html += '<div class="stage-chip ' + cls + '" ' + style + '>' 
                                + STAGES[i].label + '</div>';
                        if (i < STAGES.length - 1) {
                            html += '<span class="stage-arrow">›</span>';
                        }
                    }
                    html += '</div>';
                    html += '<p style="margin-top:10px;font-size:13px;color:#6b7280;">Current Stage: <b style="color:' 
                            + badgeColor + ';">' + s.status + '</b></p>';

                    resultDiv.innerHTML = html;

                } catch(e) {
                    resultDiv.innerHTML = '<p class="error-box">❌ Parse error. Try again.</p>';
                }
            } else {
                resultDiv.innerHTML = '<p class="error-box">❌ Server error. Please try again.</p>';
            }
        };

        xhr.onerror = function () {
            resultDiv.innerHTML = '<p class="error-box">❌ Connection error. Please try again.</p>';
        };

        xhr.send();
    }

    // ── My Shipments ──────────────────────────────────────
    function loadMyShipments() {
        var section = document.getElementById("shipmentSection");
        var uname = document.getElementById('<%= hfUsername.ClientID %>').value;

        section.innerHTML = '<p style="color:#999;">Loading...</p>';

        var xhr = new XMLHttpRequest();
        xhr.open("GET", "ShipmentHandler.ashx?action=myshipments&uname="
            + encodeURIComponent(uname), true);

        xhr.onload = function () {
            if (xhr.status === 200) {
                try {
                    var list = JSON.parse(xhr.responseText);

                    if (!list || list.length === 0) {
                        section.innerHTML = '<p style="color:#999;">No shipments found.</p>';
                        return;
                    }

                    var html = '<table class="ship-table"><thead><tr>' +
                        '<th>Tracking ID</th><th>From → To</th>' +
                        '<th>Receiver</th><th>Status</th><th>Date</th>' +
                        '</tr></thead><tbody>';

                    for (var i = 0; i < list.length; i++) {
                        var s = list[i];
                        var color = "#888";
                        if (s.status === "Delivered") color = "#16a34a";
                        else if (s.status === "Out for Delivery") color = "#f97316";
                        else if (s.status === "In Transit") color = "#8b5cf6";
                        else if (s.status === "Pickup") color = "#22c55e";
                        else if (s.status === "Parcel Hub") color = "#3b82f6";
                        else if (s.status === "Destination Hub") color = "#06b6d4";

                        html += '<tr>' +
                            '<td><b>' + s.trackingId + '</b></td>' +
                            '<td>' + s.origin + ' → ' + s.destination + '</td>' +
                            '<td>' + s.receiverName + '</td>' +
                            '<td><span class="badge" style="background:' + color + '20;color:'
                            + color + ';">' + s.status + '</span></td>' +
                            '<td style="color:#888;font-size:12px;">' + s.bookingDate + '</td>' +
                            '</tr>';
                    }

                    html += '</tbody></table>';
                    section.innerHTML = html;

                } catch (e) {
                    section.innerHTML = '<p style="color:red;">Error loading data.</p>';
                }
            } else {
                section.innerHTML = '<p style="color:#999;">Could not load shipments.</p>';
            }
        };

        xhr.onerror = function () {
            section.innerHTML = '<p style="color:#999;">Connection error.</p>';
        };

        xhr.send();
    }
</script>

</asp:Content>