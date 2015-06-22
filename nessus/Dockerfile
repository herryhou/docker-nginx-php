FROM debian:wheezy
COPY Nessus-6.3.7-debian6_amd64.deb /tmp/
#download from http://www.tenable.com/products/nessus/select-your-operating-system
RUN dpkg -i /tmp/Nessus-6.3.7-debian6_amd64.deb
EXPOSE 8834
CMD ["/opt/nessus/sbin/nessus-service"]

#docker build -t nessus:latest /vagrant/nessus
#docker build -t nessus:6.3.7 /vagrant/nessus
#docker run -d --name nessus -p8834:8834 nessus