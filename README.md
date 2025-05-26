# 🛡️ Encrypted SOCKS Proxy Server with Caching

A custom-configured proxy server built on Linux Ubuntu using Squid-Proxy and DANTE-SOCKS, enhanced with SSH tunneling for encrypted communication. This setup enables secure and accelerated HTTP requests through content caching and SOCKS protocol encapsulation.

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
- Ensure seamless service integration between Squid-Proxy, DANTE-SOCKS, and SSH
- Understand how different layers of a secure network proxy system interconnect
- Improve practical knowledge in **LAN/WLAN engineering and maintenance**

---

## 🛠️ Technologies Used

- **OS:** Ubuntu Linux  
- **Proxy Service:** Squid-Proxy  
- **SOCKS Support:** DANTE-SOCKS  
- **Encryption Layer:** stunnel (for SSH tunneling over SOCKS)  
- **Client Communication:** Standard web client > proxy chain  

---

## 🔧 System Architecture

1. **Client connects to the proxy server** (hosted on Ubuntu)
2. **Squid-Proxy** receives the request and checks its local **cache**
3. If not cached, **Squid forwards** the request to **DANTE-SOCKS**
4. **DANTE** encapsulates the request through a **SOCKS connection**
5. **stunnel** wraps the communication in an **SSH tunnel**, encrypting it
6. The request is securely transmitted to the public internet

---

## 📈 Design Decisions

- **Squid-Proxy** for HTTP caching and proxying capabilities  
- **DANTE-SOCKS** for handling SOCKS protocol connections  
- **stunnel** for SSH tunneling, providing encryption over SOCKS  
- Chose **Ubuntu** for ease of server management, community support, and stability

---

## 🧩 Challenges Faced

- Understanding how Squid, DANTE, and stunnel interoperate
- Configuring each service properly with correct port bindings, ACLs, and forwarding rules
- Troubleshooting service chaining errors between proxy layers
- Locating comprehensive, up-to-date documentation for integrating legacy and modern networking tools

---

## 📚 Lessons Learned

### 🧪 Technical Skills
- Configuring and maintaining a proxy server on Linux
- Handling advanced service chaining (Squid ➝ DANTE ➝ SSH)
- Setting up encrypted SOCKS tunnels
- Using Squid’s cache system to speed up repeated HTTP requests

### 🌐 Networking Knowledge
- Local Area Network (LAN) and Wireless LAN (WLAN) design principles  
- The concept and mechanisms of **peer caching**
- Access control and traffic routing at the application and transport layers

---

## 📸 Diagram

The HTTP Request traverses the following path: client → Squid → DANTE → SSH tunnel → Internet

---

## 🚀 Future Enhancements

- Deploy service within a Docker container or VM for portability  
- Add access logging and real-time monitoring dashboard  
- Implement advanced ACLs to restrict specific traffic types  
- Optimize caching policies for bandwidth-heavy environments  
- Consider integrating TLS termination for HTTPS-aware caching  
