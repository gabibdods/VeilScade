# Encrypted Proxy Chain

# Multi-Hop Anonymized Traffic Router with Shadowsocks, Dante, and Squid

### Description

- This project establishes a secure and private internet proxy chain using Squid, Dante (SOCKS5), and Shadowsocks
- It is deployed on an Ubuntu Server machine and integrates DNS management through Cloudflare Tunnel
- The system ensures encrypted, multi-hop routing of outbound traffic, enhancing privacy, bypassing censorship, and protecting client anonymity

---

## NOTICE

- Please read through this `README.md` to better understand the project's source code and setup instructions
- Also, make sure to review the contents of the `License/` directory
- Your attention to these details is appreciated — enjoy exploring the project!

---

## Problem Statement

- Traditional VPNs and single-node proxies present trust and surveillance risks
- This project solves that by building a self-hosted, chained proxy infrastructure where no single proxy sees both the origin and destination of traffic

---

## Project Goals

### Establish Squid as the entry-point HTTP proxy

- Squid listens on the local LAN and forwards outbound HTTP traffic to the next proxy hop while enforcing strict ACLs

### Configure Dante and Shadowsocks for encrypted, multi-hop routing

- Dante relays traffic to a Shadowsocks server over encrypted tunnels, making the outbound proxy chain secure and censorship-resistant

---

## Tools, Materials & Resources

### Tool 1

- Squid Proxy Server (HTTP filtering and access control)

### Tool 2

- Dante Server (SOCKS5 support and forwarding)

### Tool 3

- Shadowsocks-libev (lightweight encrypted proxy protocol)

### Material 1

- Ubuntu Server (Target OS for deployment)

### Resource 1

- Cloudflare Tunnel and DNS configuration for secure public exposure

---

## Design Decision

### Use Chained Proxy Architecture

- Divides responsibilities among proxies, reducing data correlation risk at any single point

### Harden Squid with ACLs and Auth

- Prevents unauthorized LAN clients from using the proxy entry point

### Encrypt Final Hop with Shadowsocks

- Ensures exit node cannot trace traffic origin or monitor payloads

---

## Features

### Multi-Hop Proxy Chain

- HTTP → SOCKS5 → Encrypted Shadowsocks with DNS resolution at exit node

### LAN Gateway

- The Squid entry node allows clients on the LAN to safely route traffic

### Secure Cloud Exposure

- Cloudflare Tunnel manages remote access while preserving encryption

---

## Block Diagram

### Example: 

```plaintext
          ┌──────────────┐
          │  LAN Client  │
          └──────┬───────┘
                 ↓
        ┌────────▼─────────┐
        │     Squid        │
        │(HTTP Proxy + ACL)│
        └────────┬─────────┘
                 ↓
         ┌───────▼────────┐
         │     Dante      │
         │   (SOCKS5)     │
         └───────┬────────┘
                 ↓
        ┌────────▼────────┐
        │  Shadowsocks    │
        │ (Encrypted Exit)│
        └─────────────────┘

```

---

## Functional Overview

- Traffic enters through Squid, which enforces access policies
- Forwarded traffic passes through Dante (SOCKS5 relay)
- Final hop encrypts and exits via Shadowsocks to public internet

---

## Challenges & Solutions

### Challenge 1

- DNS leaks and IP exposure during transit — mitigated by configuring remote DNS resolution at Shadowsocks exit

### Challenge 2

- Ensuring Squid and Dante remain isolated from public access — solved by LAN binding and firewall rules

---

## Lessons Learned

### Lesson for 1

- Proxy chaining across protocols improves flexibility and security compared to monolithic solutions

### Lesson for 2

- Fine-tuning ACLs and transparent proxy configs is critical for maintaining usability without sacrificing control

---

## Project Structure

```plaintext
root/
├── License/
│   ├── LICENSE.md
│   │
│   └── NOTICE.md
│
├── .gitattributes
│
├── .gitignore
│
├── README.md
│
├── dante/
│   ├── veilscade.alone.dante
│   │
│   ├── veilscade.dante
│   │
│   └── veilscade.dante.ex
│
├── fail2ban/
│   ├── veilscade.fail2ban
│   │
│   └── veilscade.fail2ban.ex
│
├── gai/
│   └── veilscade.gai.ex
│
├── redsocks/
│   ├── veilscade.redsocks
│   │
│   └── veilscade.redsocks.ex
│
├── shadowsocks/
│   ├── veilscade.config.shadowsocks
│   │
│   ├── veilscade.local.shadowsocks
│   │
│   └── veilscade.shadowsocks.ex
│
└── squid/
    ├── veilscade.squid
    │
    └── veilscade.squid.ex

```

---

## Future Enhancements

- Add support for WireGuard VPN as an additional routing layer
- Implement monitoring dashboard for traffic and health checks
- Add auto-restart and containerization using Docker Compose
