import 'package:flutter/material.dart';
import '../models/medicine.dart';
import '../theme/app_theme.dart';
import 'verification_result_screen.dart';

class ScanHistoryScreen extends StatelessWidget {
  const ScanHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> historyItems = [
      {
        'medicine': Medicine.sampleGlycomet(),
        'date': 'Today, 11:42 AM',
        'status': 'Attention Required',
        'isAttention': true,
        'ratio': '4/5 Checks Matched',
      },
      {
        'medicine': Medicine(
          name: 'Dolo 650',
          activeIngredient: 'Paracetamol',
          strength: '650 mg',
          dosageForm: 'Tablet',
          manufacturer: 'Micro Labs Limited',
          batchNumber: 'DL73921',
          mfgDate: '01/2025',
          expDate: '12/2027',
          mrp: '₹34.15',
        ),
        'date': '08 Sep 2026, 04:15 PM',
        'status': 'Consistent Info',
        'isAttention': false,
        'ratio': '5/5 Checks Matched',
      },
      {
        'medicine': Medicine(
          name: 'Augmentin 625 Duo',
          activeIngredient: 'Amoxicillin + Clavulanic Acid',
          strength: '500 mg + 125 mg',
          dosageForm: 'Film-Coated Tablet',
          manufacturer: 'GlaxoSmithKline Pharmaceuticals',
          batchNumber: 'AG4401',
          mfgDate: '03/2025',
          expDate: '02/2027',
          mrp: '₹204.50',
        ),
        'date': '28 Aug 2026, 09:30 AM',
        'status': 'Consistent Info',
        'isAttention': false,
        'ratio': '5/5 Checks Matched',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan History'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: historyItems.length,
        itemBuilder: (context, index) {
          final item = historyItems[index];
          final Medicine med = item['medicine'];
          final bool isAttention = item['isAttention'];

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => VerificationResultScreen(medicine: med),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: isAttention ? AppColors.attentionBg : AppColors.successBg,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        isAttention ? Icons.warning_amber_rounded : Icons.verified_outlined,
                        color: isAttention ? AppColors.attentionAmber : AppColors.successGreen,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            med.name,
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.slate900),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Active: ${med.activeIngredient}',
                            style: const TextStyle(fontSize: 11.5, color: AppColors.slate600),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Batch: ${med.batchNumber} • ${item['date']}',
                            style: const TextStyle(fontSize: 10.5, color: AppColors.slate400),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: isAttention ? AppColors.attentionBg : AppColors.successBg,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: isAttention ? AppColors.attentionBorder : AppColors.successBorder,
                            ),
                          ),
                          child: Text(
                            item['status'],
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: isAttention ? const Color(0xFFB45309) : const Color(0xFF065F46),
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item['ratio'],
                          style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.w600, color: AppColors.slate500),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
