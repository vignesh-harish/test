# Use the Red Hat UBI base image
FROM registry.access.redhat.com/ubi8/ubi:8.4

# Install necessary packages
RUN yum -y install openssh-server && \
    yum clean all

# Generate SSH keys (replace with your own keys)
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N '' && \
    ssh-keygen -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -N '' && \
    ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key -N ''

# Create a user for bastion access (replace with your username)
RUN useradd -m -s /bin/bash testing && \
    echo 'testing:testing123' | chpasswd

# Expose the SSH port
EXPOSE 22

# Start the SSH service
CMD ["/usr/sbin/sshd", "-D"]
