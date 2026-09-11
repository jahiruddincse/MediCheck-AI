/**
 * MediCheck AI - Mobile Prototype Logic & Interactive Simulation
 * University AI/ML Exhibition & Supervisor Demonstration Engine
 */

// Preset Medicine Catalog
const PRESET_MEDICINES = {
  glycomet: {
    id: "glycomet",
    name: "Glycomet 500 SR",
    activeIngredient: "Metformin Hydrochloride",
    strength: "500 mg",
    dosageForm: "Sustained Release Tablet",
    manufacturer: "USV Private Limited",
    batchNumber: "PCM82491",
    mfgDate: "08/2024",
    expDate: "07/2027",
    mrp: "₹45.20",
    checksMatched: "4/5",
    statusBadge: "Attention Required",
    badgeType: "attention",
    checks: [
      { name: "Medicine Name", status: "matched", detail: "Matches reference catalog (Glycomet)" },
      { name: "Strength", status: "matched", detail: "Matches registered formulation (500 mg)" },
      { name: "Manufacturer", status: "matched", detail: "Matches licensee (USV Private Limited)" },
      { name: "Expiry Date", status: "matched", detail: "Valid shelf-life format (07/2027)" },
      { name: "Batch Number", status: "attention", detail: "Batch PCM82491 not found in current reference dataset" }
    ],
    advisory: "The available product information is mostly consistent, but the batch could not be matched against the current reference dataset. This does not by itself prove the product is counterfeit. Professional review recommended.",
    pipeline: {
      opencv: "Grayscale applied -> Gaussian Blur 5x5 -> Otsu Adaptive Thresholding -> Contrast ratio +24%",
      yolo: "BBoxes detected: [Name: 0.94], [Strength: 0.91], [Batch: 0.88], [Expiry: 0.96], [Mfg: 0.85]",
      ocr: "Raw text stream: 'USV GLYCOMET 500 SR METFORMIN HCL TAB B.No.PCM82491 MFD.08/24 EXP.07/27 MRP 45.20'",
      structuring: "Regex & NER matched keys to validated pharmaceutical schema v1.2"
    }
  },
  dolo: {
    id: "dolo",
    name: "Dolo 650",
    activeIngredient: "Paracetamol",
    strength: "650 mg",
    dosageForm: "Tablet",
    manufacturer: "Micro Labs Limited",
    batchNumber: "DL73921",
    mfgDate: "01/2025",
    expDate: "12/2027",
    mrp: "₹34.15",
    checksMatched: "5/5",
    statusBadge: "Consistent Information",
    badgeType: "success",
    checks: [
      { name: "Medicine Name", status: "matched", detail: "Matches reference catalog (Dolo 650)" },
      { name: "Strength", status: "matched", detail: "Matches registered strength (650 mg)" },
      { name: "Manufacturer", status: "matched", detail: "Matches manufacturer (Micro Labs Limited)" },
      { name: "Expiry Date", status: "matched", detail: "Valid shelf-life (12/2027)" },
      { name: "Batch Number", status: "matched", detail: "Batch verified in reference registry" }
    ],
    advisory: "Extracted packaging information is consistent across all 5 verification points within our curated reference dataset.",
    pipeline: {
      opencv: "Grayscale applied -> Bilateral filter -> CLAHE Histogram Equalization",
      yolo: "BBoxes detected: [Brand: 0.98], [Dosage: 0.95], [Batch: 0.92], [Exp: 0.97]",
      ocr: "Raw text: 'DOLO 650 PARACETAMOL TABLETS IP 650mg MICRO LABS BATCH DL73921 EXP 12/2027'",
      structuring: "NER mapped Paracetamol IP, 650mg, Micro Labs into validated schema"
    }
  },
  augmentin: {
    id: "augmentin",
    name: "Augmentin 625 Duo",
    activeIngredient: "Amoxicillin + Clavulanic Acid",
    strength: "500 mg + 125 mg",
    dosageForm: "Film-Coated Tablet",
    manufacturer: "GlaxoSmithKline Pharmaceuticals",
    batchNumber: "AG4401",
    mfgDate: "03/2025",
    expDate: "02/2027",
    mrp: "₹204.50",
    checksMatched: "5/5",
    statusBadge: "Consistent Information",
    badgeType: "success",
    checks: [
      { name: "Medicine Name", status: "matched", detail: "Matches reference catalog" },
      { name: "Strength", status: "matched", detail: "Matches dual active formulation (500mg+125mg)" },
      { name: "Manufacturer", status: "matched", detail: "Matches GSK Pharmaceuticals" },
      { name: "Expiry Date", status: "matched", detail: "Valid shelf-life (02/2027)" },
      { name: "Batch Number", status: "matched", detail: "Batch AG4401 present in reference dataset" }
    ],
    advisory: "Extracted packaging information is consistent with available manufacturer reference specifications.",
    pipeline: {
      opencv: "Perspective Warp -> Denoising -> Morphological gradient text enhancement",
      yolo: "BBoxes detected: [Brand: 0.96], [Composition: 0.93], [Batch: 0.90], [Exp: 0.95]",
      ocr: "Raw text: 'AUGMENTIN 625 DUO AMOXICILLIN AND POTASSIUM CLAVULANATE GSK B.No AG4401'",
      structuring: "Multi-ingredient parser extracted Amoxicillin and Clavulanic Acid components"
    }
  }
};

