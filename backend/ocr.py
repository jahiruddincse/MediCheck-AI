"""
MediCheck AI - OCR Module
Phase 3: Text extraction from medicine images using EasyOCR.

EasyOCR reads text from images and returns:
- Bounding box coordinates
- Detected text
- Confidence score

We extract just the text for now. Later phases will use bounding boxes
for smarter region-based extraction with YOLO.
"""

import easyocr

# Initialize the reader once (loading the model takes a few seconds)
# Using English only for now — add more languages if needed
reader = easyocr.Reader(["en"], gpu=False)


def read_text(image_path: str) -> list[str]:
    """
    Extract all readable text from an image.

    Args:
        image_path: Path to the image file.

    Returns:
        List of detected text strings.
    """
    results = reader.readtext(image_path)

    texts = []
    for bbox, text, confidence in results:
        texts.append(text)

    return texts


def read_text_detailed(image_path: str) -> list[dict]:
    """
    Extract text with full details (bounding box + confidence).

    This will be useful later when we combine YOLO regions with OCR.

    Args:
        image_path: Path to the image file.

    Returns:
        List of dicts with 'text', 'confidence', and 'bbox' keys.
    """
    results = reader.readtext(image_path)

    detailed = []
    for bbox, text, confidence in results:
        detailed.append(
            {
                "text": text,
                "confidence": round(confidence, 3),
                "bbox": bbox,
            }
        )

    return detailed
