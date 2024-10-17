FROM ubuntu:24.04

RUN apt-get update && apt-get install -y --no-install-recommends \
  eekboek \
  less \
  python3 \
  python-is-python3 \
  python3-pip \
  python3-venv \
  python3-mt-940 \
  python3-virtualenv \
  tmux \
  neovim \
  && rm -rf /var/lib/apt/lists/*

COPY ./requirements.txt ./requirements.txt

RUN python3 -m venv /accounting/venv

RUN /accounting/venv/bin/pip install --no-cache-dir -r requirements.txt

ENV PATH="/accounting/venv/bin:$PATH"

RUN echo "alias ebi='ebshell --init'" >> /etc/bash.bashrc
RUN echo "alias ebjaareinde='ebshell --command jaareinde --boekjaar=2024'" >> /etc/bash.bashrc
RUN echo "alias ebbalans='ebshell --command balans'" >> /etc/bash.bashrc

CMD ["/bin/bash"]
