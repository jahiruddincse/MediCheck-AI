"""
MediCheck AI - Backend
Phase 1: Basic FastAPI server
Phase 2: Image upload endpoint
Phase 3: OCR integration
"""

import os
import shutil
from fastapi import FastAPI, File, UploadFile, HTTPException
from fastapi.middleware.cors import CORSMiddleware

from ocr import read_text

app = FastAPI(
    title="MediCheck AI",
    description="Medicine verification system using AI",
    version="0.1.0",
)

# Allow Flutter app to connect
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Directory to store uploaded images
UPLOAD_DIR = "uploads"
os.makedirs(UPLOAD_DIR, exist_ok=True)


@app.get("/")
def home():
    return {"message": "MediCheck AI backend is running"}


@app.get("/health")
def health():
    return {"status": "healthy", "version": "0.1.0"}


@app.post("/scan-medicine")
async def scan_medicine(file: UploadFile = File(...)):
    """
    Upload a medicine image and extract text using OCR.

    This is Phase 3 — raw OCR extraction.
    Later phases will add YOLO detection, AI structuring, and verification.
    """

    # Validate file type
    allowed_types = ["image/jpeg", "image/png", "image/webp"]
    if file.content_type not in allowed_types:
        raise HTTPException(
            status_code=400,
            detail=f"File type '{file.content_type}' not allowed. Use JPEG, PNG, or WebP.",
        )

    # Save uploaded file
    file_path = os.path.join(UPLOAD_DIR, file.filename)
    with open(file_path, "wb") as buffer:
        shutil.copyfileobj(file.file, buffer)

    try:
        # Phase 3: Run OCR on the uploaded image
        extracted_texts = read_text(file_path)

        return {
            "status": "success",
            "filename": file.filename,
            "raw_texts": extracted_texts,
            "text_count": len(extracted_texts),
            # Future phases will add:
            # "structured_data": { ... },
            # "verification": { ... },
            # "safety_check": { ... },
        }

    except Exception as e:
        raise HTTPException(
            status_code=500,
            detail=f"Error processing image: {str(e)}",
        )
    finally:
        # Clean up uploaded file
        if os.path.exists(file_path):
            os.remove(file_path)
