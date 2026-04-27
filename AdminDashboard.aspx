<%@ Page Title="Admin Dashboard" Language="C#" MasterPageFile="~/tracking_system.master" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs" Inherits="CourierTrackingSystem034.AdminDashboard" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">
<style>
:root {
    --bg: #0f1117;
    --card: #1a1d27;
    --border: #2a2d3a;
    --accent: #f97316;
    --accent2: #3b82f6;
    --accent3: #10b981;
    --muted: #6b7280;
    --text: #f1f5f9;
    --radius: 14px;
}
* { box-sizing: border-box; margin: 0; padding: 0; }
body { background: var(--bg); color: var(--text); font-family: 'Inter', sans-serif; }

.db-wrap { display: flex; min-height: 100vh; }

/* SIDEBAR */
.sidebar {
    width: 230px; background: var(--card); border-right: 1px solid var(--border);
    display: flex; flex-direction: column; padding: 24px 0; position: fixed;
    height: 100vh; overflow-y: auto; z-index: 100;
}
.sb-logo {
    font-size: 22px; font-weight: 800; padding: 0 24px 24px;
    border-bottom: 1px solid var(--border); margin-bottom: 16px;
}
.sb-logo span { color: var(--accent); }
.sb-sec { font-size: 10px; font-weight: 700; color: var(--muted); text-transform: uppercase;
    letter-spacing: 1.5px; padding: 12px 24px 6px; }
.sb-item {
    display: flex; align-items: center; gap: 10px; padding: 10px 24px;
    cursor: pointer; font-size: 13.5px; color: var(--muted); border-radius: 0;
    transition: all .2s; position: relative;
}
.sb-item:hover { color: var(--text); background: rgba(249,115,22,.07); }
.sb-item.active { color: var(--accent); background: rgba(249,115,22,.12); font-weight: 600; }
.sb-item.active::before {
    content: ''; position: absolute; left: 0; top: 0; bottom: 0;
    width: 3px; background: var(--accent); border-radius: 0 4px 4px 0;
}
.sbi { font-size: 16px; }
.notif-dot {
    width: 7px; height: 7px; border-radius: 50%; background: var(--accent);
    margin-left: auto;
}
.sb-bot { margin-top: auto; padding: 16px 24px; border-top: 1px solid var(--border); }
.lg-btn {
    width: 100%; padding: 10px; background: rgba(249,115,22,.15);
    border: 1px solid rgba(249,115,22,.3); color: var(--accent);
    border-radius: 8px; cursor: pointer; font-size: 13px; font-weight: 600;
}
.lg-btn:hover { background: rgba(249,115,22,.25); }

/* MAIN */
.main-c { margin-left: 230px; flex: 1; padding: 0 32px 40px; min-height: 100vh; }
.mh {
    display: flex; align-items: center; padding: 18px 0;
    border-bottom: 1px solid var(--border); margin-bottom: 32px;
    position: sticky; top: 0; background: var(--bg); z-index: 50;
}
.ub { display: flex; align-items: center; gap: 10px; }
.ua {
    width: 36px; height: 36px; border-radius: 50%; background: var(--accent);
    display: flex; align-items: center; justify-content: center;
    font-weight: 700; font-size: 14px;
}
.mob-tog { display: none; }

/* PANELS */
.dpanel { display: none; }
.dpanel.active { display: block; }
.slabel { font-size: 11px; font-weight: 700; color: var(--accent); text-transform: uppercase;
    letter-spacing: 1.5px; margin-bottom: 6px; }
.stitle { font-size: 28px; font-weight: 800; color: var(--text); }

/* KPI */
.kpi-row { display: grid; grid-template-columns: repeat(4,1fr); gap: 16px; margin-bottom: 32px; }
.kpi {
    background: var(--card); border: 1px solid var(--border); border-radius: var(--radius);
    padding: 22px; transition: transform .2s;
}
.kpi:hover { transform: translateY(-2px); }
.kpi-l { font-size: 12px; color: var(--muted); text-transform: uppercase;
    letter-spacing: 1px; margin-bottom: 10px; }
.kpi-v { font-size: 36px; font-weight: 800; color: var(--text); margin-bottom: 6px; }
.kpi-ch { font-size: 12px; color: var(--accent3); }

/* TABLE */
.tw { background: var(--card); border: 1px solid var(--border); border-radius: var(--radius); overflow: hidden; }
.tw table { width: 100%; border-collapse: collapse; font-size: 13.5px; }
.tw th {
    padding: 14px 16px; text-align: left; background: rgba(255,255,255,.03);
    color: var(--muted); font-size: 11px; text-transform: uppercase;
    letter-spacing: 1px; border-bottom: 1px solid var(--border);
}
.tw td { padding: 14px 16px; border-bottom: 1px solid rgba(255,255,255,.04); }
.tw tr:last-child td { border-bottom: none; }
.tw tr:hover td { background: rgba(255,255,255,.02); }

