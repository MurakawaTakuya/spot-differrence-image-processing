# コンパイル対象のソースファイル
SOURCES = processImage.cpp 
# オブジェクトファイル
OBJECTS = $(SOURCES:.cpp=.o)
# コンパイル後の実行ファイル
BINARY = myapp

# 画像ファイル名と出力ファイル名
IMAGE1=img/image1.jpg
IMAGE2=img/image2.jpg
OUTPUT_IMAGE=img/output.jpg

# コンパイルルール
$(BINARY): $(OBJECTS)
	g++ -o $(BINARY) $(OBJECTS) -I/usr/local/include/opencv4 -L/usr/local/lib -lopencv_core -lopencv_imgcodecs -lopencv_highgui -lopencv_imgproc

# オブジェクトファイルのビルドルール
%.o: %.cpp
	g++ -c $< -o $@ -I/usr/local/include/opencv4

# 実行ターゲット
test: $(BINARY)
	./$(BINARY) $(IMAGE1) $(IMAGE2) $(OUTPUT_IMAGE)

# cleanターゲット
clean:
	rm -f $(BINARY) $(OBJECTS)
