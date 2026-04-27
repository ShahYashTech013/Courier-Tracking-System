<%@ Page Title="Home" Language="C#" MasterPageFile="~/tracking_system.master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="CourierTrackingSystem034._Default" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

<!-- GLOBAL NAV -->
<nav id="gNav">
  <div class="logo"><a href="Default.aspx" style="text-decoration:none;color:inherit;">Swift<span>Track</span></a></div>
  <ul class="nav-links">
    <li><a href="Default.aspx">Home</a></li>
    <li><a href="#flow" onclick="document.getElementById('flow').scrollIntoView({behavior:'smooth'});return false;">How It Works</a></li>
    <li><a href="#stages" onclick="document.getElementById('stages').scrollIntoView({behavior:'smooth'});return false;">Stages</a></li>
  </ul>
  <div class="nav-right">
    <a class="nb ghost" href="Auth.aspx">Log In</a>
    <a class="nb fill" href="Auth.aspx">Sign Up Free</a>
  </div>
  <button class="hburg" onclick="toggleMob()"><span></span><span></span><span></span></button>
</nav>
<div class="mob-menu" id="mobMenu">
  <a href="Default.aspx">🏠 Home</a>
  <a href="#flow" onclick="document.getElementById('flow').scrollIntoView({behavior:'smooth'});toggleMob();return false;">ℹ️ How It Works</a>
  <a href="Auth.aspx">🔐 Login / Register</a>
</div>

<!-- HOME PAGE -->
<div class="page active" id="pg-home">
  <section class="hero">
    <div class="hero-bg"></div>
    <div class="hero-badge">🚀 Real-Time Parcel Tracking</div>
    <h1>Track Every<br/><em>Courier, Live.</em></h1>
    <p>SwiftTrack gives you instant visibility into your shipments — from pickup to doorstep delivery — with a powerful admin portal and live status updates.</p>
    <div class="hero-acts">
      <button class="btn btn-p" onclick="document.getElementById('ht').scrollIntoView({behavior:'smooth'})">Track a Parcel →</button>
      <a class="btn btn-s" href="Auth.aspx">Get Started Free</a>
    </div>
  </section>

  <section class="home-track" id="ht">
    <div class="track-card">
      <h2>🔍 Track Your Shipment</h2>
      <p class="tc-sub">Enter your Tracking ID to view the current delivery status of your parcel.</p>
      <div class="ti-row">
        <input type="text" id="hTI" placeholder="e.g. CT123456" maxlength="12" autocomplete="off" onkeydown="if(event.key==='Enter')doTrack('hTI','hRP','hRI','hRS','hTL')"/>
        <button class="tbtn" onclick="doTrack('hTI','hRP','hRI','hRS','hTL')">Track</button>
      </div>
      <div class="rp" id="hRP"><div class="rid" id="hRI"></div><div class="rstatus" id="hRS"></div><div class="tline" id="hTL"></div></div>
      <p style="margin-top:1rem;font-size:.77rem;color:var(--muted);">Demo IDs: CT123456 · CT654321 · CT999000 · CT111222 · CT333444</p>
    </div>
  </section>

  <hr class="divider"/>

  <section class="flow-sec" id="flow">
    <div class="slabel">System Flow</div>
    <h2 class="stitle">Complete Courier Lifecycle</h2>
    <p class="ssub">From admin login to final delivery — every step is tracked.</p>
    <div class="flow-grid">
      <div class="fc-card fc1"><div class="fc-num">01</div><div class="fc-icon">🔐</div><h3>Admin Login</h3><p>Secure credential-based login.</p></div>
      <div class="fc-card fc2"><div class="fc-num">02</div><div class="fc-icon">📦</div><h3>Courier Entry</h3><p>Admin adds parcel details. Unique Tracking ID auto-generated.</p></div>
      <div class="fc-card fc3"><div class="fc-num">03</div><div class="fc-icon">🔄</div><h3>Status Updates</h3><p>Parcel moves through 6 stages.</p></div>
      <div class="fc-card fc4"><div class="fc-num">04</div><div class="fc-icon">📡</div><h3>User Tracking</h3><p>User enters Tracking ID. System fetches live status.</p></div>
      <div class="fc-card fc5"><div class="fc-num">05</div><div class="fc-icon">✅</div><h3>Delivery Complete</h3><p>Status updated to Delivered.</p></div>
    </div>
  </section>

  <hr class="divider"/>

  <section class="stages-sec" id="stages">
    <div class="slabel">Parcel Stages</div>
    <h2 class="stitle">Live Status Stages</h2>
    <p class="ssub">Each parcel progresses through clearly defined stages.</p>
    <div class="stages-row">
      <div class="stage-chip"><div class="sdot" style="background:#f97316"></div>Pickup</div>
      <div class="stage-chip"><div class="sdot" style="background:#3b82f6"></div>Parcel Hub</div>
      <div class="stage-chip"><div class="sdot" style="background:#a855f7"></div>In Transit</div>
      <div class="stage-chip"><div class="sdot" style="background:#ec4899"></div>Destination Hub</div>
      <div class="stage-chip"><div class="sdot" style="background:#f59e0b"></div>Out for Delivery</div>
      <div class="stage-chip"><div class="sdot" style="background:#10b981"></div>Delivered</div>
    </div>
  </section>

  <hr class="divider"/>

  <section class="stats-sec">
    <div class="stat-c"><div class="stat-n">12<span>K+</span></div><div class="stat-l">Parcels Delivered</div></div>
    <div class="stat-c"><div class="stat-n">98<span>%</span></div><div class="stat-l">On-Time Rate</div></div>
    <div class="stat-c"><div class="stat-n">6</div><div class="stat-l">Tracking Stages</div></div>
    <div class="stat-c"><div class="stat-n">24<span>/7</span></div><div class="stat-l">Live Uptime</div></div>
  </section>

  <footer>
    <div class="fc">© 2025 SwiftTrack — Courier Tracking System</div>
    <ul class="flinks"><li><a href="#">Privacy</a></li><li><a href="#">Terms</a></li><li><a href="#">Contact</a></li></ul>
  </footer>
