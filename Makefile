# Dockerコンテナ名
CONTAINER_NAME=image_processing_with_opencv_container

# Dockerイメージ名
IMAGE_NAME=opencv_container # imageをbuildした場合

# マウントディレクトリ名
MOUNT_DIR=/work/

# Pythonスクリプトファイル名
PYTHON_FILE=processImage.py

# ベースイメージをビルド
build-opencv:
	@echo . && echo Building the image...
	@docker build -t opencv-image -f ./opencv/Dockerfile . 
	@echo Image built successfully.

# イメージをビルド
build:
	@echo . && echo Building the image...
	@docker compose build
	@echo Image built successfully.

# コンテナを起動する(前回エラーでコンテナが停止していない場合に再起動する)
up:
	@echo . && echo Running the container...
	@docker compose up -d
	@echo Container started successfully.
	
# コンテナを終了する
down:
	@echo . && echo Stopping the container...
	@docker compose up -d
	@echo Container stopped successfully.
	
# コンテナ内でbashを実行する
exec:
	@echo . && echo Executing the container...
	@docker compose exec $(IMAGE_NAME) bash
	@echo Container executed successfully.

# C++プログラムを実行する
run-cpp:
	@echo . && echo Running cpp program...
	@docker compose exec $(IMAGE_NAME) bash -c "make test"
	@echo Program finished.

# Pythonスクリプトを実行する
run-python:
	@echo . && echo Running python script...
	@docker compose exec $(IMAGE_NAME) bash -c "PYTHONIOENCODING=utf-8 python3 $(PYTHON_FILE) $(IMAGE1) $(IMAGE2) $(OUTPUT_IMAGE)"
	@echo Script finished.

