import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/advisory_banner.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About & Disclaimer'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Mandatory Disclaimer Box
            const AdvisoryBanner(
              title: 'Mandatory Medical & Legal Disclaimer',
              message:
                  '“MediCheck AI provides informational decision support based on extracted package information and available reference data. It does not diagnose, prescribe, or prove medicine authenticity. Always consult a qualified healthcare professional for medical decisions.”',
              type: AdvisoryType.attention,
            ),
            const SizedBox(height: 14),

            // Project Mission Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Project Mission', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.slate900)),
                    SizedBox(height: 8),
                    Text(
                      'MediCheck AI was engineered as an AI-assisted medicine verification and medication-safety support platform for university AI/ML exhibition and demonstration.\n\nIt automates the tedious task of reading small medicine packaging labels and cross-references them against reference catalogues, while proactively checking personal medication profiles for potential duplicate dosing.',
                      style: TextStyle(fontSize: 12, color: AppColors.slate600, height: 1.45),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 14),

            // Complete Technical Architecture Flow
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Complete Technical Architecture Flow', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.slate900)),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppColors.slate900,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        '📱 Flutter Mobile App\n'
                        '   ↓ (Medicine Image)\n'
                        '⚡ FastAPI Backend\n'
                        '   ↓\n'
                        '🖼️ OpenCV Image Preprocessing\n'
                        '   ↓\n'
                        '🎯 YOLO Region Detection\n'
                        '   ↓\n'
                        '📝 EasyOCR Text Extraction\n'
                        '   ↓\n'
                        '🧠 AI/NLP Field Structuring\n'
                        '   ↓\n'
                        '🗄️ Reference Medicine Database\n'
                        '   ↓\n'
                        '🔍 Verification Engine\n'
                        '   ↓\n'
                        '🛡️ Medication Safety Engine\n'
                        '   ↓\n'
                        '📦 JSON Response\n'
                        '   ↓\n'
                        '📱 Flutter Result Screen',
                        style: TextStyle(
                          color: Color(0xFFE2E8F0),
                          fontFamily: 'monospace',
                          fontSize: 11.5,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Back to Dashboard'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
