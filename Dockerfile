FROM python:2.7
COPY ./ /ac-nesrom-save-generator
WORKDIR /ac-nesrom-save-generator
RUN pip install -r requirements.txt && python setup.py install
RUN apt update && apt upgrade -y && apt install wget -y
COPY ./devkitpro/install-devkitpro-pacman ./install-devkitpro-pacman
RUN chmod +x ./install-devkitpro-pacman && ./install-devkitpro-pacman
RUN ln -s /proc/self/mounts /etc/mtab
RUN dkp-pacman -Syu --noconfirm && dkp-pacman -S gamecube-dev --noconfirm
ENV PATH="${PATH}:/opt/devkitpro/devkitPPC/bin/"
ENV DEVKITPPC=/opt/devkitpro/devkitPPC
ENTRYPOINT [ "ac-nesrom-gen" ]