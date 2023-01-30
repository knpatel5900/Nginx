# NGINX

![logo](https://blog.desdelinux.net/wp-content/uploads/2022/05/Nginx.jpg)

**nginx [engine x] is an HTTP and reverse proxy server, a mail proxy server, and a generic TCP/UDP proxy server, originally written by Igor Sysoev.**

Install fast HTTP Server [Nginx] and configure HTTP/Proxy Server with it.

1. Install Nginx.

        yum -y install nginx
    
2. Configure Nginx.

        vi /etc/nginx/nginx.conf 
    
  _# line 41 : change to your hostname
    server_name www.kp.test;_
    
3. Enable Service    
        systemctl enable --now nginx
    
4. If Firewalld is running, allow HTTP service. HTTP uses [80/TCP]

        firewall-cmd --add-service=http
        firewall-cmd --runtime-to-permanent
    
    You should get  :: _success_
    
