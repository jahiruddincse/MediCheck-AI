import 'package:flutter/material.dart';
import '../models/medication.dart';
import '../theme/app_theme.dart';
import '../widgets/advisory_banner.dart';

class MyMedicationsScreen extends StatefulWidget {
  const MyMedicationsScreen({Key? key}) : super(key: key);

  @override
  State<MyMedicationsScreen> createState() => _MyMedicationsScreenState();
}

class _MyMedicationsScreenState extends State<MyMedicationsScreen> {
  final List<Medication> _medications = [
    Medication(
      id: '1',
      name: 'Metformin 500 mg',
      activeIngredient: 'Metformin Hydrochloride',
      strength: '500 mg',
      dosage: '1 tablet twice daily after meals',
      purpose: 'Blood sugar control',
      addedDate: '12 May 2026',
    ),
    Medication(
      id: '2',
      name: 'Paracetamol 650 mg',
      activeIngredient: 'Paracetamol',
      strength: '650 mg',
      dosage: 'As needed for fever/mild pain',
      purpose: 'Analgesic / Antipyretic',
      addedDate: '20 Jun 2026',
    ),
    Medication(
      id: '3',
      name: 'Atorvastatin 10 mg',
      activeIngredient: 'Atorvastatin',
      strength: '10 mg',
      dosage: '1 tablet at bedtime',
      purpose: 'Lipid management',
      addedDate: '04 Jul 2026',
    ),
  ];

  void _showAddMedicationDialog() {
    final nameCtrl = TextEditingController();
    final ingredientCtrl = TextEditingController();
    final strengthCtrl = TextEditingController();
    final dosageCtrl = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
            left: 20,
            right: 20,
            top: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Add Medication', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(ctx),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              TextField(
                controller: nameCtrl,
                decoration: const InputDecoration(labelText: 'Medicine Name (Brand)'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: ingredientCtrl,
                decoration: const InputDecoration(labelText: 'Active Ingredient'),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: strengthCtrl,
                      decoration: const InputDecoration(labelText: 'Strength (e.g. 500 mg)'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: dosageCtrl,
                      decoration: const InputDecoration(labelText: 'Dosage (e.g. 1x daily)'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (nameCtrl.text.isNotEmpty && ingredientCtrl.text.isNotEmpty) {
                      setState(() {
                        _medications.add(
                          Medication(
                            id: DateTime.now().millisecondsSinceEpoch.toString(),
                            name: nameCtrl.text,
                            activeIngredient: ingredientCtrl.text,
                            strength: strengthCtrl.text.isEmpty ? 'Standard' : strengthCtrl.text,
                            dosage: dosageCtrl.text.isEmpty ? 'As directed' : dosageCtrl.text,
                            purpose: 'User-entered profile entry',
                            addedDate: 'Today',
                          ),
                        );
                      });
                      Navigator.pop(ctx);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Added ${nameCtrl.text} to profile')),
                      );
                    }
                  },
                  child: const Text('Save Medication'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Medications'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline_rounded, color: AppColors.primaryBlue),
            onPressed: _showAddMedicationDialog,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AdvisoryBanner(
              title: 'Active Ingredient Cross-Reference',
              message:
                  'MediCheck AI compares newly scanned medicine packages against active ingredients in this profile to flag potential duplicate therapy.',
              type: AdvisoryType.info,
            ),
            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'CURRENT MEDICATIONS',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.slate400, letterSpacing: 0.8),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.tealLight,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${_medications.length} Saved',
                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.tealDark),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            ..._medications.map((med) {
              return Card(
                margin: const EdgeInsets.only(bottom: 10),
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.tealLight,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.medication_rounded, color: AppColors.tealDark, size: 22),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(med.name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.slate900)),
                            Text(
                              '${med.activeIngredient} • ${med.strength}',
                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.tealDark),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(Icons.schedule_rounded, size: 12, color: AppColors.slate400),
                                const SizedBox(width: 4),
                                Text(med.dosage, style: const TextStyle(fontSize: 11, color: AppColors.slate500)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline_rounded, size: 20, color: AppColors.slate400),
                        onPressed: () {
                          setState(() {
                            _medications.removeWhere((m) => m.id == med.id);
                          });
                        },
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _showAddMedicationDialog,
                icon: const Icon(Icons.add),
                label: const Text('+ Add Medication to Profile'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  side: const BorderSide(color: AppColors.primaryBlue),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
