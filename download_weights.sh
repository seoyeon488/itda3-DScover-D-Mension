#!/bin/bash
# 채점 실행(오프라인) 전에 운영진이 1회 실행하는 스크립트.
# 1) YOLO 가중치를 로컬로 내려받고
# 2) RapidOCR의 det/cls/rec ONNX 모델을 한 번 초기화해서 로컬 캐시에 받아둔다.
# predict.ipynb의 Run All 도중에는 인터넷이 없어도 이미 캐시된 파일을 그대로 쓴다.
set -e

echo "[1/2] YOLO 가중치(best.pt) 다운로드..."
mkdir -p weights
python -m gdown 1Ew2bVBjtRLr1eI0ZYEjKiZza4OI73EM8 -O weights/best.pt

echo "[2/2] RapidOCR 모델 캐시 다운로드..."
python -c "
from rapidocr import RapidOCR, LangRec
RapidOCR(params={'Rec.lang_type': LangRec.KOREAN})
RapidOCR(params={'Rec.lang_type': LangRec.EN})
print('RapidOCR 모델 캐시 완료')
"

echo "가중치 다운로드 완료"
