# NGINX

![logo](https://blog.desdelinux.net/wp-content/uploads/2022/05/Nginx.jpg)

**nginx [engine x] is an HTTP and reverse proxy server, a mail proxy server, and a generic TCP/UDP proxy server, originally written by Igor Sysoev.**

Install fast HTTP Server [Nginx] and configure HTTP/Proxy Server with it.

1. Install Nginx.

        yum -y install nginx
    
2. Configure Nginx.

        vi /etc/nginx/nginx.conf 
    
        # line 41 : change to your hostname
        server_name www.kp.test;
    
3. Enable Service   
 
        systemctl enable --now nginx
    
4. If Firewalld is running, allow HTTP service. HTTP uses [80/TCP]

        firewall-cmd --add-service=http
        firewall-cmd --runtime-to-permanent
    
    You should get  :: **success**
    
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
        
6. Reload Service

       systemctl reload nginx 
       
7. If you'd like to set HTTP connection to redirect to HTTPS (Always on SSL/TLS), configure
       
       vi /etc/nginx/nginx.conf
       
       # add into the section of listening 80 port
       server {
        listen       80 default_server;
        listen       [::]:80 default_server;
        return       301 https://$host$request_uri;
        server_name  www.srv.world;
        root         /usr/share/nginx/html;
        
8. Reload Service

       systemctl reload nginx
        
9.  Allow HTTPS service. HTTPS uses [443/TCP].
        
        firewall-cmd --add-service=https
        firewall-cmd --runtime-to-permanent
        
    You should get  :: **success**
