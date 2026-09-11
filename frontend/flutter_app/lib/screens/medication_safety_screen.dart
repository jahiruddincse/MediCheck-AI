import 'package:flutter/material.dart';
import '../models/medicine.dart';
import '../theme/app_theme.dart';
import '../widgets/advisory_banner.dart';
import 'chatbot_screen.dart';

class MedicationSafetyScreen extends StatelessWidget {
  final Medicine? scannedMedicine;

  const MedicationSafetyScreen({Key? key, this.scannedMedicine}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final med = scannedMedicine ?? Medicine.sampleGlycomet();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Medication Safety Result'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Alert Header Box
            const AdvisoryBanner(
              title: 'Potential Duplicate Active Ingredient',
              message:
                  'The scanned medicine contains an active ingredient already present in your medication profile. Confirm with a doctor or pharmacist before taking both.',
              type: AdvisoryType.attention,
            ),
            const SizedBox(height: 12),

            // Active Ingredient Comparison Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'ACTIVE INGREDIENT COMPARISON',
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.slate400, letterSpacing: 0.8),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        // Scanned Medicine
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.slate50,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: AppColors.slate200),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('SCANNED MEDICINE', style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.bold, color: AppColors.slate400)),
                                const SizedBox(height: 4),
                                Text(med.name, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.slate900)),
                                const SizedBox(height: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: AppColors.attentionBg,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    med.activeIngredient,
                                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF92400E)),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text('Strength: ${med.strength}', style: const TextStyle(fontSize: 11, color: AppColors.slate600)),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        // Existing Profile Medication
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.slate50,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: AppColors.slate200),
                            ),
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('EXISTING IN PROFILE', style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.bold, color: AppColors.slate400)),
                                SizedBox(height: 4),
                                Text('Metformin 500 mg', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.slate900)),
                                SizedBox(height: 6),
                                Text(
                                  'Metformin HCl',
                                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF92400E)),
                                ),
                                SizedBox(height: 4),
                                Text('Dosage: Twice daily', style: TextStyle(fontSize: 11, color: AppColors.slate600)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 14),

            // Curated Selected Interaction Check Section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Selected Interaction Check',
                          style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.bold, color: AppColors.slate900),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE0F2FE),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text('Curated DB v2026.09', style: TextStyle(fontSize: 10, color: AppColors.primaryBlueDark, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Results are based strictly on the application’s curated reference data for documented drug pairs in your profile:',
                      style: TextStyle(fontSize: 12, color: AppColors.slate600, height: 1.4),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.slate100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('• Metformin + Atorvastatin: No severe contraindication noted in reference rules.', style: TextStyle(fontSize: 11.5, color: AppColors.slate800)),
                          SizedBox(height: 4),
                          Text('• Metformin + Paracetamol: Compatible in standard dosing guidelines.', style: TextStyle(fontSize: 11.5, color: AppColors.slate800)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      '*MediCheck AI does NOT claim that no interaction exists universally. This check is limited to selected known medication interactions in the local database. Always consult your prescribing physician.',
                      style: TextStyle(fontSize: 10.5, fontStyle: FontStyle.italic, color: AppColors.slate500, height: 1.35),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChatbotScreen(
                        medicine: med,
                        initialQuestion: 'What does duplicate active ingredient mean?',
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.help_outline_rounded),
                label: const Text('Ask AI: What does duplicate active ingredient mean?'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
