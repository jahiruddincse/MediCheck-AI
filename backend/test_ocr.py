"""
MediCheck AI - OCR Test Script
Phase 3: Quick test to verify OCR works on a medicine image.

Usage:
    python test_ocr.py                    # uses default 'medicine.jpg'
    python test_ocr.py my_photo.png       # uses a specific image
"""

import sys
import os

from ocr import read_text, read_text_detailed


def main():
    # Get image path from command line or use default
    if len(sys.argv) > 1:
        image_path = sys.argv[1]
    else:
        image_path = "medicine.jpg"

    if not os.path.exists(image_path):
        print(f"❌ Image not found: {image_path}")
        print()
        print("To test OCR:")
        print("  1. Take a photo of a medicine package")
        print("  2. Copy it to the backend/ folder")
        print(f"  3. Run: python test_ocr.py <filename>")
        return

    print(f"📷 Reading text from: {image_path}")
    print("-" * 40)

    # Simple extraction
    texts = read_text(image_path)

    if not texts:
        print("⚠️  No text detected. Try a clearer photo.")
        return

    print(f"Found {len(texts)} text region(s):\n")
    for i, text in enumerate(texts, 1):
        print(f"  {i}. {text}")

    print()
    print("-" * 40)
    print("📊 Detailed results (with confidence):\n")

    # Detailed extraction
    detailed = read_text_detailed(image_path)
    for item in detailed:
        confidence_pct = item["confidence"] * 100
        print(f"  [{confidence_pct:5.1f}%] {item['text']}")

    print()
    print("✅ OCR test complete!")
    print()
    print("Next step: If this looks reasonable, we can move to")
    print("Phase 4 (YOLO) to detect specific regions on the package.")


if __name__ == "__main__":
    main()
