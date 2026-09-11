import 'package:flutter/material.dart';
import '../models/medicine.dart';
import '../theme/app_theme.dart';
import '../widgets/advisory_banner.dart';
import 'verification_result_screen.dart';

class ExtractedInfoScreen extends StatefulWidget {
  final Medicine? initialMedicine;

  const ExtractedInfoScreen({Key? key, this.initialMedicine}) : super(key: key);

  @override
  State<ExtractedInfoScreen> createState() => _ExtractedInfoScreenState();
}

class _ExtractedInfoScreenState extends State<ExtractedInfoScreen> {
  late Medicine _medicine;

  late TextEditingController _nameController;
  late TextEditingController _ingredientController;
  late TextEditingController _strengthController;
  late TextEditingController _dosageController;
  late TextEditingController _mfgController;
  late TextEditingController _batchController;
  late TextEditingController _mfgDateController;
  late TextEditingController _expDateController;
  late TextEditingController _mrpController;

  @override
  void initState() {
    super.initState();
    _medicine = widget.initialMedicine ?? Medicine.sampleGlycomet();

    _nameController = TextEditingController(text: _medicine.name);
    _ingredientController = TextEditingController(text: _medicine.activeIngredient);
    _strengthController = TextEditingController(text: _medicine.strength);
    _dosageController = TextEditingController(text: _medicine.dosageForm);
    _mfgController = TextEditingController(text: _medicine.manufacturer);
    _batchController = TextEditingController(text: _medicine.batchNumber);
    _mfgDateController = TextEditingController(text: _medicine.mfgDate);
    _expDateController = TextEditingController(text: _medicine.expDate);
    _mrpController = TextEditingController(text: _medicine.mrp);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ingredientController.dispose();
    _strengthController.dispose();
    _dosageController.dispose();
    _mfgController.dispose();
    _batchController.dispose();
    _mfgDateController.dispose();
    _expDateController.dispose();
    _mrpController.dispose();
    super.dispose();
  }

  void _onConfirm() {
    // Update model with edited data
    _medicine.name = _nameController.text;
    _medicine.activeIngredient = _ingredientController.text;
    _medicine.strength = _strengthController.text;
    _medicine.dosageForm = _dosageController.text;
    _medicine.manufacturer = _mfgController.text;
    _medicine.batchNumber = _batchController.text;
    _medicine.mfgDate = _mfgDateController.text;
    _medicine.expDate = _expDateController.text;
    _medicine.mrp = _mrpController.text;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => VerificationResultScreen(medicine: _medicine),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Extracted Medicine Data'),
        actions: [
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('All fields are editable')),
              );
            },
            child: const Text('Edit Mode', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AdvisoryBanner(
              title: 'Review Extracted Information',
              message:
                  'Please verify the extracted information below. You may edit any field before running verification checks against the reference dataset.',
              type: AdvisoryType.info,
            ),
            const SizedBox(height: 12),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildInputField('Medicine Name', _nameController, isHighlight: true),
                    const SizedBox(height: 12),
                    _buildInputField('Active Ingredient', _ingredientController, isHighlight: true),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(child: _buildInputField('Strength', _strengthController)),
                        const SizedBox(width: 12),
                        Expanded(child: _buildInputField('Dosage Form', _dosageController)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _buildInputField('Manufacturer', _mfgController),
                    const SizedBox(height: 12),
                    _buildInputField('Batch Number', _batchController, isAttentionTarget: true),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(child: _buildInputField('Mfg Date', _mfgDateController)),
                        const SizedBox(width: 8),
                        Expanded(child: _buildInputField('Expiry Date', _expDateController)),
                        const SizedBox(width: 8),
                        Expanded(child: _buildInputField('MRP', _mrpController)),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _onConfirm,
                icon: const Icon(Icons.check_circle_outline_rounded),
                label: const Text('Confirm Information & Run Verification'),
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

  Widget _buildInputField(String label, TextEditingController controller, {bool isHighlight = false, bool isAttentionTarget = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.slate400, letterSpacing: 0.5),
        ),
        const SizedBox(height: 4),
        TextField(
          controller: controller,
          style: TextStyle(
            fontSize: 13,
            fontWeight: isHighlight || isAttentionTarget ? FontWeight.bold : FontWeight.w500,
            color: isAttentionTarget ? const Color(0xFFB45309) : AppColors.slate900,
          ),
          decoration: InputDecoration(
            isDense: true,
            fillColor: isAttentionTarget ? AppColors.attentionBg.withOpacity(0.5) : AppColors.slate50,
          ),
        ),
      ],
    );
  }
}