// Initial User Medication Profile
let userMedications = [
  {
    id: "med_1",
    name: "Metformin 500 mg",
    activeIngredient: "Metformin Hydrochloride",
    strength: "500 mg",
    dosage: "1 tablet twice daily after meals",
    purpose: "Blood sugar management",
    addedDate: "12 May 2026"
  },
  {
    id: "med_2",
    name: "Paracetamol 650 mg",
    activeIngredient: "Paracetamol",
    strength: "650 mg",
    dosage: "As needed for fever (max 3/day)",
    purpose: "Analgesic / Antipyretic",
    addedDate: "20 June 2026"
  },
  {
    id: "med_3",
    name: "Atorvastatin 10 mg",
    activeIngredient: "Atorvastatin",
    strength: "10 mg",
    dosage: "1 tablet at bedtime",
    purpose: "Lipid management",
    addedDate: "04 July 2026"
  }
];

// Scan History Records
let scanHistoryRecords = [
  {
    id: "scan_101",
    medicineName: "Glycomet 500 SR",
    activeIngredient: "Metformin Hydrochloride",
    batch: "PCM82491",
    timestamp: "Today, 11:42 AM",
    statusText: "Attention Required",
    badgeType: "attention",
    matchedRatio: "4/5 Checks Matched",
    presetKey: "glycomet"
  },
  {
    id: "scan_102",
    medicineName: "Dolo 650",
    activeIngredient: "Paracetamol",
    batch: "DL73921",
    timestamp: "08 Sep 2026, 04:15 PM",
    statusText: "Consistent Info",
    badgeType: "success",
    matchedRatio: "5/5 Checks Matched",
    presetKey: "dolo"
  },
  {
    id: "scan_103",
    medicineName: "Augmentin 625 Duo",
    activeIngredient: "Amoxicillin + Clavulanic Acid",
    batch: "AG4401",
    timestamp: "28 Aug 2026, 09:30 AM",
    statusText: "Consistent Info",
    badgeType: "success",
    matchedRatio: "5/5 Checks Matched",
    presetKey: "augmentin"
  }
];

// Current State
let currentPresetKey = "glycomet";
let currentMedicine = JSON.parse(JSON.stringify(PRESET_MEDICINES.glycomet));
let currentScreenId = "screen-splash";

// DOM Loaded Initialization
document.addEventListener("DOMContentLoaded", () => {
  setupNavigation();
  setupPresetButtons();
  setupModals();
  setupChatbot();
  updateTimeDisplay();
  setInterval(updateTimeDisplay, 10000);

  // Render initial medications
  renderMedications();
  renderScanHistory();
  loadMedicineIntoUI(currentMedicine);
});

// Update Status Bar Time & Telemetry
function updateTimeDisplay() {
  const now = new Date();
  let hours = now.getHours();
  let minutes = now.getMinutes();
  hours = hours % 12 || 12;
  const timeStr = `${hours}:${minutes < 10 ? "0" + minutes : minutes}`;
  const el = document.getElementById("status-time");
  if (el) el.textContent = timeStr;

  // Real-time telemetry jitter (simulated FastAPI ping)
  const telemLat = document.getElementById("telem-latency");
  if (telemLat) {
    const lat = Math.floor(35 + Math.random() * 12);
    telemLat.textContent = `${lat}ms`;
  }
}

// Navigation Engine
function navigateTo(screenId) {
  // Hide all screens
  const screens = document.querySelectorAll(".screen-page");
  screens.forEach((screen) => screen.classList.remove("active"));

  // Show target screen
  const target = document.getElementById(screenId);
  if (target) {
    target.classList.add("active");
    currentScreenId = screenId;
    const viewport = document.querySelector(".screen-viewport");
    if (viewport) viewport.scrollTop = 0;
  }

  // Update Dynamic Island with Live Activity
  updateDynamicIsland(screenId);

  // Update dropdown if not already matched
  const dropdown = document.getElementById("screen-select-dropdown");
  if (dropdown && dropdown.value !== screenId) {
    dropdown.value = screenId;
  }

  // Update Stage Tabs Highlight
  updateStageTabsHighlight(screenId);

  // Update Supervisor Pills if present
  document.querySelectorAll(".pill-btn").forEach((pill) => {
    pill.classList.toggle("active", pill.getAttribute("data-screen") === screenId);
  });

  // Update Bottom Nav
  updateBottomNavHighlight(screenId);

  // Sound effect
  playAudioEffect("click");
}

// Stage Definition Mapping
const STAGE_MAPPING = {
  "screen-splash": "overview",
  "screen-home": "overview",
  "screen-scan": "vision",
  "screen-pipeline": "vision",
  "screen-processing": "vision",
  "screen-extracted": "verification",
  "screen-verification": "verification",
  "screen-medications": "safety",
  "screen-safety": "safety",
  "screen-history": "intelligence",
  "screen-chatbot": "intelligence",
  "screen-profile": "intelligence",
  "screen-about": "intelligence"
};

function updateStageTabsHighlight(screenId) {
  const currentStage = STAGE_MAPPING[screenId] || "overview";
  document.querySelectorAll(".stage-tab").forEach(tab => {
    tab.classList.toggle("active", tab.getAttribute("data-stage") === currentStage);
  });
}

