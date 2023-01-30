#!/bin/bash
yum -y install nginx
systemctl start nginx
systemctl enable --now nginx
