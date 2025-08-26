FROM ubuntu:20.04

RUN apt-get update && apt-get install -y squid dante-server shadowsocks-libev fail2ban redsocks iproute2 && rm -rf /var/lib/apt/lists/*

COPY squid.conf /etc/squid/squid.conf
COPY redsocks.conf /etc/redsocks.conf
COPY dante.conf /etc/danted.conf
COPY shadowsocks.json /etc/shadowsocks-libev/config.json
COPY fail2ban.conf /etc/fail2ban/fail2ban.conf
COPY gai.conf /etc/gai.conf

EXPOSE 1080 3128 443 80

CMD ["sh", "-c", "service squid start && service danted start && service fail2ban start && redsocks -c /etc/redsocks.conf"]