function jumpToStage(stageKey) {
  const stageEntryMap = {
    overview: "screen-home",
    vision: "screen-scan",
    verification: "screen-verification",
    safety: "screen-safety",
    intelligence: "screen-chatbot"
  };
  const targetScreen = stageEntryMap[stageKey] || "screen-home";
  navigateTo(targetScreen);
}

// Dynamic Island Live Activity Engine
function updateDynamicIsland(screenId) {
  const island = document.getElementById("dynamic-island");
  const islandText = document.getElementById("island-text");
  if (!island || !islandText) return;

  if (screenId === "screen-scan") {
    island.classList.add("expanded");
    islandText.textContent = "📷 Camera Viewfinder";
  } else if (screenId === "screen-processing") {
    island.classList.add("expanded");
    islandText.textContent = "⚡ Radar: Processing OCR...";
  } else if (screenId === "screen-extracted") {
    island.classList.add("expanded");
    islandText.textContent = "📝 Reviewing Extracted Fields";
  } else if (screenId === "screen-verification") {
    island.classList.add("expanded");
    islandText.textContent = "⚠️ Verification: 4/5 Checks";
  } else if (screenId === "screen-safety") {
    island.classList.add("expanded");
    islandText.textContent = "🛡️ Safety: Duplicate Metformin";
  } else if (screenId === "screen-chatbot") {
    island.classList.add("expanded");
    islandText.textContent = "🤖 MediCheck AI Assistant";
  } else {
    island.classList.remove("expanded");
    islandText.textContent = "MediCheck Active";
  }
}

function updateBottomNavHighlight(screenId) {
  document.querySelectorAll(".nav-item").forEach((item) => item.classList.remove("active"));

  if (screenId === "screen-home") {
    document.getElementById("nav-home")?.classList.add("active");
  } else if (screenId === "screen-scan" || screenId === "screen-pipeline" || screenId === "screen-processing") {
    document.getElementById("nav-scan")?.classList.add("active");
  } else if (screenId === "screen-medications") {
    document.getElementById("nav-meds")?.classList.add("active");
  } else if (screenId === "screen-history") {
    document.getElementById("nav-history")?.classList.add("active");
  } else if (screenId === "screen-profile" || screenId === "screen-about") {
    document.getElementById("nav-profile")?.classList.add("active");
  }
}

// Setup Nav Buttons
function setupNavigation() {
  // Presentation Pills
  document.querySelectorAll(".pill-btn").forEach((btn) => {
    btn.addEventListener("click", () => {
      const screenId = btn.getAttribute("data-screen");
      if (screenId) navigateTo(screenId);
    });
  });

  // Bottom Navigation
  document.getElementById("nav-home")?.addEventListener("click", () => navigateTo("screen-home"));
  document.getElementById("nav-scan")?.addEventListener("click", () => navigateTo("screen-scan"));
  document.getElementById("nav-meds")?.addEventListener("click", () => navigateTo("screen-medications"));
  document.getElementById("nav-history")?.addEventListener("click", () => navigateTo("screen-history"));
  document.getElementById("nav-profile")?.addEventListener("click", () => navigateTo("screen-profile"));
}

// Preset Selector
function setupPresetButtons() {
  document.querySelectorAll(".preset-btn").forEach((btn) => {
    btn.addEventListener("click", () => {
      document.querySelectorAll(".preset-btn").forEach((b) => b.classList.remove("active"));
      btn.classList.add("active");
      const key = btn.getAttribute("data-preset");
      if (PRESET_MEDICINES[key]) {
        currentPresetKey = key;
        currentMedicine = JSON.parse(JSON.stringify(PRESET_MEDICINES[key]));
        loadMedicineIntoUI(currentMedicine);
        showToast(`Loaded Preset: ${currentMedicine.name}`);
      }
    });
  });
}

