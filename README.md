# 🛡️ Encrypted SOCKS Proxy Server with Caching

A custom-configured proxy server built on Ubuntu Server OS using **Squid-Proxy**, **Redsocks**, **Dante-SOCKS**, **Shadowsocks**, and **Fail2Ban**. This layered architecture enables secure and accelerated HTTP requests through content caching, SOCKS protocol forwarding, encryption, and intrusion prevention.

---

## 🔍 Problem Statement

In modern networks, latency and security are major concerns. I wanted to:
- Reduce HTTP request latency by leveraging caching mechanisms
- Ensure secure and private data transmission using encrypted tunneling
- Gain deeper hands-on experience in server configuration and local network architecture

---

## 🎯 Project Goals

- Build a proxy server with both **caching** and **encryption**
- Enable encrypted communication over the **SOCKS protocol**
- Ensure seamless service integration between **Squid-Proxy**, **Dante-SOCKS**, and **Shadowsocks**
- Understand how different layers of a secure network proxy system interconnect
- Improve practical knowledge in **LAN/WLAN engineering and maintenance**

---

## 🛠️ Technologies Used

- **OS:** Ubuntu Server OS
- **Caching Proxy:** Squid-Proxy
- **Proxy Forwarding Layer:** Redsocks
- **SOCKS Proxy:** Dante-SOCKS
- **Encrypted Tunnel:** Shadowsocks
- **Intrusion Protection:** Fail2Ban
- **Client Communication:** Standard web client ➝ Proxy chain ➝ Public Internet

---

## 🔧 Updated System Architecture

1. **Client** sends HTTP/HTTPS requests to the **Squid-Proxy**
2. **Squid** checks for cached content; if not cached, it forwards the traffic
3. **Redsocks** redirects Squid’s traffic to **Dante**, converting standard TCP to SOCKS
4. **Dante-SOCKS** forwards the request through a local **Shadowsocks client**
5. **Shadowsocks** encrypts and transmits the traffic to the remote Shadowsocks server
6. **Fail2Ban** monitors unauthorized connection attempts and blocks malicious IPs

> 🔁 The entire flow is now:  
> **Client ➝ Squid ➝ Redsocks ➝ Dante ➝ Shadowsocks ➝ Internet**

---

## 📈 Design Decisions

- Replaced **stunnel** with **Shadowsocks** for a more modern, efficient encryption mechanism over SOCKS
- Introduced **Redsocks** to bridge Squid’s HTTP traffic to SOCKS without modifying applications
- Chose **Fail2Ban** to harden the proxy chain against brute-force and misuse
- Continued using **Squid** for caching and ACLs to reduce bandwidth and improve response time

---

## 🧩 Challenges Faced

- Replacing `stunnel` with Shadowsocks required rethinking encryption and tunneling
- Configuring **Redsocks** with proper redirection and firewall rules (iptables)
- Debugging proxy failures in chained services due to port mismatches and buffer limits
- Fine-tuning Fail2Ban filters for meaningful protection without false positives

---

## 📚 Lessons Learned

### 🧪 Technical Skills
- Writing iptables and routing rules for proxy chaining
- Translating between TCP/HTTP and SOCKS5 protocols
- Managing Shadowsocks encryption and server configuration
- Configuring Squid to work behind Redsocks with ACLs and caching policies

### 🌐 Networking Knowledge
- Secure proxy chaining and encapsulation across multiple transport layers
- Trade-offs between encryption overhead and caching performance
- Concepts of transparent proxying using `iptables` redirection
- Defense in depth with proxy + encryption + rate limiting (Fail2Ban)

---

## 📸 Diagram

```txt
Client
  ↓
Squid-Proxy (caching HTTP)
  ↓
Redsocks (redirect to SOCKS)
  ↓
Dante-SOCKS (SOCKS5 gateway)
  ↓
Shadowsocks (encryption tunnel)
  ↓
Internet