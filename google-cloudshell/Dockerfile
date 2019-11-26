FROM gcr.io/cloudshell-images/cloudshell:latest

COPY nvim /usr/local/src/dotfiles.symlink/nvim
#COPY tmux /usr/local/src/dotfiles.symlink/tmux
COPY zsh /usr/local/src/dotfiles.symlink/zsh

COPY install/install_gcloudshell.sh /usr/local/src/bootstrap.sh
COPY google-cloudshell/customize_environment.symlink /usr/local/src/customize_environment.symlink

RUN chmod +x /usr/local/src/bootstrap.sh
RUN chmod +x /usr/local/src/customize_environment.symlink

RUN /usr/local/src/bootstrap.sh
