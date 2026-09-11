import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'my_medications_screen.dart';
import 'scan_history_screen.dart';
import 'about_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile & Settings'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // User Header Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [AppColors.primaryBlue, AppColors.tealAccent],
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Text('AM', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Alex Morgan', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.slate900)),
                        SizedBox(height: 2),
                        Text('User ID: MC-2026-8819', style: TextStyle(fontSize: 12, color: AppColors.slate500)),
                        SizedBox(height: 2),
                        Text('3 Saved Medications in Profile', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.tealDark)),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 14),

            // Settings Options
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.medication_rounded, color: AppColors.tealDark),
                    title: const Text('Medication Profile', style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600)),
                    subtitle: const Text('Manage your saved active prescriptions', style: TextStyle(fontSize: 11)),
                    trailing: const Icon(Icons.chevron_right, color: AppColors.slate400),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const MyMedicationsScreen()));
                    },
                  ),
                  const Divider(height: 1, indent: 56),
                  ListTile(
                    leading: const Icon(Icons.history_rounded, color: Colors.indigo),
                    title: const Text('Scan History', style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600)),
                    subtitle: const Text('Previous package verification reports', style: TextStyle(fontSize: 11)),
                    trailing: const Icon(Icons.chevron_right, color: AppColors.slate400),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const ScanHistoryScreen()));
                    },
                  ),
                  const Divider(height: 1, indent: 56),
                  ListTile(
                    leading: const Icon(Icons.privacy_tip_outlined, color: AppColors.primaryBlue),
                    title: const Text('Privacy & Local Storage', style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600)),
                    subtitle: const Text('All scanned photos processed securely', style: TextStyle(fontSize: 11)),
                    trailing: const Icon(Icons.chevron_right, color: AppColors.slate400),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('On-device privacy mode enabled')),
                      );
                    },
                  ),
                  const Divider(height: 1, indent: 56),
                  ListTile(
                    leading: const Icon(Icons.info_outline_rounded, color: AppColors.primaryBlue),
                    title: const Text('About MediCheck AI', style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600)),
                    subtitle: const Text('System architecture & project details', style: TextStyle(fontSize: 11)),
                    trailing: const Icon(Icons.chevron_right, color: AppColors.slate400),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const AboutScreen()));
                    },
                  ),
                  const Divider(height: 1, indent: 56),
                  ListTile(
                    leading: const Icon(Icons.gavel_rounded, color: AppColors.attentionAmber),
                    title: const Text('Disclaimer & Decision Support', style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600)),
                    subtitle: const Text('Mandatory informational guidance notice', style: TextStyle(fontSize: 11)),
                    trailing: const Icon(Icons.chevron_right, color: AppColors.slate400),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const AboutScreen()));
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // AI/ML Exhibition Note
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.slate100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                children: [
                  Text(
                    'MediCheck AI • Decision-Support Platform v1.0',
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.slate700),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Reference DB v2026.09 • Fine-tuned YOLOv8 • EasyOCR v1.7 • FastAPI',
                    style: TextStyle(fontSize: 10, color: AppColors.slate500),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
