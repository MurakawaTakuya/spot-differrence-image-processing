import os
import cv2
import sys

if len(sys.argv) != 4:
  print(f"Usage: {sys.argv[0]} <input_image1> <input_image2> <output_image>")
  exit()

image1_path = sys.argv[1]
image2_path = sys.argv[2]
output_path = sys.argv[3]

img1 = cv2.imread(image1_path, cv2.IMREAD_GRAYSCALE)
img2 = cv2.imread(image2_path, cv2.IMREAD_GRAYSCALE)

if img1 is None or img2 is None:
  print("Cannot read image file.")
  exit()

# ファイルの縦横の画素数が異なる場合の処理
# if img1.shape != img2.shape:
#     print("Error: The sizes of the two images do not match.")
#     exit()
if img1.shape != img2.shape:
  img2 = cv2.resize(img2, (img1.shape[1], img1.shape[0]))

# 差分画像を計算
diff = cv2.absdiff(img1, img2)

# 差分画像を閾値処理 (見やすくするため)
_, thresh = cv2.threshold(diff, 10, 255, cv2.THRESH_BINARY)

# 差分画像を保存
cv2.imwrite(output_path, thresh)

print(f"Image processing is successfully done. Output image is saved as '{output_path}'.")
