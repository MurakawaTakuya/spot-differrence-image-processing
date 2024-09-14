# Dockerコンテナ名
CONTAINER_NAME=image_processing_with_opencv_container

# Dockerイメージ名
IMAGE_NAME=opencv_container # imageをbuildした場合

# 画像ファイル名と出力ファイル名
IMAGE1=image1.jpg
IMAGE2=image2.jpg
OUTPUT_IMAGE=output.jpg

# マウントディレクトリ名
MOUNT_DIR=/work/

# C++ソースファイル名
CPP_FILE=processImage.cpp

# C++実行ファイル名(バイナリファイル名)
EXECUTABLE=processImage

# Pythonスクリプトファイル名
PYTHON_FILE=processImage.py

# イメージをビルド
build:
	@echo . && echo Building the image...
	@docker compose -f ./docker/compose.yml build
	@echo Image built successfully.
	
build-opencv:
	@echo . && echo Building the image...
	@docker build -t opencv-image -f ./docker/opencv/Dockerfile . 
	@echo Image built successfully.

# コンテナを起動する(前回エラーでコンテナが停止していない場合に再起動する)
up:
	@echo . && echo Running the container...
	@docker compose -f ./docker/compose.yml up -d
	@echo Container started successfully.
	
# コンテナを終了する
down:
	@echo . && echo Stopping the container...
	@docker compose -f ./docker/compose.yml down
	@echo Container stopped successfully.
	
exec:
	@echo . && echo Executing the container...
	@docker compose -f ./docker/compose.yml exec $(IMAGE_NAME) bash
	@echo Container executed successfully.

# C++プログラムをコンパイルする
cpp-compile:
	@echo . && echo Compiling cpp program...
	@docker compose -f ./docker/compose.yml exec $(IMAGE_NAME) bash -c "g++ -o $(EXECUTABLE) $(CPP_FILE) -I/usr/local/include/opencv4 -L/usr/local/lib -lopencv_core -lopencv_imgcodecs -lopencv_highgui -lopencv_imgproc"
	@echo Program compiled successfully.

# C++プログラムを実行する
run-cpp:
	@echo . && echo Running cpp program...
	@docker compose -f ./docker/compose.yml exec $(IMAGE_NAME) bash -c "LD_LIBRARY_PATH=/usr/local/lib $(MOUNT_DIR)$(EXECUTABLE) $(IMAGE1) $(IMAGE2) $(OUTPUT_IMAGE)"
	@echo Program finished.

# Pythonスクリプトを実行する
run-python:
	@echo . && echo Running python script...
	@docker compose exec -f ./docker/compose.yml $(IMAGE_NAME) bash -c "PYTHONIOENCODING=utf-8 python3 $(PYTHON_FILE) $(IMAGE1) $(IMAGE2) $(OUTPUT_IMAGE)"
	@echo Script finished.