// Load Medicine into UI
function loadMedicineIntoUI(med) {
  // Viewfinder Mockup
  const nameBox = document.getElementById("vf-med-name");
  const ingBox = document.getElementById("vf-med-ing");
  const batchBox = document.getElementById("vf-med-batch");
  const expBox = document.getElementById("vf-med-exp");
  const mfgBox = document.getElementById("vf-med-mfg");

  if (nameBox) nameBox.textContent = med.name.toUpperCase();
  if (ingBox) ingBox.textContent = med.activeIngredient;
  if (batchBox) batchBox.textContent = `B.No: ${med.batchNumber}`;
  if (expBox) expBox.textContent = `EXP: ${med.expDate}`;
  if (mfgBox) mfgBox.textContent = med.manufacturer;

  // Pipeline Details
  document.getElementById("pipe-opencv-detail").textContent = med.pipeline.opencv;
  document.getElementById("pipe-yolo-detail").textContent = med.pipeline.yolo;
  document.getElementById("pipe-ocr-detail").textContent = med.pipeline.ocr;
  document.getElementById("pipe-nlp-detail").textContent = med.pipeline.structuring;

  // Extracted Info Screen fields
  document.getElementById("field-name").value = med.name;
  document.getElementById("field-ingredient").value = med.activeIngredient;
  document.getElementById("field-strength").value = med.strength;
  document.getElementById("field-dosage").value = med.dosageForm;
  document.getElementById("field-manufacturer").value = med.manufacturer;
  document.getElementById("field-batch").value = med.batchNumber;
  document.getElementById("field-mfgdate").value = med.mfgDate;
  document.getElementById("field-expdate").value = med.expDate;
  document.getElementById("field-mrp").value = med.mrp;

  // Verification Screen
  document.getElementById("verify-score-badge").textContent = `${med.checksMatched} Checks Matched`;
  document.getElementById("verify-status-text").textContent = med.statusBadge;
  document.getElementById("verify-advisory-text").textContent = med.advisory;

  const statusBadge = document.getElementById("verify-status-badge");
  if (med.badgeType === "attention") {
    statusBadge.className = "badge badge-attention";
    statusBadge.innerHTML = `<svg width="12" height="12" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M10.29 3.86L1.82 18a2 2 0 0 0 1.71 3h16.94a2 2 0 0 0 1.71-3L13.71 3.86a2 2 0 0 0-3.42 0zM12 9v4m0 4h.01"></path></svg> Attention Required`;
  } else {
    statusBadge.className = "badge badge-success";
    statusBadge.innerHTML = `<svg width="12" height="12" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M20 6L9 17l-5-5"></path></svg> Consistent Information`;
  }

  // Render Verification Checklist
  const checkListContainer = document.getElementById("verify-checklist");
  if (checkListContainer) {
    checkListContainer.innerHTML = "";
    med.checks.forEach((chk) => {
      const item = document.createElement("div");
      item.className = "flex items-start justify-between py-2 border-b border-slate-100 last:border-none";
      const isMatched = chk.status === "matched";
      item.innerHTML = `
        <div class="flex items-start gap-2.5">
          <div class="w-5 h-5 rounded-full flex items-center justify-center flex-shrink-0 mt-0.5 ${
            isMatched ? "bg-emerald-100 text-emerald-600" : "bg-amber-100 text-amber-600"
          }">
            ${
              isMatched
                ? '<svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3"><polyline points="20 6 9 17 4 12"></polyline></svg>'
                : '<svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M12 9v4m0 4h.01"></path></svg>'
            }
          </div>
          <div>
            <div class="text-[13px] font-semibold text-slate-800">${chk.name}</div>
            <div class="text-[11.5px] ${isMatched ? "text-slate-500" : "text-amber-800 font-medium"}">${chk.detail}</div>
          </div>
        </div>
        <span class="text-[11px] font-bold px-2 py-0.5 rounded ${
          isMatched ? "bg-emerald-50 text-emerald-700" : "bg-amber-50 text-amber-700 border border-amber-200"
        }">
          ${isMatched ? "Matched" : "Attention"}
        </span>
      `;
      checkListContainer.appendChild(item);
    });
  }

  // Medication Safety Check Update
  updateMedicationSafetyScreen(med);
}

// Medication Safety Check logic
function updateMedicationSafetyScreen(scannedMed) {
  // Check duplicate active ingredient in user profile
  const scannedActiveLower = scannedMed.activeIngredient.toLowerCase();
  const matchedExisting = userMedications.find(m => {
    const existingLower = m.activeIngredient.toLowerCase();
    return scannedActiveLower.includes(existingLower) || existingLower.includes(scannedActiveLower);
  });

  const duplicateContainer = document.getElementById("safety-duplicate-card");
  if (duplicateContainer) {
    if (matchedExisting) {
      duplicateContainer.innerHTML = `
        <div class="alert-box alert-attention" style="margin: 0 0 12px 0;">
          <svg width="18" height="18" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M10.29 3.86L1.82 18a2 2 0 0 0 1.71 3h16.94a2 2 0 0 0 1.71-3L13.71 3.86a2 2 0 0 0-3.42 0zM12 9v4m0 4h.01"></path></svg>
          <div>
            <div class="font-bold text-[13px] text-amber-900">Potential Duplicate Active Ingredient</div>
            <div class="text-[12px] text-amber-800 mt-1">
              The scanned medicine contains an active ingredient already present in your medication profile. Confirm with a doctor or pharmacist before taking both.
            </div>
          </div>
        </div>

        <div class="grid grid-cols-2 gap-2 bg-slate-50 p-3 rounded-xl border border-slate-200 text-[12px]">
          <div class="border-r border-slate-200 pr-2">
            <span class="text-[10px] uppercase font-bold text-slate-400 block mb-0.5">Scanned Medicine</span>
            <strong class="text-slate-900 block text-[13px]">${scannedMed.name}</strong>
            <span class="text-amber-700 font-semibold mt-1 block">Active: ${scannedMed.activeIngredient}</span>
            <span class="text-slate-500">Strength: ${scannedMed.strength}</span>
          </div>
          <div class="pl-2">
            <span class="text-[10px] uppercase font-bold text-slate-400 block mb-0.5">Existing Profile</span>
            <strong class="text-slate-900 block text-[13px]">${matchedExisting.name}</strong>
            <span class="text-amber-700 font-semibold mt-1 block">Active: ${matchedExisting.activeIngredient}</span>
            <span class="text-slate-500">Dosage: ${matchedExisting.dosage}</span>
          </div>
        </div>
      `;
    } else {
      duplicateContainer.innerHTML = `
        <div class="alert-box alert-success" style="margin: 0 0 12px 0;">
          <svg width="18" height="18" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><polyline points="20 6 9 17 4 12"></polyline></svg>
          <div>
            <div class="font-bold text-[13px] text-emerald-900">No Duplicate Active Ingredient Found</div>
            <div class="text-[12px] text-emerald-800 mt-0.5">
              ${scannedMed.activeIngredient} does not directly match existing active ingredients in your saved medication profile.
            </div>
          </div>
        </div>
      `;
    }
  }

  // Curated Interaction Check section
  const interactionNotice = document.getElementById("safety-interaction-detail");
  if (interactionNotice) {
    if (scannedMed.id === "glycomet") {
      interactionNotice.innerHTML = `
        <div class="text-[12.5px] text-slate-700 leading-relaxed">
          <strong>Curated Reference Check:</strong> Evaluated against 3 active medications in your profile.
          <ul class="list-disc pl-4 mt-1.5 space-y-1 text-slate-600 text-[12px]">
            <li>With <em>Atorvastatin 10 mg</em>: No significant interaction flagged in current reference rules.</li>
            <li>With <em>Paracetamol 650 mg</em>: No documented contraindication in curated dataset.</li>
          </ul>
          <div class="mt-2 text-[11px] text-slate-500 italic">
            *Note: Checks are limited to application curated reference pairs. Does not replace professional pharmacist or physician review.
          </div>
        </div>
      `;
    } else {
      interactionNotice.innerHTML = `
        <div class="text-[12.5px] text-slate-700 leading-relaxed">
          <strong>Curated Reference Check:</strong> Evaluated against your profile medications.
          <div class="text-[12px] text-slate-600 mt-1">
            No critical interaction alerts recorded in the local reference database for this formulation combination.
          </div>
          <div class="mt-2 text-[11px] text-slate-500 italic">
            *Always consult a healthcare professional regarding potential interactions.
          </div>
        </div>
      `;
    }
  }
}