/* BADGES */
.sbadge {
    padding: 4px 12px; border-radius: 20px; font-size: 11px;
    font-weight: 700; display: inline-block;
}
.s0 { background: rgba(249,115,22,.15); color: #f97316; }
.s1 { background: rgba(59,130,246,.15); color: #3b82f6; }
.s2 { background: rgba(168,85,247,.15); color: #a855f7; }
.s3 { background: rgba(236,72,153,.15); color: #ec4899; }
.s4 { background: rgba(245,158,11,.15); color: #f59e0b; }
.s5 { background: rgba(16,185,129,.15); color: #10b981; }

/* FORMS */
.add-form, .upd-form {
    background: var(--card); border: 1px solid var(--border);
    border-radius: var(--radius); padding: 32px; max-width: 700px;
}
.add-form h2, .upd-form h2 { font-size: 18px; font-weight: 700; margin-bottom: 24px; }
.fr { display: grid; grid-template-columns: 1fr 1fr; gap: 16px; }
.fg { display: flex; flex-direction: column; gap: 6px; margin-bottom: 16px; }
.fg label { font-size: 12px; color: var(--muted); font-weight: 600; text-transform: uppercase; letter-spacing: .8px; }
.fg input, .fg select {
    background: rgba(255,255,255,.05); border: 1px solid var(--border);
    border-radius: 8px; padding: 11px 14px; color: var(--text);
    font-size: 14px; outline: none; transition: border .2s;
}
.fg input:focus, .fg select:focus { border-color: var(--accent); }
.fg select option { background: var(--card); }

/* BUTTONS */
.btn { padding: 10px 20px; border-radius: 8px; border: none; cursor: pointer;
    font-size: 13px; font-weight: 600; transition: all .2s; }
.btn-b { background: var(--accent); color: white; }
.btn-b:hover { background: #ea6c00; }
.btn-g { background: var(--accent3); color: white; }
.btn-g:hover { background: #059669; }
.btn-p { background: #a855f7; color: white; }
.btn-s { background: rgba(255,255,255,.08); color: var(--text); }
.btn-d { background: rgba(239,68,68,.15); color: #ef4444; }
.btn-d:hover { background: rgba(239,68,68,.25); }
.btn-sm { padding: 6px 12px; font-size: 12px; }
.act-btns { display: flex; gap: 6px; }
.fbtn {
    width: 100%; padding: 12px; background: var(--accent); color: white;
    border: none; border-radius: 8px; cursor: pointer; font-size: 14px;
    font-weight: 700; margin-top: 8px;
}
.fbtn:hover { background: #ea6c00; }

/* ALERTS */
.alert { padding: 10px 14px; border-radius: 8px; font-size: 13px;
    font-weight: 600; display: none; margin-bottom: 12px; }
.alert.show { display: block; }
.a-ok { background: rgba(16,185,129,.15); color: var(--accent3); }
.a-err { background: rgba(239,68,68,.15); color: #ef4444; }

/* MODALS */
.modal-ov {
    position: fixed; inset: 0; background: rgba(0,0,0,.7);
    display: flex; align-items: center; justify-content: center;
    z-index: 999; opacity: 0; pointer-events: none; transition: opacity .2s;
}
.modal-ov.open { opacity: 1; pointer-events: all; }
.modal-box {
    background: var(--card); border: 1px solid var(--border);
    border-radius: var(--radius); padding: 32px; width: 90%; max-width: 480px;
    position: relative;
}
.modal-box h3 { font-size: 18px; font-weight: 700; margin-bottom: 20px; }
.modal-close {
    position: absolute; top: 16px; right: 16px; background: none;
    border: none; color: var(--muted); font-size: 18px; cursor: pointer;
}

/* TRACK */
.track-card {
    background: var(--card); border: 1px solid var(--border);
    border-radius: var(--radius); padding: 32px;
}
.track-card h2 { font-size: 18px; font-weight: 700; margin-bottom: 8px; }
.tc-sub { color: var(--muted); font-size: 13px; margin-bottom: 20px; }
.ti-row { display: flex; gap: 10px; margin-bottom: 20px; }
.ti-row input {
    flex: 1; background: rgba(255,255,255,.05); border: 1px solid var(--border);
    border-radius: 8px; padding: 12px 16px; color: var(--text); font-size: 14px; outline: none;
}
.ti-row input:focus { border-color: var(--accent); }
.tbtn {
    padding: 12px 24px; background: var(--accent); color: white;
    border: none; border-radius: 8px; cursor: pointer; font-weight: 700;
}
.rp { display: none; }
.rp.show { display: block; }
.rid { font-size: 13px; color: var(--muted); margin-bottom: 4px; }
.rstatus { font-size: 20px; font-weight: 800; margin-bottom: 20px; }
.tline { display: flex; flex-direction: column; gap: 0; }
.ts { display: flex; gap: 14px; }
.tsl { display: flex; flex-direction: column; align-items: center; }
.tdot {
    width: 14px; height: 14px; border-radius: 50%;
    background: var(--border); border: 2px solid var(--border); flex-shrink: 0;
}
.tdot.done { background: var(--accent3); border-color: var(--accent3); }
.tdot.active { background: var(--accent); border-color: var(--accent);
    box-shadow: 0 0 10px rgba(249,115,22,.5); }
.tln { width: 2px; flex: 1; background: var(--border); min-height: 30px; }
.tc { padding-bottom: 24px; }
.tlabel { font-size: 14px; font-weight: 600; color: var(--text); }
.tlabel.ml { color: var(--muted); }
.tsub { font-size: 12px; color: var(--muted); margin-top: 2px; }

/* ANALYTICS */
.analytics-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-bottom: 24px; }
.an-card {
    background: var(--card); border: 1px solid var(--border);
    border-radius: var(--radius); padding: 24px;
}
.an-card h4 { font-size: 14px; font-weight: 700; margin-bottom: 16px; }
.donut-wrap { display: flex; align-items: center; gap: 24px; }
.donut-svg { width: 120px; height: 120px; }
.dl-item { display: flex; align-items: center; gap: 8px; font-size: 13px; margin-bottom: 6px; }
.dl-dot { width: 10px; height: 10px; border-radius: 50%; flex-shrink: 0; }
.bar-row { display: flex; align-items: center; gap: 10px; margin-bottom: 10px; }
.bar-label { font-size: 12px; color: var(--muted); width: 100px; flex-shrink: 0; }
.bar-track { flex: 1; background: rgba(255,255,255,.06); border-radius: 4px; height: 8px; overflow: hidden; }
.bar-fill { height: 100%; border-radius: 4px; transition: width .6s; }
.bar-val { font-size: 12px; font-weight: 700; width: 24px; text-align: right; }
.timeline-chart { display: flex; align-items: flex-end; gap: 8px; height: 100px; margin-bottom: 8px; }
.tc-bar { flex: 1; background: var(--accent2); border-radius: 4px 4px 0 0; min-height: 4px; }
.tc-labels { display: flex; gap: 8px; }
.tc-labels span { flex: 1; text-align: center; font-size: 11px; color: var(--muted); }
.exp-btns { display: flex; gap: 10px; flex-wrap: wrap; margin-top: 12px; }
.exp-btn {
    padding: 9px 18px; background: rgba(255,255,255,.06); border: 1px solid var(--border);
    color: var(--text); border-radius: 8px; cursor: pointer; font-size: 13px;
}
.exp-btn:hover { background: rgba(255,255,255,.1); }

/* AUDIT */
.audit-entry {
    display: flex; align-items: flex-start; gap: 14px;
    padding: 12px 0; border-bottom: 1px solid var(--border);
}
.audit-entry:last-child { border-bottom: none; }
.audit-icon { font-size: 18px; flex-shrink: 0; }
.audit-title { font-size: 13px; font-weight: 600; }
.audit-meta { font-size: 11px; color: var(--muted); margin-top: 2px; }
.audit-time { font-size: 11px; color: var(--muted); margin-left: auto; flex-shrink: 0; }

/* AGENTS */
.agent-grid { display: grid; grid-template-columns: repeat(3,1fr); gap: 16px; }
.agent-card {
    background: var(--card); border: 1px solid var(--border);
    border-radius: var(--radius); padding: 20px;
}
.agent-top { display: flex; align-items: center; gap: 12px; margin-bottom: 16px; }
.agent-av {
    width: 44px; height: 44px; border-radius: 50%;
    display: flex; align-items: center; justify-content: center;
    font-weight: 800; font-size: 15px; color: white; flex-shrink: 0;
}
.agent-name { font-weight: 700; font-size: 14px; }
.agent-zone { font-size: 12px; color: var(--muted); }
.agent-stats { display: flex; gap: 16px; margin-bottom: 12px; }
.agent-stat { text-align: center; }
.asn { font-size: 20px; font-weight: 800; }
.asl { font-size: 11px; color: var(--muted); }
.online-dot { display: inline-block; width: 8px; height: 8px; border-radius: 50%; margin-right: 4px; }
.od-on { background: var(--accent3); }
.od-off { background: var(--muted); }

/* USERS */
.filter-bar { display: flex; gap: 12px; margin-bottom: 16px; }
.filter-bar input, .filter-bar select {
    padding: 9px 14px; background: var(--card); border: 1px solid var(--border);
    border-radius: 8px; color: var(--text); font-size: 13px; outline: none;
}
.filter-bar input { flex: 1; }
.user-badge { padding: 3px 10px; border-radius: 20px; font-size: 11px; font-weight: 700; }
.ub-admin { background: rgba(168,85,247,.15); color: #a855f7; }
.ub-user  { background: rgba(59,130,246,.15); color: #3b82f6; }
.ub-active   { background: rgba(16,185,129,.15); color: #10b981; }
.ub-inactive { background: rgba(239,68,68,.15); color: #ef4444; }

/* SETTINGS */
.sett-sec {
    background: var(--card); border: 1px solid var(--border);
    border-radius: var(--radius); padding: 28px; max-width: 600px; margin-bottom: 20px;
}
.sett-sec h3 { font-size: 15px; font-weight: 700; margin-bottom: 20px; }

.panel-header { display: flex; align-items: flex-start; justify-content: space-between; margin-bottom: 20px; }

@media(max-width:900px) {
    .sidebar { transform: translateX(-100%); transition: transform .3s; }
    .sidebar.open { transform: translateX(0); }
    .main-c { margin-left: 0; padding: 0 16px 40px; }
    .mob-tog { display: block; background: none; border: 1px solid var(--border);
        color: var(--text); padding: 8px 12px; border-radius: 8px; cursor: pointer; }
    .kpi-row { grid-template-columns: 1fr 1fr; }
    .analytics-grid { grid-template-columns: 1fr; }
    .agent-grid { grid-template-columns: 1fr; }
    .fr { grid-template-columns: 1fr; }
}
</style>
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
<div class="db-wrap">
    <aside class="sidebar" id="adminSB">
        <div class="sb-logo">Swift<span>Track</span></div>
        <div class="sb-sec">Main</div>
        <div class="sb-item active" onclick="showAP('overview',this)"><span class="sbi">📊</span> Overview</div>
        <div class="sb-item" onclick="showAP('couriers',this)"><span class="sbi">📦</span> All Couriers</div>
        <div class="sb-item" onclick="showAP('add',this)"><span class="sbi">➕</span> Add Courier</div>
        <div class="sb-item" onclick="showAP('upd',this)"><span class="sbi">🔄</span> Update Status</div>
        <div class="sb-sec">Management</div>
        <div class="sb-item" onclick="showAP('users',this)"><span class="sbi">👥</span> User Management</div>
        <div class="sb-item" onclick="showAP('agents',this)"><span class="sbi">🚴</span> Delivery Agents</div>
        <div class="sb-sec">Reports</div>
        <div class="sb-item" onclick="showAP('analytics',this)"><span class="sbi">📈</span> Analytics</div>
        <div class="sb-item" onclick="showAP('audit',this)"><span class="sbi">📋</span> Audit Log<span class="notif-dot"></span></div>
        <div class="sb-sec">Tools</div>
        <div class="sb-item" onclick="showAP('atrack',this)"><span class="sbi">🔍</span> Track Parcel</div>
        <div class="sb-item" onclick="showAP('asett',this)"><span class="sbi">⚙️</span> Settings</div>
        <div class="sb-bot">
            <button class="lg-btn" onclick="doLogout()">🚪 Log Out</button>
        </div>
    </aside>

    <main class="main-c">
        <div class="mh">
            <button class="mob-tog" onclick="document.getElementById('adminSB').classList.toggle('open')">☰</button>
            <div style="display:flex;align-items:center;gap:1rem;margin-left:auto;">
                <span style="color:var(--muted);font-size:.84rem;" id="aGreet">Welcome, Admin</span>
                <div class="ub"><div class="ua" id="aAv">A</div><span id="aN">Admin</span></div>
            </div>
        </div>

        <!-- OVERVIEW -->
        <div class="dpanel active" id="ap-overview">
            <div class="slabel">Dashboard</div>
            <h2 class="stitle" style="margin-bottom:1.5rem;">Overview</h2>
            <div class="kpi-row">
                <div class="kpi"><div class="kpi-l">Total Couriers</div><div class="kpi-v" id="kTotal">—</div><div class="kpi-ch">All entries</div></div>
                <div class="kpi"><div class="kpi-l">In Transit</div><div class="kpi-v" id="kTransit">—</div><div class="kpi-ch">Active shipments</div></div>
                <div class="kpi"><div class="kpi-l">Delivered</div><div class="kpi-v" id="kDel">—</div><div class="kpi-ch">Completed</div></div>
                <div class="kpi"><div class="kpi-l">Out for Delivery</div><div class="kpi-v" id="kOFD">—</div><div class="kpi-ch">Today</div></div>
            </div>
            <h3 style="font-size:1rem;font-weight:700;margin-bottom:1rem;">Recent Couriers</h3>
            <div class="tw"><table><thead><tr><th>Tracking ID</th><th>Sender</th><th>Receiver</th><th>Route</th><th>Status</th></tr></thead><tbody id="ovTb"></tbody></table></div>
        </div>

        <!-- ALL COURIERS -->
        <div class="dpanel" id="ap-couriers">
            <div class="slabel">Management</div>
            <h2 class="stitle" style="margin-bottom:1.5rem;">All Couriers</h2>
            <div class="tw"><table><thead><tr><th>Tracking ID</th><th>Sender</th><th>Receiver</th><th>Origin</th><th>Destination</th><th>Weight</th><th>Status</th><th>Actions</th></tr></thead><tbody id="allTb"></tbody></table></div>
        </div>

        <!-- ADD COURIER -->
        <div class="dpanel" id="ap-add">
            <div class="slabel">Admin</div>
            <h2 class="stitle" style="margin-bottom:1.5rem;">Add New Courier</h2>
            <div class="add-form">
                <h2>📦 Courier Entry</h2>
                <div class="alert a-ok" id="addOk"></div>
                <div class="alert a-err" id="addErr"></div>
                <div class="fr">
                    <div class="fg"><label>Sender Name</label><input type="text" id="aS" placeholder="Ravi Sharma"/></div>
                    <div class="fg"><label>Sender Phone</label><input type="text" id="aSP" placeholder="+91 98765 43210"/></div>
                </div>
                <div class="fr">
                    <div class="fg"><label>Receiver Name</label><input type="text" id="aR" placeholder="Priya Patel"/></div>
                    <div class="fg"><label>Receiver Phone</label><input type="text" id="aRP" placeholder="+91 91234 56789"/></div>
                </div>
                <div class="fr">
                    <div class="fg"><label>Origin City</label><input type="text" id="aO" placeholder="Mumbai"/></div>
                    <div class="fg"><label>Destination City</label><input type="text" id="aD" placeholder="Delhi"/></div>
                </div>
                <div class="fr">
                    <div class="fg"><label>Weight (kg)</label><input type="number" id="aW" placeholder="2.5" step="0.1"/></div>
                    <div class="fg"><label>Initial Status</label>
                        <select id="aSt"><option>Pickup</option><option>Parcel Hub</option><option>In Transit</option><option>Destination Hub</option><option>Out for Delivery</option><option>Delivered</option></select>
                    </div>
                </div>
                <button class="fbtn" onclick="adminAdd()">Generate Tracking ID & Add →</button>
            </div>
        </div>

        <!-- UPDATE STATUS -->
        <div class="dpanel" id="ap-upd">
            <div class="slabel">Admin</div>
            <h2 class="stitle" style="margin-bottom:1.5rem;">Update Parcel Status</h2>
            <div class="upd-form">
                <h2>🔄 Status Update</h2>
                <div class="alert a-ok" id="updOk"></div>
                <div class="alert a-err" id="updErr"></div>
                <div class="fg"><label>Tracking ID</label><input type="text" id="uID" placeholder="CT123456"/></div>
                <div class="fg"><label>New Status</label>
                    <select id="uSt"><option>Pickup</option><option>Parcel Hub</option><option>In Transit</option><option>Destination Hub</option><option>Out for Delivery</option><option>Delivered</option></select>
                </div>
                <button class="fbtn" onclick="adminUpd()">Update Status →</button>
            </div>
        </div>

        <!-- TRACK -->
        <div class="dpanel" id="ap-atrack">
            <div class="slabel">Tools</div>
            <h2 class="stitle" style="margin-bottom:1.5rem;">Track Any Parcel</h2>
            <div class="track-card" style="max-width:620px;">
                <h2>🔍 Parcel Lookup</h2>
                <p class="tc-sub">Look up any parcel by Tracking ID.</p>
                <div class="ti-row">
                    <input type="text" id="aTI" placeholder="e.g. CT123456" onkeydown="if(event.key==='Enter')doTrack()"/>
                    <button class="tbtn" onclick="doTrack()">Track</button>
                </div>
                <div class="rp" id="aRP2"><div class="rid" id="aRI"></div><div class="rstatus" id="aRS"></div><div class="tline" id="aTL"></div></div>
            </div>
        </div>

        <!-- SETTINGS -->
        <div class="dpanel" id="ap-asett">
            <div class="slabel">Admin</div>
            <h2 class="stitle" style="margin-bottom:1.5rem;">Settings</h2>
            <div class="sett-sec">
                <h3>Profile Information</h3>
                <div class="fr">
                    <div class="fg"><label>First Name</label><input type="text" id="aSF" placeholder="Admin"/></div>
                    <div class="fg"><label>Last Name</label><input type="text" id="aSL" placeholder="User"/></div>
                </div>
                <div class="fg"><label>Email</label><input type="email" id="aSE" placeholder="admin@swift.com"/></div>
                <div class="fg"><label>Phone</label><input type="tel" id="aSPh" placeholder="+91 00000 00000"/></div>
                <button class="btn btn-b" onclick="flashAlert('aSA','✅ Profile updated!','a-ok')">Save Profile</button>
                <div class="alert a-ok" id="aSA" style="margin-top:1rem;"></div>
            </div>
            <div class="sett-sec">
                <h3>Change Password</h3>
                <div class="fg"><label>Current Password</label><input type="password" placeholder="••••••••"/></div>
                <div class="fg"><label>New Password</label><input type="password" placeholder="Min 6 chars"/></div>
                <div class="fg"><label>Confirm Password</label><input type="password" placeholder="Re-enter"/></div>
                <button class="btn btn-p">Change Password</button>
            </div>
        </div>

        <!-- USER MANAGEMENT -->
        <div class="dpanel" id="ap-users">
            <div class="panel-header">
                <div><div class="slabel">Admin</div><h2 class="stitle">User Management</h2></div>
                <button class="btn btn-b btn-sm" onclick="openAddUserModal()">➕ Add User</button>
            </div>
            <div class="filter-bar">
                <input type="text" id="uSrch" placeholder="🔍 Search by name or email…" oninput="renderUsers()"/>
                <select id="uRoleFilter" onchange="renderUsers()">
                    <option value="">All Roles</option>
                    <option value="admin">Admin</option>
                    <option value="user">User</option>
                </select>
            </div>
            <div class="tw"><table><thead><tr><th>Name</th><th>Email</th><th>Phone</th><th>Role</th><th>Status</th><th>Actions</th></tr></thead><tbody id="usersTb"></tbody></table></div>
        </div>

        <!-- DELIVERY AGENTS -->
        <div class="dpanel" id="ap-agents">
            <div class="panel-header">
                <div><div class="slabel">Admin</div><h2 class="stitle">Delivery Agents</h2></div>
                <button class="btn btn-g btn-sm" onclick="openAddAgentModal()">➕ Add Agent</button>
            </div>
            <div class="filter-bar">
                <input type="text" id="agSrch" placeholder="🔍 Search agents…" oninput="renderAgents()"/>
            </div>
            <div class="agent-grid" id="agentGrid"></div>
        </div>

        <!-- ANALYTICS -->
        <div class="dpanel" id="ap-analytics">
            <div class="slabel">Reports</div>
            <h2 class="stitle" style="margin-bottom:1.5rem;">Analytics & Reports</h2>
            <div class="analytics-grid">
                <div class="an-card"><h4>📊 Status Distribution</h4>
                    <div class="donut-wrap">
                        <svg class="donut-svg" id="donutSvg" viewBox="0 0 36 36"></svg>
                        <div class="donut-legend" id="donutLegend"></div>
                    </div>
                </div>
                <div class="an-card"><h4>🗺️ Top Routes</h4><div class="bar-chart" id="routeChart"></div></div>
                <div class="an-card"><h4>⚖️ Weight Distribution</h4><div class="bar-chart" id="weightChart"></div></div>
                <div class="an-card" style="grid-column:1/-1;">
                    <h4>📅 Weekly Shipment Volume</h4>
                    <div class="timeline-chart" id="volChart"></div>
                    <div class="tc-labels" id="volLabels"></div>
                </div>
            </div>
            <div class="an-card">
                <h4>📤 Export Report</h4>
                <div class="exp-btns">
                    <button class="exp-btn" onclick="exportCSV()">📄 Export CSV</button>
                    <button class="exp-btn" onclick="exportJSON()">📦 Export JSON</button>
                    <button class="exp-btn" onclick="printReport()">🖨️ Print</button>
                </div>
            </div>
        </div>

        <!-- AUDIT LOG -->
        <div class="dpanel" id="ap-audit">
            <div class="panel-header">
                <div><div class="slabel">System</div><h2 class="stitle">Audit Log</h2></div>
                <button class="btn btn-sm btn-s" onclick="clearAudit()">🗑️ Clear</button>
            </div>
            <div style="background:var(--card);border:1px solid var(--border);border-radius:var(--radius);padding:1.2rem 1.6rem;max-height:520px;overflow-y:auto;" id="auditLog"></div>
        </div>

    </main>
</div>

<!-- SUCCESS MODAL -->
<div class="modal-ov" id="successModal">
    <div class="modal-box" style="text-align:center;">
        <div style="font-size:3rem;margin-bottom:1rem;">✅</div>
        <h3 style="color:var(--accent3);">Courier Added!</h3>
        <p style="color:var(--muted);margin:.8rem 0;">Tracking ID:</p>
        <div id="popTrackingID" style="font-size:2rem;font-weight:800;color:var(--accent);margin-bottom:1.5rem;"></div>
        <div style="display:flex;gap:1rem;justify-content:center;">
            <button class="btn btn-b" onclick="closeModal('successModal');showAP('couriers',null)">View All</button>
            <button class="btn btn-s" onclick="closeModal('successModal')">Add Another</button>
        </div>
    </div>
</div>

<!-- ADD USER MODAL -->
<div class="modal-ov" id="addUserModal">
    <div class="modal-box">
        <button class="modal-close" onclick="closeModal('addUserModal')">✕</button>
        <h3>👤 Add New User</h3>
        <div class="alert a-err" id="auErr"></div>
        <div class="alert a-ok" id="auOk"></div>
        <div class="fr">
            <div class="fg"><label>First Name</label><input type="text" id="nuF" placeholder="Ravi"/></div>
            <div class="fg"><label>Last Name</label><input type="text" id="nuL" placeholder="Sharma"/></div>
        </div>
        <div class="fg"><label>Email</label><input type="email" id="nuE" placeholder="ravi@example.com"/></div>
        <div class="fg"><label>Phone</label><input type="tel" id="nuPh" placeholder="+91 98765 43210"/></div>
        <div class="fg"><label>Role</label><select id="nuR"><option value="user">User</option><option value="admin">Admin</option></select></div>
        <div class="fg"><label>Password</label><input type="password" id="nuP" placeholder="Min 6 chars"/></div>
        <button class="btn btn-b" style="width:100%;" onclick="addUserFromModal()">Add User →</button>
    </div>
</div>

<!-- ADD AGENT MODAL -->
<div class="modal-ov" id="addAgentModal">
    <div class="modal-box">
        <button class="modal-close" onclick="closeModal('addAgentModal')">✕</button>
        <h3>🚴 Add Delivery Agent</h3>
        <div class="alert a-ok" id="agOk"></div>
        <div class="fr">
            <div class="fg"><label>First Name</label><input type="text" id="agF" placeholder="Suresh"/></div>
            <div class="fg"><label>Last Name</label><input type="text" id="agL" placeholder="Kumar"/></div>
        </div>
        <div class="fg"><label>Zone</label><input type="text" id="agZ" placeholder="Mumbai North"/></div>
        <div class="fg"><label>Phone</label><input type="tel" id="agPh" placeholder="+91 98765 43210"/></div>
        <button class="btn btn-g" style="width:100%;" onclick="addAgentFromModal()">Add Agent →</button>
    </div>
</div>
</asp:Content>

<asp:Content ID="ScriptsContent" ContentPlaceHolderID="scripts" runat="server">
<script>
    const STAGES = ['Pickup', 'Parcel Hub', 'In Transit', 'Destination Hub', 'Out for Delivery', 'Delivered'];
    const STAGE_COLORS = ['#f97316', '#3b82f6', '#a855f7', '#ec4899', '#f59e0b', '#10b981'];
    const agColors = ['#f97316', '#3b82f6', '#10b981', '#a855f7', '#ec4899', '#f59e0b'];
    let COURIERS = [], AUDIT = [];
    let AGENTS = [
        { first: 'Suresh', last: 'Kumar', zone: 'Mumbai North', phone: '+91 91111 11111', online: true, deliveries: 24, rating: 4.8 },
        { first: 'Meena', last: 'Pillai', zone: 'Delhi South', phone: '+91 92222 22222', online: false, deliveries: 18, rating: 4.5 },
        { first: 'Arjun', last: 'Nair', zone: 'Bangalore East', phone: '+91 93333 33333', online: true, deliveries: 31, rating: 4.9 },
    ];
    let USERS = [
        { email: 'user@swift.com', role: 'user', first: 'Ravi', last: 'Sharma', phone: '+91 98765 43210', active: true },
        { email: 'admin@swift.com', role: 'admin', first: 'Admin', last: 'User', phone: '+91 00000 00000', active: true },
    ];

    function callMethod(method, data) {
        return fetch('AdminDashboard.aspx/' + method, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(data || {})
        })
            .then(r => r.json())
            .then(d => {
                try { return typeof d.d === 'string' && d.d[0] === '[' ? JSON.parse(d.d) : d.d; }
                catch (e) { return d.d; }
            });
    }

    function stageIdx(s) { return STAGES.indexOf(s); }
    function badgeHtml(s) { const i = stageIdx(s); return `<span class="sbadge s${i < 0 ? 0 : i}">${s}</span>`; }

    function showAP(id, el) {
        document.querySelectorAll('.dpanel').forEach(p => p.classList.remove('active'));
        document.querySelectorAll('.sb-item').forEach(i => i.classList.remove('active'));
        const panel = document.getElementById('ap-' + id);
        if (!panel) return;
        panel.classList.add('active');
        if (el) el.classList.add('active');
        ({
            overview: renderOverview, couriers: renderAll, users: renderUsers,
            agents: renderAgents, analytics: renderAnalytics, audit: renderAudit,
            asett: renderSettings
        })[id]?.();
    }

    // ── Overview ────────────────────────────
    function renderOverview() {
        callMethod('GetAllCouriers').then(list => {
            COURIERS = list || [];
            document.getElementById('kTotal').textContent = COURIERS.length;
            document.getElementById('kTransit').textContent = COURIERS.filter(x => x.status === 'In Transit').length;
            document.getElementById('kDel').textContent = COURIERS.filter(x => x.status === 'Delivered').length;
            document.getElementById('kOFD').textContent = COURIERS.filter(x => x.status === 'Out for Delivery').length;
            document.getElementById('ovTb').innerHTML = COURIERS.slice(0, 5).map(p =>
                `<tr><td><b>${p.trackingNumber}</b></td><td>${p.senderName}</td>
             <td>${p.receiverName}</td><td>${p.origin} → ${p.destination}</td>
             <td>${badgeHtml(p.status)}</td></tr>`
            ).join('') || '<tr><td colspan="5" style="text-align:center;color:var(--muted);padding:2rem;">No couriers found</td></tr>';
        }).catch(() => {
            document.getElementById('ovTb').innerHTML = '<tr><td colspan="5" style="color:red;padding:1rem;">Error loading data</td></tr>';
        });
    }

    // ── All Couriers ────────────────────────
    function renderAll() {
        document.getElementById('allTb').innerHTML = '<tr><td colspan="8" style="text-align:center;color:var(--muted);padding:2rem;">Loading...</td></tr>';
        callMethod('GetAllCouriers').then(list => {
            COURIERS = list || [];
            document.getElementById('allTb').innerHTML = COURIERS.map(p =>
                `<tr><td><b>${p.trackingNumber}</b></td><td>${p.senderName}</td>
             <td>${p.receiverName}</td><td>${p.origin}</td><td>${p.destination}</td>
             <td>${p.weight}kg</td><td>${badgeHtml(p.status)}</td>
             <td><div class="act-btns">
               <button class="btn btn-sm btn-g" onclick="quickUpd('${p.trackingNumber}','${p.status}')">🔄</button>
               <button class="btn btn-sm btn-d" onclick="delCourier('${p.trackingNumber}')">🗑️</button>
             </div></td></tr>`
            ).join('') || '<tr><td colspan="8" style="text-align:center;color:var(--muted);padding:2rem;">No couriers found</td></tr>';
        });
    }

    function quickUpd(id, cur) {
        const next = STAGES[Math.min(stageIdx(cur) + 1, 5)];
        if (!confirm('Update ' + id + ' → ' + next + '?')) return;
        callMethod('UpdateStatus', { trackingId: id, newStatus: next }).then(res => {
            if (res && res.includes('successfully')) { addAudit('upd', 'Updated ' + id + ' → ' + next, 'ai-upd'); renderAll(); renderOverview(); }
            else alert(res || 'Error');
        });
    }

    function delCourier(id) {
        if (!confirm('Delete ' + id + '?')) return;
        callMethod('DeleteCourier', { trackingId: id }).then(res => {
            if (res && res.includes('successfully')) { addAudit('del', 'Deleted ' + id, 'ai-del'); renderAll(); renderOverview(); }
            else alert(res || 'Error');
        });
    }

    // ── Add Courier ─────────────────────────
    function adminAdd() {
        const s = document.getElementById('aS').value.trim();
        const sp = document.getElementById('aSP').value.trim();
        const r = document.getElementById('aR').value.trim();
        const rp = document.getElementById('aRP').value.trim();
        const o = document.getElementById('aO').value.trim();
        const d = document.getElementById('aD').value.trim();
        const w = document.getElementById('aW').value.trim();
        const st = document.getElementById('aSt').value;
        if (!s || !r || !o || !d || !w) { flashAlert('addErr', '⚠️ Fill all required fields.', 'a-err'); return; }
        callMethod('AddCourier', {
            senderName: s, senderPhone: sp, receiverName: r,
            receiverPhone: rp, origin: o, destination: d, weight: w, status: st
        }).then(res => {
            if (res && res.includes('successfully')) {
                const match = res.match(/CT\d+/);
                const tid = match ? match[0] : '';
                ['aS', 'aSP', 'aR', 'aRP', 'aO', 'aD', 'aW'].forEach(x => document.getElementById(x).value = '');
                addAudit('add', 'Added ' + tid + ' (' + o + '→' + d + ')', 'ai-add');
                document.getElementById('popTrackingID').textContent = tid;
                document.getElementById('successModal').classList.add('open');
                renderOverview();
            } else flashAlert('addErr', res || '❌ Error', 'a-err');
        }).catch(() => flashAlert('addErr', '❌ Server error', 'a-err'));
    }

    // ── Update Status ───────────────────────
    function adminUpd() {
        const id = document.getElementById('uID').value.trim().toUpperCase();
        const st = document.getElementById('uSt').value;
        if (!id) { flashAlert('updErr', '❌ Enter Tracking ID.', 'a-err'); return; }
        callMethod('UpdateStatus', { trackingId: id, newStatus: st }).then(res => {
            if (res && res.includes('successfully')) {
                flashAlert('updOk', '✅ ' + id + ' → ' + st, 'a-ok');
                addAudit('upd', id + ' → ' + st, 'ai-upd');
                document.getElementById('uID').value = '';
            } else flashAlert('updErr', res || '❌ Not found', 'a-err');
        });
    }

    // ── Track ───────────────────────────────
    function doTrack() {
        const id = document.getElementById('aTI').value.trim().toUpperCase();
        const rp = document.getElementById('aRP2');
        rp.classList.remove('show');
        if (!id) { alert('Enter Tracking ID'); return; }
        const SD = [
            { label: 'Pickup', sub: 'Picked up from sender', color: '#f97316' },
            { label: 'Parcel Hub', sub: 'Arrived at origin hub', color: '#3b82f6' },
            { label: 'In Transit', sub: 'Package on the way', color: '#a855f7' },
            { label: 'Destination Hub', sub: 'At destination hub', color: '#ec4899' },
            { label: 'Out for Delivery', sub: 'With delivery agent', color: '#f59e0b' },
            { label: 'Delivered', sub: 'Successfully delivered', color: '#10b981' },
        ];
        fetch('ShipmentHandler.ashx?action=track&trackId=' + encodeURIComponent(id))
            .then(r => r.json()).then(p => {
                document.getElementById('aRI').textContent = 'Tracking ID: ' + id;
                if (!p.success) {
                    document.getElementById('aRS').textContent = '❌ Not found.';
                    document.getElementById('aTL').innerHTML = '';
                } else {
                    const rs = document.getElementById('aRS');
                    rs.textContent = '✦ ' + p.status;
                    rs.style.color = SD[p.stage]?.color || '#888';
                    document.getElementById('aTL').innerHTML = SD.map((s, i) => {
                        const done = i < p.stage, act = i === p.stage;
                        return `<div class="ts"><div class="tsl">
                  <div class="tdot ${done ? 'done' : act ? 'active' : ''}"></div><div class="tln"></div></div>
                  <div class="tc"><div class="tlabel ${!done && !act ? 'ml' : ''}" style="${act ? 'color:' + s.color : ''}">${s.label}</div>
                  <div class="tsub">${done || act ? s.sub : 'Pending'}</div></div></div>`;
                    }).join('');
                }
                rp.classList.add('show');
            }).catch(() => {
                document.getElementById('aRS').textContent = '❌ Error fetching data.';
                rp.classList.add('show');
            });
    }

    // ── Users ───────────────────────────────
    function renderUsers() {
        const srch = (document.getElementById('uSrch').value || '').toLowerCase();
        const roleF = document.getElementById('uRoleFilter').value;
        const filtered = USERS.filter(u => (u.first + ' ' + u.last + ' ' + u.email).toLowerCase().includes(srch) && (!roleF || u.role === roleF));
        document.getElementById('usersTb').innerHTML = filtered.map(u => `
        <tr><td>${u.first} ${u.last}</td><td>${u.email}</td><td>${u.phone}</td>
        <td><span class="user-badge ${u.role === 'admin' ? 'ub-admin' : 'ub-user'}">${u.role}</span></td>
        <td><span class="user-badge ${u.active ? 'ub-active' : 'ub-inactive'}">${u.active ? 'Active' : 'Inactive'}</span></td>
        <td><div class="act-btns">
          <button class="btn btn-sm btn-s" onclick="toggleUser(${USERS.indexOf(u)})">${u.active ? 'Deactivate' : 'Activate'}</button>
          <button class="btn btn-sm btn-d" onclick="delUser(${USERS.indexOf(u)})">🗑️</button>
        </div></td></tr>`
        ).join('');
    }
    function toggleUser(i) { USERS[i].active = !USERS[i].active; renderUsers(); }
    function delUser(i) { if (confirm('Delete ' + USERS[i].email + '?')) { USERS.splice(i, 1); renderUsers(); } }
    function openAddUserModal() { document.getElementById('addUserModal').classList.add('open'); }
    function closeModal(id) { document.getElementById(id).classList.remove('open'); }
    function addUserFromModal() {
        const f = document.getElementById('nuF').value.trim();
        const l = document.getElementById('nuL').value.trim();
        const e = document.getElementById('nuE').value.trim();
        const ph = document.getElementById('nuPh').value.trim();
        const r = document.getElementById('nuR').value;
        const p = document.getElementById('nuP').value.trim();
        if (!f || !l || !e || !p) { flashAlert('auErr', '⚠️ Fill all fields.', 'a-err'); return; }
        if (USERS.find(x => x.email === e)) { flashAlert('auErr', '⚠️ Email exists.', 'a-err'); return; }
        USERS.push({ first: f, last: l, email: e, phone: ph, role: r, active: true });
        flashAlert('auOk', '✅ User added!', 'a-ok');
        addAudit('add', 'New user: ' + e, 'ai-add');
        setTimeout(() => { closeModal('addUserModal'); renderUsers(); }, 1000);
    }

    // ── Agents ──────────────────────────────
    function renderAgents() {
        const srch = (document.getElementById('agSrch').value || '').toLowerCase();
        const filtered = AGENTS.filter(a => (a.first + ' ' + a.last + ' ' + a.zone).toLowerCase().includes(srch));
        document.getElementById('agentGrid').innerHTML = filtered.map((a, i) => `
        <div class="agent-card">
          <div class="agent-top">
            <div class="agent-av" style="background:${agColors[i % agColors.length]}">${a.first[0]}${a.last[0]}</div>
            <div><div class="agent-name">${a.first} ${a.last}</div><div class="agent-zone">📍 ${a.zone}</div></div>
          </div>
          <div class="agent-stats">
            <div class="agent-stat"><div class="asn">${a.deliveries}</div><div class="asl">Deliveries</div></div>
            <div class="agent-stat"><div class="asn">${a.rating}</div><div class="asl">Rating</div></div>
          </div>
          <div style="font-size:.82rem;color:var(--muted);">
            <span class="online-dot ${a.online ? 'od-on' : 'od-off'}"></span>${a.online ? 'Online' : 'Offline'} | ${a.phone}
          </div>
        </div>`
        ).join('');
    }
    function openAddAgentModal() { document.getElementById('addAgentModal').classList.add('open'); }
    function addAgentFromModal() {
        const f = document.getElementById('agF').value.trim();
        const l = document.getElementById('agL').value.trim();
        const z = document.getElementById('agZ').value.trim();
        const ph = document.getElementById('agPh').value.trim();
        if (!f || !l || !z) { flashAlert('agOk', '⚠️ Fill all fields.', 'a-err'); return; }
        AGENTS.push({ first: f, last: l, zone: z, phone: ph, online: true, deliveries: 0, rating: 5.0 });
        flashAlert('agOk', '✅ Agent added!', 'a-ok');
        setTimeout(() => { closeModal('addAgentModal'); renderAgents(); }, 1000);
    }

    // ── Analytics ────────────────────────────
    function renderAnalytics() {
        callMethod('GetAllCouriers').then(list => {
            const vals = list || [];
            const counts = STAGES.map(s => vals.filter(x => x.status === s).length);
            const total = vals.length || 1;
            let offset = 25, paths = '', legends = '';
            counts.forEach((c, i) => {
                if (!c) return;
                const pct = (c / total) * 100;
                paths += `<circle cx="18" cy="18" r="15.9" fill="none" stroke="${STAGE_COLORS[i]}" stroke-width="3.5" stroke-dasharray="${pct} ${100 - pct}" stroke-dashoffset="${-offset + 25}" transform="rotate(-90 18 18)"/>`;
                offset += pct;
                legends += `<div class="dl-item"><div class="dl-dot" style="background:${STAGE_COLORS[i]}"></div>${STAGES[i]}: ${c}</div>`;
            });
            document.getElementById('donutSvg').innerHTML = paths || '<circle cx="18" cy="18" r="15.9" fill="none" stroke="var(--border)" stroke-width="3.5"/>';
            document.getElementById('donutLegend').innerHTML = legends || '<div style="color:var(--muted)">No data</div>';

            const routes = {};
            vals.forEach(p => { const r = p.origin + '→' + p.destination; routes[r] = (routes[r] || 0) + 1; });
            const rArr = Object.entries(routes).sort((a, b) => b[1] - a[1]).slice(0, 5);
            const rMax = rArr[0] ? rArr[0][1] : 1;
            document.getElementById('routeChart').innerHTML = rArr.map(([r, c]) =>
                `<div class="bar-row"><div class="bar-label">${r}</div>
             <div class="bar-track"><div class="bar-fill" style="width:${(c / rMax) * 100}%;background:var(--accent2)"></div></div>
             <div class="bar-val">${c}</div></div>`
            ).join('') || '<p style="color:var(--muted)">No data</p>';

            const wB = { '<1kg': 0, '1-3kg': 0, '3-5kg': 0, '>5kg': 0 };
            vals.forEach(p => {
                const w = parseFloat(p.weight);
                if (w < 1) wB['<1kg']++; else if (w < 3) wB['1-3kg']++; else if (w < 5) wB['3-5kg']++; else wB['>5kg']++;
            });
            const wMax = Math.max(...Object.values(wB)) || 1;
            document.getElementById('weightChart').innerHTML = Object.entries(wB).map(([b, c]) =>
                `<div class="bar-row"><div class="bar-label">${b}</div>
             <div class="bar-track"><div class="bar-fill" style="width:${(c / wMax) * 100}%;background:var(--accent3)"></div></div>
             <div class="bar-val">${c}</div></div>`
            ).join('');

            const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
            const vols = [3, 5, 4, 7, 6, 8, 5];
            const vMax = Math.max(...vols);
            document.getElementById('volChart').innerHTML = vols.map(v =>
                `<div class="tc-bar" style="height:${(v / vMax) * 100}%"></div>`).join('');
            document.getElementById('volLabels').innerHTML = days.map(d => `<span>${d}</span>`).join('');
        });
    }

    // ── Audit ────────────────────────────────
    function addAudit(type, msg, cls) {
        const icons = { add: '✅', upd: '🔄', del: '🗑️', log: '🔐' };
        AUDIT.unshift({ type, msg, cls, time: new Date().toLocaleTimeString(), icon: icons[type] || '📋' });
    }
    function renderAudit() {
        document.getElementById('auditLog').innerHTML = AUDIT.length ? AUDIT.map(a =>
            `<div class="audit-entry">
          <div class="audit-icon">${a.icon}</div>
          <div class="audit-body"><div class="audit-title">${a.msg}</div><div class="audit-meta">System action</div></div>
          <div class="audit-time">${a.time}</div>
        </div>`).join('')
            : '<p style="color:var(--muted);text-align:center;padding:2rem;">No entries yet.</p>';
    }
    function clearAudit() { AUDIT = []; renderAudit(); }

    // ── Settings ─────────────────────────────
    function renderSettings() {
        const u = JSON.parse(sessionStorage.getItem('loggedUser') || '{}');
        if (u.first) {
            document.getElementById('aSF').value = u.first || '';
            document.getElementById('aSL').value = u.last || '';
            document.getElementById('aSE').value = u.email || '';
            document.getElementById('aSPh').value = u.phone || '';
        }
    }

    // ── Export ───────────────────────────────
    function exportCSV() {
        const rows = [['Tracking ID', 'Sender', 'Receiver', 'Origin', 'Destination', 'Weight', 'Status']];
        COURIERS.forEach(p => rows.push([p.trackingNumber, p.senderName, p.receiverName, p.origin, p.destination, p.weight, p.status]));
        const a = document.createElement('a');
        a.href = 'data:text/csv,' + encodeURIComponent(rows.map(r => r.join(',')).join('\n'));
        a.download = 'couriers.csv'; a.click();
    }
    function exportJSON() {
        const a = document.createElement('a');
        a.href = 'data:application/json,' + encodeURIComponent(JSON.stringify(COURIERS, null, 2));
        a.download = 'couriers.json'; a.click();
    }
    function printReport() { window.print(); }
    function doLogout() { window.location.href = 'Default.aspx'; }

    function showAlt(id, msg, cls) { const e = document.getElementById(id); if (!e) return; e.textContent = msg; e.className = 'alert ' + cls + ' show'; }
    function clrAlert(id) { const e = document.getElementById(id); if (e) { e.className = 'alert'; e.textContent = ''; } }
    function flashAlert(id, msg, cls) { showAlt(id, msg, cls); setTimeout(() => clrAlert(id), 4000); }

    window.onload = function () {
        renderOverview();
        addAudit('log', 'Admin logged in', 'ai-log');
    };
</script>
</asp:Content>