import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'processing_screen.dart';

class PipelineScreen extends StatelessWidget {
  const PipelineScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Vision & OCR Pipeline'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Technical Image Processing Flow',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.slate900),
            ),
            const SizedBox(height: 4),
            const Text(
              'MediCheck AI couples specialized computer vision models with OCR and NLP extraction for accurate packaging reading.',
              style: TextStyle(fontSize: 12.5, color: AppColors.slate600),
            ),
            const SizedBox(height: 16),

            _buildPipelineStep(
              stepNumber: '1',
              title: 'Camera Image',
              badge: 'Raw Input',
              badgeBg: AppColors.slate100,
              badgeColor: AppColors.slate700,
              icon: Icons.camera_alt_rounded,
              iconBg: AppColors.slate800,
              explanation: 'High resolution package photo captured from the user mobile phone.',
            ),

            _buildArrow(),

            _buildPipelineStep(
              stepNumber: '2',
              title: 'OpenCV Preprocessing',
              badge: 'Image Enhancer',
              badgeBg: const Color(0xFFE0F2FE),
              badgeColor: AppColors.primaryBlueDark,
              icon: Icons.auto_fix_high_rounded,
              iconBg: AppColors.primaryBlue,
              explanation: 'Image preprocessing: Grayscale conversion, Otsu thresholding, bilateral noise reduction, and contrast enhancement.',
              codeSnippet: 'cv2.cvtColor -> cv2.GaussianBlur(5,5) -> CLAHE contrast boost',
            ),

            _buildArrow(),

            _buildPipelineStep(
              stepNumber: '3',
              title: 'YOLO Region Detection',
              badge: 'WHERE to look',
              badgeBg: AppColors.tealLight,
              badgeColor: AppColors.tealDark,
              icon: Icons.crop_free_rounded,
              iconBg: AppColors.tealAccent,
              explanation: 'Object detection model fine-tuned on medicine packaging. Locates WHERE important regions are: Name, Batch, Expiry, Manufacturer.',
              codeSnippet: 'YOLOv8-Medicine: BBoxes detected [Brand: 0.94], [Batch: 0.88], [Exp: 0.96]',
            ),

            _buildArrow(),

            _buildPipelineStep(
              stepNumber: '4',
              title: 'EasyOCR Text Extraction',
              badge: 'WHAT it says',
              badgeBg: const Color(0xFFEDE9FE),
              badgeColor: const Color(0xFF5B21B6),
              icon: Icons.text_snippet_rounded,
              iconBg: Colors.indigo,
              explanation: 'Optical Character Recognition reads printed text characters specifically inside the detected YOLO bounding boxes.',
              codeSnippet: 'EasyOCR: "USV GLYCOMET 500 SR METFORMIN BATCH PCM82491 EXP 07/2027"',
            ),

            _buildArrow(),

            _buildPipelineStep(
              stepNumber: '5',
              title: 'AI/NLP Structuring',
              badge: 'Structured Schema',
              badgeBg: AppColors.successBg,
              badgeColor: AppColors.successGreen,
              icon: Icons.account_tree_rounded,
              iconBg: AppColors.successGreen,
              explanation: 'Structures raw text tokens into a standardized medicine JSON object for database lookup.',
              codeSnippet: 'JSON: {"name": "Glycomet", "batch": "PCM82491", "active": "Metformin"}',
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const ProcessingScreen()),
                  );
                },
                icon: const Icon(Icons.play_arrow_rounded),
                label: const Text('Run Processing Simulation'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildArrow() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4.0),
        child: Icon(Icons.arrow_downward_rounded, size: 20, color: AppColors.slate400),
      ),
    );
  }

  Widget _buildPipelineStep({
    required String stepNumber,
    required String title,
    required String badge,
    required Color badgeBg,
    required Color badgeColor,
    required IconData icon,
    required Color iconBg,
    required String explanation,
    String? codeSnippet,
  }) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: iconBg,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: Colors.white, size: 20),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$stepNumber. $title',
                        style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.bold, color: AppColors.slate900),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 2),
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: badgeBg,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          badge,
                          style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.bold, color: badgeColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              explanation,
              style: const TextStyle(fontSize: 12, color: AppColors.slate600, height: 1.4),
            ),
            if (codeSnippet != null) ...[
              const SizedBox(height: 6),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.slate100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  codeSnippet,
                  style: const TextStyle(fontSize: 10, fontFamily: 'monospace', color: AppColors.slate800),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