// Scanner Simulation Sequence
function startScanningSimulation() {
  navigateTo("screen-processing");

  const steps = [
    { id: "proc-step-1", delay: 300 },
    { id: "proc-step-2", delay: 700 },
    { id: "proc-step-3", delay: 1100 },
    { id: "proc-step-4", delay: 1500 },
    { id: "proc-step-5", delay: 1900 },
    { id: "proc-step-6", delay: 2300 },
    { id: "proc-step-7", delay: 2700 }
  ];

  // Reset steps
  steps.forEach(s => {
    const el = document.getElementById(s.id);
    if (el) {
      el.className = "flex items-center gap-3 text-slate-400 text-[13px]";
      el.querySelector(".step-icon").innerHTML = '<div class="w-2 h-2 rounded-full bg-slate-300"></div>';
    }
  });

  const progressBar = document.getElementById("proc-progress-bar");
  if (progressBar) progressBar.style.width = "0%";

  steps.forEach((step, index) => {
    setTimeout(() => {
      const el = document.getElementById(step.id);
      if (el) {
        el.className = "flex items-center gap-3 text-slate-800 font-medium text-[13px]";
        el.querySelector(".step-icon").innerHTML = `
          <div class="w-5 h-5 rounded-full bg-emerald-100 text-emerald-600 flex items-center justify-center">
            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3"><polyline points="20 6 9 17 4 12"></polyline></svg>
          </div>
        `;
      }
      if (progressBar) {
        const percent = Math.round(((index + 1) / steps.length) * 100);
        progressBar.style.width = `${percent}%`;
      }
    }, step.delay);
  });

  // Navigate to Extracted Info Screen on completion
  setTimeout(() => {
    navigateTo("screen-extracted");
  }, 3100);
}

// Confirm Extracted Information Handler
function confirmExtractedInfo() {
  // Update state from inputs
  currentMedicine.name = document.getElementById("field-name").value;
  currentMedicine.activeIngredient = document.getElementById("field-ingredient").value;
  currentMedicine.strength = document.getElementById("field-strength").value;
  currentMedicine.dosageForm = document.getElementById("field-dosage").value;
  currentMedicine.manufacturer = document.getElementById("field-manufacturer").value;
  currentMedicine.batchNumber = document.getElementById("field-batch").value;
  currentMedicine.mfgDate = document.getElementById("field-mfgdate").value;
  currentMedicine.expDate = document.getElementById("field-expdate").value;
  currentMedicine.mrp = document.getElementById("field-mrp").value;

  // Refresh safety calculations
  updateMedicationSafetyScreen(currentMedicine);

  // Navigate to Verification Result Screen
  navigateTo("screen-verification");
}

