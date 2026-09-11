# 🩺 MediCheck AI

> **AI-Assisted Medicine Verification & Medication-Safety Decision Support Platform**  
> *Production-Ready Mobile Application & Interactive Prototype*

---

## 📌 Project Overview

**MediCheck AI** is an AI-assisted decision-support platform designed to help users extract printed information from medicine packages using computer vision and OCR, compare it against a verified reference database, and cross-reference active ingredients against their personal medication profile to flag potential duplicate therapy and known interactions.

> [!IMPORTANT]
> **Decision-Support Notice**: MediCheck AI is an informational decision-support tool. It does **NOT** diagnose, prescribe, certify authenticity, or declare medicines as "fake" or "100% genuine". It provides consistency verification and flags attention items for professional medical review.

---

## 🏗️ Technical Pipeline & Architecture

```
📱 Flutter Mobile App (Client)
   ↓ (Medicine Image)
⚡ FastAPI Backend (Server / Orchestrator)
   ↓
🖼️ OpenCV (Image Preprocessing: Noise Filtering, Contrast Boost)
   ↓
🎯 YOLO (Object Detection: Locates Name, Strength, Batch, Expiry Bounding Boxes)
   ↓
📝 EasyOCR (Text Extraction: Reads Characters Inside Bounding Boxes)
   ↓
🧠 AI/NLP Structuring (Parses Raw Text into Structured JSON)
   ↓
🗄️ Reference Medicine Database (Controlled Dataset)
   ↓
🔍 Verification Engine (Checks Parameter Consistency)
   ↓
🛡️ Medication Safety Engine (Active Ingredient Profile Cross-Checking)
   ↓
📦 JSON Response
   ↓
📱 Flutter Result Screen (Interactive User Report)
```

---

## 📱 Mobile Screens (13 Screens Prototype)

1. **Splash Screen**: Brand identity, logo, tagline: *"Scan Smarter. Understand Better."*
2. **Home Dashboard**: Quick navigation, personalized greeting, primary *"Scan Medicine"* CTA, decision-support info banner.
3. **Scan Medicine Screen**: Camera viewfinder, guide frame, scanning laser animation, capture & upload controls, scanning tips.
4. **AI Pipeline Visualizer**: Step-by-step interactive diagram of OpenCV $\rightarrow$ YOLO $\rightarrow$ EasyOCR $\rightarrow$ NLP.
5. **Processing Screen**: Dynamic radar scanner with real-time 7-step checklist.
6. **Extracted Information Screen**: Clean data card with editable fields for human-in-the-loop correction before verification.
7. **Verification Result Screen**: *"4/5 Checks Matched"* score, *"Attention Required"* badge, batch mismatch notice, non-counterfeit disclaimer.
8. **My Medications Screen**: Saved medication profile manager with active prescriptions and interactive add form.
9. **Medication Safety Result Screen**: *"Potential Duplicate Active Ingredient"* comparison (e.g. Scanned Metformin vs Existing Metformin) + curated interaction check.
10. **Scan History Screen**: Chronological scan log with attention indicators and report reopening.
11. **MediCheck AI Assistant (Chatbot)**: Contextual decision-support explanation assistant with strict guardrails (no prescribing or diagnosing).
12. **Profile & Settings Screen**: Model version details, database info, and user preferences.
13. **About & Disclaimer Screen**: Complete legal and medical disclaimer.

---

## 🚀 Getting Started

### 1. Interactive Mobile Prototype (Web Simulator)
Run the web simulator locally to demonstrate all 13 screens in any browser:
```bash
cd frontend
./run_prototype.sh
```
Open **`http://localhost:8080`** in your browser.

### 2. Flutter Mobile Application
```bash
cd frontend/flutter_app
flutter pub get
flutter run
```

### 3. FastAPI Backend
```bash
cd backend
pip install -r requirements.txt
uvicorn main:app --reload --port 8000
```

---

## ⚖️ Disclaimer

*MediCheck AI provides informational decision support based on extracted package information and available reference data. It does not diagnose, prescribe, or prove medicine authenticity. Always consult a qualified healthcare professional for medical decisions.*
