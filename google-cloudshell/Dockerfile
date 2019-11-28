FROM gcr.io/cloudshell-images/cloudshell:latest

COPY nvim /usr/local/src/dotfiles.symlink/nvim
COPY zsh /usr/local/src/dotfiles.symlink/zsh

COPY install/install_gcloudshell.sh /usr/local/src/bootstrap_image.sh
COPY google-cloudshell/bootstrap_home.symlink /usr/local/src/bootstrap_home.sh

RUN chmod +x /usr/local/src/bootstrap_image.sh
RUN chmod +x /usr/local/src/bootstrap_home.sh

ARG DEBIAN_FRONTEND=noninteractive

RUN /usr/local/src/bootstrap_image.sh
