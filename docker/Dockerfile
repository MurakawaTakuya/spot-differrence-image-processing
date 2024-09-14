# Dockerfile for your application
FROM opencv-image

# PythonやC++のプログラムを追加する
COPY . /app
WORKDIR /app

# 必要な追加パッケージをインストール
RUN apt-get update && apt-get install -y python3-opencv