// Render Medications List
function renderMedications() {
  const container = document.getElementById("meds-list-container");
  if (!container) return;

  container.innerHTML = "";
  userMedications.forEach(med => {
    const card = document.createElement("div");
    card.className = "card p-3.5 mb-2.5 flex items-start justify-between";
    card.innerHTML = `
      <div>
        <div class="flex items-center gap-2">
          <h3 class="font-bold text-slate-900 text-[14px]">${med.name}</h3>
          <span class="badge badge-blue text-[10px] py-0.5 px-2">Active</span>
        </div>
        <div class="text-[12px] text-teal-700 font-medium mt-0.5">${med.activeIngredient} (${med.strength})</div>
        <div class="text-[11.5px] text-slate-500 mt-1 flex items-center gap-1.5">
          <svg width="12" height="12" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><circle cx="12" cy="12" r="10"></circle><polyline points="12 6 12 12 16 14"></polyline></svg>
          ${med.dosage}
        </div>
      </div>
      <button onclick="removeMedication('${med.id}')" class="text-slate-400 hover:text-rose-500 p-1 rounded">
        <svg width="16" height="16" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><line x1="18" y1="6" x2="6" y2="18"></line><line x1="6" y1="6" x2="18" y2="18"></line></svg>
      </button>
    `;
    container.appendChild(card);
  });

  const countBadge = document.getElementById("med-count-badge");
  if (countBadge) countBadge.textContent = `${userMedications.length} Saved`;
}

function removeMedication(id) {
  userMedications = userMedications.filter(m => m.id !== id);
  renderMedications();
  updateMedicationSafetyScreen(currentMedicine);
  showToast("Medication removed from profile");
}

function addMedicationSubmit(e) {
  e.preventDefault();
  const name = document.getElementById("new-med-name").value;
  const ingredient = document.getElementById("new-med-ingredient").value;
  const strength = document.getElementById("new-med-strength").value;
  const dosage = document.getElementById("new-med-dosage").value;

  if (!name || !ingredient) return;

  const newMed = {
    id: "med_" + Date.now(),
    name,
    activeIngredient: ingredient,
    strength: strength || "Standard",
    dosage: dosage || "As directed by physician",
    purpose: "Self-entered profile record",
    addedDate: "Just now"
  };

  userMedications.push(newMed);
  renderMedications();
  updateMedicationSafetyScreen(currentMedicine);
  closeModal("modal-add-med");
  showToast(`Added ${name} to your profile`);
  e.target.reset();
}

// Render Scan History
function renderScanHistory() {
  const container = document.getElementById("history-list-container");
  if (!container) return;

  container.innerHTML = "";
  scanHistoryRecords.forEach(rec => {
    const item = document.createElement("div");
    item.className = "card p-3.5 mb-2.5 cursor-pointer hover:border-sky-400 transition-colors";
    item.onclick = () => {
      if (PRESET_MEDICINES[rec.presetKey]) {
        currentPresetKey = rec.presetKey;
        currentMedicine = JSON.parse(JSON.stringify(PRESET_MEDICINES[rec.presetKey]));
        loadMedicineIntoUI(currentMedicine);
        navigateTo("screen-verification");
      }
    };

    const isAttn = rec.badgeType === "attention";
    item.innerHTML = `
      <div class="flex items-start justify-between">
        <div>
          <h4 class="font-bold text-slate-900 text-[13.5px]">${rec.medicineName}</h4>
          <div class="text-[12px] text-slate-500 mt-0.5">Active: ${rec.activeIngredient}</div>
          <div class="text-[11px] text-slate-400 mt-1">Batch: ${rec.batch} • ${rec.timestamp}</div>
        </div>
        <div class="text-right">
          <span class="badge ${isAttn ? "badge-attention" : "badge-success"} text-[10px]">
            ${rec.statusText}
          </span>
          <div class="text-[11px] text-slate-500 font-semibold mt-1">${rec.matchedRatio}</div>
        </div>
      </div>
    `;
    container.appendChild(item);
  });
}

// Chatbot Engine with Strict Guardrails
function setupChatbot() {
  const input = document.getElementById("chat-input");
  const sendBtn = document.getElementById("chat-send-btn");

  function handleSend() {
    const text = input.value.trim();
    if (!text) return;

    appendChatMessage(text, "user");
    input.value = "";

    // Simulated Thinking
    setTimeout(() => {
      const response = generateChatbotResponse(text, currentMedicine);
      appendChatMessage(response, "bot");
    }, 500);
  }

  sendBtn?.addEventListener("click", handleSend);
  input?.addEventListener("keypress", (e) => {
    if (e.key === "Enter") handleSend();
  });

  // Chip buttons
  document.querySelectorAll(".prompt-chip").forEach(chip => {
    chip.addEventListener("click", () => {
      const q = chip.textContent.trim();
      appendChatMessage(q, "user");
      setTimeout(() => {
        const response = generateChatbotResponse(q, currentMedicine);
        appendChatMessage(response, "bot");
      }, 500);
    });
  });
}

function appendChatMessage(text, sender) {
  const thread = document.getElementById("chat-thread");
  if (!thread) return;

  const bubble = document.createElement("div");
  bubble.className = `chat-bubble ${sender}`;
  bubble.textContent = text;
  thread.appendChild(bubble);

  thread.scrollTop = thread.scrollHeight;
}

