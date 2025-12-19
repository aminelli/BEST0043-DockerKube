FROM scratch
ADD rootfs.tar.gz /
RUN apt-get update
RUN apt-get install htop nano net-tools iputils-ping -y
# CMD ["bash"]
CMD ["/bin/bash"]
