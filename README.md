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
    
5. Configure and enable SSL/TLS.

        vi /etc/nginx/conf.d/ssl.conf
 
#create new
#replace servername and path of certificates to your own one
        server {
        listen       443 ssl http2 default_server;
        listen       [::]:443 ssl http2 default_server;
        server_name  www.kp.test;
        root         /usr/share/nginx/html;

        ssl_certificate "/etc/letsencrypt/live/www.kp.test/fullchain.pem";
        ssl_certificate_key "/etc/letsencrypt/live/www.kp.test/privkey.pem";
        ssl_session_cache shared:SSL:1m;
        ssl_session_timeout  10m;
        ssl_ciphers PROFILE=SYSTEM;
        ssl_prefer_server_ciphers on;

        include /etc/nginx/default.d/*.conf;

        location / {
        }

        error_page 404 /404.html;
        location = /40x.html {
        }

        error_page 500 502 503 504 /50x.html;
        location = /50x.html {
        }
        }
                       
