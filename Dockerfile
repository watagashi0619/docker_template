FROM python:3.11

# 作業ディレクトリの設定
WORKDIR /workspace
ARG PROJECT_NAME="sample_project"

RUN apt-get update
# タイムゾーンの設定
ENV TZ=Asia/Tokyo
ENV LANG=en_US.UTF-8
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get install -yq --no-install-recommends \
    build-essential \
    python3-pip \
    curl \
    unzip \
    tzdata && apt-get upgrade -y && apt-get clean
RUN apt-get install python3
RUN ln -s /usr/bin/python3 /usr/bin/python

# 必要なパッケージのアップデート
RUN pip3 install --upgrade pip

# poetryインストール
RUN pip install poetry \
    && poetry config virtualenvs.create false
COPY ./app/${PROJECT_NAME}/pyproject.toml ./app/${PROJECT_NAME}/poetry.lock* ./
RUN poetry install

CMD ["/bin/bash"]