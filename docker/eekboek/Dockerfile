FROM ubuntu:24.04

RUN apt-get update && apt-get install -y --no-install-recommends \
  eekboek \
  neovim \
  && rm -rf /var/lib/apt/lists/*

RUN echo "alias ebi='ebshell --init'" >> /etc/bash.bashrc
RUN echo "alias ebjaareinde='ebshell --command jaareinde --boekjaar=2024'" >> /etc/bash.bashrc
RUN echo "alias ebbalans='ebshell --command balans'" >> /etc/bash.bashrc

CMD ["/bin/bash"]