function generateChatbotResponse(question, med) {
  const q = question.toLowerCase();

  // Guardrail 1: Prohibited medical actions (prescriptions, taking medicine, diagnosing)
  if (q.includes("can i take") || q.includes("should i take") || q.includes("cure") || q.includes("safe to drink") || q.includes("diagnose")) {
    return `As an informational decision-support tool, MediCheck AI does not prescribe medications or advise whether to take any product. Please consult your physician or licensed pharmacist for medical guidance.`;
  }

  // Guardrail 2: Fake / Genuine claims
  if (q.includes("fake") || q.includes("genuine") || q.includes("counterfeit") || q.includes("real")) {
    return `MediCheck AI does not certify medicines as 100% genuine or counterfeit. We compare printed package details with our reference dataset. An unverified batch or mismatch simply means the information is not confirmed in our current dataset, requiring professional review.`;
  }

  // Active Ingredient Question
  if (q.includes("active ingredient") || q.includes("ingredient")) {
    return `The extracted active ingredient for ${med.name} is "${med.activeIngredient}" with a strength of ${med.strength}. Active ingredients are the biologically active components responsible for the therapeutic effect.`;
  }

  // Attention Required / Batch Question
  if (q.includes("attention required") || q.includes("batch")) {
    return `The system reported "Attention Required" because batch number "${med.batchNumber}" could not be matched against our current reference dataset. This does not by itself prove the product is counterfeit; our database may not yet contain this production batch. Professional review is recommended.`;
  }

  // Duplicate Active Ingredient Question
  if (q.includes("duplicate") || q.includes("double")) {
    return `A "Potential Duplicate Active Ingredient" occurs when a scanned medicine contains the same therapeutic substance (e.g., ${med.activeIngredient}) as a drug already in your medication profile. Taking both simultaneously could lead to unintended cumulative dosing. Please confirm with your healthcare provider.`;
  }

  // Explain Scan Result
  if (q.includes("explain") || q.includes("result") || q.includes("mean")) {
    return `For ${med.name}, ${med.checksMatched} checks matched our reference standards (Name, Strength, Manufacturer, Expiry). However, ${med.statusBadge === "Attention Required" ? "batch verification requires attention" : "all package details matched the reference entry"}. Informational decision-support only.`;
  }

  // Default Informational Response
  return `MediCheck AI extracted: ${med.name}, Active Ingredient: ${med.activeIngredient}, Batch: ${med.batchNumber}, Expiry: ${med.expDate}. This system provides informational consistency checks. For personal medication guidance, always consult a healthcare professional.`;
}

// Modal management
function setupModals() {
  window.openModal = function(id) {
    document.getElementById(id)?.classList.add("open");
  };

  window.closeModal = function(id) {
    document.getElementById(id)?.classList.remove("open");
  };
}

// Toast notification
function showToast(msg) {
  const existing = document.querySelector(".toast-notification");
  if (existing) existing.remove();

  const toast = document.createElement("div");
  toast.className = "toast-notification";
  toast.style.cssText = `
    position: fixed;
    bottom: 24px;
    left: 50%;
    transform: translateX(-50%);
    background: #0f172a;
    color: #f8fafc;
    padding: 8px 16px;
    border-radius: 20px;
    font-size: 12.5px;
    font-weight: 500;
    box-shadow: 0 8px 20px rgba(0,0,0,0.3);
    z-index: 3000;
    border: 1px solid #334155;
    animation: fadeIn 0.2s ease-out;
  `;
  toast.textContent = msg;
  document.body.appendChild(toast);

  setTimeout(() => {
    toast.remove();
  }, 2200);
}

// ========================================================
// RENOVATED PRESET SWITCHER WITH DIAGNOSTIC BADGES
// ========================================================
function switchPreset(key) {
  if (!PRESET_MEDICINES[key]) return;

  currentPresetKey = key;
  currentMedicine = JSON.parse(JSON.stringify(PRESET_MEDICINES[key]));
  loadMedicineIntoUI(currentMedicine);

  // Update Preset Chip Highlight
  document.querySelectorAll(".preset-chip").forEach((chip) => {
    chip.classList.toggle("active", chip.getAttribute("data-preset") === key);
  });

  playAudioEffect("chime");
  showToast(`Loaded Preset: ${currentMedicine.name}`);
}

// ========================================================
// WEB AUDIO API SOUND SYNTHESIZER (ZERO EXTERNAL ASSETS)
// ========================================================
let audioEnabled = true;
let audioCtx = null;

function getAudioContext() {
  if (!audioCtx) {
    const AudioContextClass = window.AudioContext || window.webkitAudioContext;
    if (AudioContextClass) {
      audioCtx = new AudioContextClass();
    }
  }
  if (audioCtx && audioCtx.state === "suspended") {
    audioCtx.resume();
  }
  return audioCtx;
}

function toggleAudio() {
  audioEnabled = !audioEnabled;
  const btn = document.getElementById("btn-audio-toggle");
  if (btn) {
    btn.textContent = audioEnabled ? "🔊 Audio: ON" : "🔇 Audio: OFF";
  }
  showToast(audioEnabled ? "Synthesized Sound FX Enabled" : "Sound FX Muted");
}