</div>

</asp:Content>

<asp:Content ID="ScriptsContent" ContentPlaceHolderID="scripts" runat="server">
<script>
    let DB = {
        'CT123456': { sender: 'Ravi Sharma', sPhone: '+91 98765 43210', receiver: 'Priya Patel', rPhone: '+91 91234 56789', origin: 'Mumbai', dest: 'Delhi', status: 'In Transit', stage: 2, weight: '2.5' },
        'CT654321': { sender: 'Amit Joshi', sPhone: '+91 88765 43210', receiver: 'Neha Verma', rPhone: '+91 81234 56789', origin: 'Pune', dest: 'Bangalore', status: 'Out for Delivery', stage: 4, weight: '1.2' },
        'CT999000': { sender: 'Sunita Rao', sPhone: '+91 77765 43210', receiver: 'Kiran Desai', rPhone: '+91 71234 56789', origin: 'Chennai', dest: 'Hyderabad', status: 'Delivered', stage: 5, weight: '3.0' },
        'CT111222': { sender: 'Vikram Singh', sPhone: '+91 66765 43210', receiver: 'Pooja Nair', rPhone: '+91 61234 56789', origin: 'Kolkata', dest: 'Ahmedabad', status: 'Pickup', stage: 0, weight: '0.8' },
        'CT333444': { sender: 'Deepa Iyer', sPhone: '+91 55765 43210', receiver: 'Rahul Gupta', rPhone: '+91 51234 56789', origin: 'Jaipur', dest: 'Lucknow', status: 'Parcel Hub', stage: 1, weight: '4.5' },
    };
    const STAGES = [
        { label: 'Pickup', sub: 'Parcel picked up from sender', color: '#f97316' },
        { label: 'Parcel Hub', sub: 'Arrived at origin hub', color: '#3b82f6' },
        { label: 'In Transit', sub: 'Package is on the way', color: '#a855f7' },
        { label: 'Destination Hub', sub: 'Arrived at destination hub', color: '#ec4899' },
        { label: 'Out for Delivery', sub: 'With delivery agent', color: '#f59e0b' },
        { label: 'Delivered', sub: 'Successfully delivered', color: '#10b981' },
    ];

    function toggleMob() { document.getElementById('mobMenu').classList.toggle('open'); }

    function doTrack(tiId, rpId, riId, rsId, tlId) {
        const id = document.getElementById(tiId).value.trim().toUpperCase();
        const rp = document.getElementById(rpId);
        rp.classList.remove('show');
        if (!id) { alert('Please enter a Tracking ID.'); return; }

        document.getElementById(riId).textContent = 'Loading...';

        // Call server-side WebMethod to fetch from database
        fetch('Default.aspx/GetShipment', {
            method: 'POST',
            headers: {'Content-Type': 'application/json'},
            body: JSON.stringify({ trackId: id })
        })
        .then(response => response.json())
        .then(data => {
            let shipment = data.d ? JSON.parse(data.d) : null;
            document.getElementById(riId).textContent = 'Tracking ID: ' + id;

            if (!shipment) {
                document.getElementById(rsId).textContent = '❌ Not found.';
                document.getElementById(tlId).innerHTML = '<p style="color:var(--muted);font-size:.84rem;">Try: CT123456 · CT654321 · CT999000</p>';
            } else {
                const rs = document.getElementById(rsId);
                rs.textContent = '✦ ' + shipment.status;
                rs.style.color = STAGES[shipment.stage].color;
                let h = '';
                STAGES.forEach((s, i) => {
                    const done = i < shipment.stage, act = i === shipment.stage;
                    h += `<div class="ts"><div class="tsl"><div class="tdot ${done ? 'done' : act ? 'active' : ''}"></div><div class="tln"></div></div><div class="tc"><div class="tlabel ${!done && !act ? 'ml' : ''}" style="${act ? 'color:' + s.color : ''}">${s.label}</div><div class="tsub">${done || act ? s.sub : 'Pending'}</div></div></div>`;
                });
                document.getElementById(tlId).innerHTML = h;
            }
            rp.classList.add('show');
        })
        .catch(error => {
            document.getElementById(rsId).textContent = '❌ Error: ' + error;
            document.getElementById(tlId).innerHTML = '';
            rp.classList.add('show');
        });
    }
</script>
</asp:Content>