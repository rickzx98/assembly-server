#!/usr/bin/env bash
webHome=/opt/swiss-man-web;
sudo mkdir $webHome;
sudo ufw allow 80;
sudo rm -R $webHome/*;
sudo cp -R * $webHome;
sudo chmod -R 777 $webHome;
sudo rm /etc/systemd/system/swiss-man-web.service;
sudo echo "
    [Unit]
    Description=Swiss Manufacturing Company
    Requires=network.target
    [Service]
    Type=simple
    Group=root
    User=ubuntu
    WorkingDirectory=$webHome
    ExecStart=/usr/bin/node $webHome/dist/index.js
    Restart=on-failure
    [Install]
    WantedBy=multi-user.target" >> /etc/systemd/system/swiss-man-web.service;
sudo chown ubuntu:root /etc/systemd/system/swiss-man-web.service;
sudo chmod 644 /etc/systemd/system/swiss-man-web.service;
sudo kill -9 $(sudo lsof -t -i:80)
sudo systemctl daemon-reload;
sudo systemctl enable --now swiss-man-web;
sudo systemctl start swiss-man-web;