function playAudioEffect(type) {
  if (!audioEnabled) return;
  try {
    const ctx = getAudioContext();
    if (!ctx) return;

    const osc = ctx.createOscillator();
    const gain = ctx.createGain();
    osc.connect(gain);
    gain.connect(ctx.destination);

    const now = ctx.currentTime;

    if (type === "click") {
      osc.type = "sine";
      osc.frequency.setValueAtTime(800, now);
      gain.gain.setValueAtTime(0.04, now);
      gain.gain.exponentialRampToValueAtTime(0.001, now + 0.04);
      osc.start(now);
      osc.stop(now + 0.04);
    } else if (type === "shutter") {
      osc.type = "triangle";
      osc.frequency.setValueAtTime(1400, now);
      osc.frequency.exponentialRampToValueAtTime(200, now + 0.12);
      gain.gain.setValueAtTime(0.12, now);
      gain.gain.exponentialRampToValueAtTime(0.001, now + 0.12);
      osc.start(now);
      osc.stop(now + 0.12);
    } else if (type === "radar") {
      osc.type = "sine";
      osc.frequency.setValueAtTime(950, now);
      gain.gain.setValueAtTime(0.06, now);
      gain.gain.exponentialRampToValueAtTime(0.001, now + 0.08);
      osc.start(now);
      osc.stop(now + 0.08);
    } else if (type === "chime") {
      osc.type = "sine";
      osc.frequency.setValueAtTime(523.25, now); // C5
      osc.frequency.setValueAtTime(659.25, now + 0.08); // E5
      gain.gain.setValueAtTime(0.08, now);
      gain.gain.exponentialRampToValueAtTime(0.001, now + 0.25);
      osc.start(now);
      osc.stop(now + 0.25);
    }
  } catch (e) {
    // Audio context not allowed before user gesture
  }
}

// ========================================================
// ZOOM SCALE CONTROLLER (FIT ON ANY SCREEN)
// ========================================================
const ZOOM_LEVELS = [
  { scale: 1.0, label: "Scale: 100%" },
  { scale: 0.9, label: "Scale: 90%" },
  { scale: 0.82, label: "Scale: 82%" }
];
let currentZoomIdx = 0;

function cycleZoom() {
  currentZoomIdx = (currentZoomIdx + 1) % ZOOM_LEVELS.length;
  const zoom = ZOOM_LEVELS[currentZoomIdx];
  const scaler = document.getElementById("phone-scaler");
  if (scaler) {
    scaler.style.transform = `scale(${zoom.scale})`;
  }
  const btn = document.getElementById("btn-zoom");
  if (btn) {
    btn.textContent = `🔍 ${zoom.label}`;
  }
  showToast(`View Zoom set to ${zoom.label}`);
}

// ========================================================
// AUTOMATED SUPERVISOR WALKTHROUGH TOUR ENGINE
// ========================================================
let isAutoTourRunning = false;
let tourTimer = null;
let currentTourStep = 0;

const AUTO_TOUR_STEPS = [
  {
    screen: "screen-home",
    text: "Step 1/6 • Welcome to MediCheck AI Dashboard & Core CTA",
    delay: 2600
  },
  {
    screen: "screen-scan",
    text: "Step 2/6 • Packaging Camera Viewfinder with AI Alignment Corners",
    delay: 3000
  },
  {
    screen: "screen-processing",
    text: "Step 3/6 • OpenCV Image Preprocessing & YOLO/EasyOCR Region Extraction",
    delay: 3200
  },
  {
    screen: "screen-extracted",
    text: "Step 4/6 • Extracted Data Card with Human-in-the-Loop Editable Fields",
    delay: 2800
  },
  {
    screen: "screen-verification",
    text: "Step 5/6 • Verification Result: 4/5 Checks Matched with Attention on Batch",
    delay: 3400
  },
  {
    screen: "screen-safety",
    text: "Step 6/6 • Active Ingredient Profile Safety: Duplicate Metformin Flag",
    delay: 3600
  },
  {
    screen: "screen-chatbot",
    text: "Tour Complete • MediCheck AI Assistant with Ethical Guardrails",
    delay: 4000
  }
];

function toggleAutoTour() {
  if (isAutoTourRunning) {
    stopAutoTour();
  } else {
    startAutoTour();
  }
}

function startAutoTour() {
  isAutoTourRunning = true;
  currentTourStep = 0;

  const btn = document.getElementById("btn-auto-tour");
  if (btn) {
    btn.innerHTML = "<span>⏹</span> Stop Tour";
    btn.className = "demo-btn primary";
  }

  const banner = document.getElementById("tour-banner");
  if (banner) banner.classList.add("active");

  showToast("Starting Automated Walkthrough Tour");
  executeTourStep();
}

function executeTourStep() {
  if (!isAutoTourRunning || currentTourStep >= AUTO_TOUR_STEPS.length) {
    stopAutoTour();
    return;
  }

  const step = AUTO_TOUR_STEPS[currentTourStep];
  navigateTo(step.screen);

  const bannerText = document.getElementById("tour-step-text");
  if (bannerText) {
    bannerText.textContent = step.text;
  }

  playAudioEffect("chime");

  tourTimer = setTimeout(() => {
    currentTourStep++;
    executeTourStep();
  }, step.delay);
}

function stopAutoTour() {
  isAutoTourRunning = false;
  if (tourTimer) clearTimeout(tourTimer);

  const btn = document.getElementById("btn-auto-tour");
  if (btn) {
    btn.innerHTML = "<span>▶</span> Auto Walkthrough";
    btn.className = "demo-btn accent";
  }

  const banner = document.getElementById("tour-banner");
  if (banner) banner.classList.remove("active");

  showToast("Auto Walkthrough Ended");
}
