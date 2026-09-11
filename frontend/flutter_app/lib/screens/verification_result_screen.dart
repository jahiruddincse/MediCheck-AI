import 'package:flutter/material.dart';
import '../models/medicine.dart';
import '../models/verification_result.dart';
import '../theme/app_theme.dart';
import '../widgets/advisory_banner.dart';
import 'medication_safety_screen.dart';
import 'chatbot_screen.dart';

class VerificationResultScreen extends StatelessWidget {
  final Medicine? medicine;
  final VerificationResult? result;

  const VerificationResultScreen({Key? key, this.medicine, this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final med = medicine ?? Medicine.sampleGlycomet();
    final verResult = result ?? VerificationResult.sampleResult();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Verification Check'),
        actions: [
          IconButton(
            icon: const Icon(Icons.smart_toy_outlined, color: AppColors.primaryBlue),
            tooltip: 'Ask AI Assistant',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => ChatbotScreen(medicine: med)));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Score Summary Card
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.attentionBg,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppColors.attentionBorder),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.warning_amber_rounded, size: 14, color: AppColors.attentionAmber),
                            const SizedBox(width: 6),
                            Text(
                              verResult.statusText,
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFB45309),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        verResult.scoreRatio,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          color: AppColors.slate900,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Product: ${med.name}',
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.slate600),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Mandatory Informational Advisory
            AdvisoryBanner(
              title: 'Attention Required',
              message: verResult.advisoryText,
              type: AdvisoryType.attention,
            ),

            const SizedBox(height: 12),

            // Checklist
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'PARAMETER CONSISTENCY CHECKS',
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.slate400, letterSpacing: 0.8),
                    ),
                    const SizedBox(height: 10),
                    ...verResult.checklist.map((item) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 22,
                              height: 22,
                              decoration: BoxDecoration(
                                color: item.isMatched ? AppColors.successBg : AppColors.attentionBg,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Icon(
                                  item.isMatched ? Icons.check : Icons.priority_high_rounded,
                                  size: 13,
                                  color: item.isMatched ? AppColors.successGreen : AppColors.attentionAmber,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.title,
                                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.slate900),
                                  ),
                                  Text(
                                    item.detail,
                                    style: TextStyle(
                                      fontSize: 11.5,
                                      color: item.isMatched ? AppColors.slate600 : const Color(0xFF92400E),
                                      fontWeight: item.isMatched ? FontWeight.normal : FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: item.isMatched ? AppColors.successBg : AppColors.attentionBg,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: item.isMatched ? AppColors.successBorder : AppColors.attentionBorder),
                              ),
                              child: Text(
                                item.isMatched ? 'Matched' : 'Attention',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: item.isMatched ? const Color(0xFF065F46) : const Color(0xFFB45309),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Navigation Actions
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => MedicationSafetyScreen(scannedMedicine: med)),
                  );
                },
                icon: const Icon(Icons.shield_outlined),
                label: const Text('Check Medication Profile Safety'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => ChatbotScreen(medicine: med)),
                  );
                },
                icon: const Icon(Icons.chat_bubble_outline_rounded),
                label: const Text('Discuss with AI Assistant'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  side: const BorderSide(color: AppColors.slate300),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
