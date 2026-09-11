import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/advisory_banner.dart';
import '../widgets/bottom_nav_bar.dart';
import 'scan_screen.dart';
import 'my_medications_screen.dart';
import 'scan_history_screen.dart';
import 'chatbot_screen.dart';
import 'profile_screen.dart';
import 'verification_result_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentNavIndex = 0;

  void _onNavTap(int index) {
    if (index == 0) return; // Already on Home
    if (index == 1) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const ScanHistoryScreen()));
    } else if (index == 2) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const MyMedicationsScreen()));
    } else if (index == 3) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileScreen()));
    } else if (index == 4) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const ScanScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.slate50,
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primaryBlue, AppColors.tealAccent],
                ),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Text('AM', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
              ),
            ),
            const SizedBox(width: 10),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Welcome back', style: TextStyle(fontSize: 11, color: AppColors.slate400, fontWeight: FontWeight.normal)),
                Text('Alex Morgan', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.slate900)),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.chat_bubble_outline_rounded, color: AppColors.primaryBlue),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const ChatbotScreen()));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Scan Medicine Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primaryBlueDark, AppColors.primaryBlue, AppColors.tealAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryBlue.withOpacity(0.3),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'PRIMARY ACTION',
                      style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 0.8),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Verify Medicine Package',
                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Extract printed packaging information and compare with reference datasets.',
                    style: TextStyle(color: Color(0xFFE0F2FE), fontSize: 12.5),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const ScanScreen()));
                    },
                    icon: const Icon(Icons.camera_alt_rounded, color: AppColors.primaryBlueDark, size: 18),
                    label: const Text('Scan Medicine Now', style: TextStyle(color: AppColors.primaryBlueDark, fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      elevation: 1,
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Quick Actions (4-Grid)
            const Text(
              'QUICK NAVIGATION',
              style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.bold, color: AppColors.slate400, letterSpacing: 0.8),
            ),
            const SizedBox(height: 10),

            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.6,
              children: [
                _buildQuickAction(
                  icon: Icons.document_scanner_rounded,
                  iconBg: AppColors.primaryBlue.withOpacity(0.12),
                  iconColor: AppColors.primaryBlue,
                  title: 'Scan Package',
                  subtitle: 'Camera OCR',
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ScanScreen())),
                ),
                _buildQuickAction(
                  icon: Icons.medication_rounded,
                  iconBg: AppColors.tealAccent.withOpacity(0.12),
                  iconColor: AppColors.tealAccent,
                  title: 'My Medications',
                  subtitle: '3 Active Drugs',
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MyMedicationsScreen())),
                ),
                _buildQuickAction(
                  icon: Icons.history_rounded,
                  iconBg: Colors.indigo.withOpacity(0.12),
                  iconColor: Colors.indigo,
                  title: 'Scan History',
                  subtitle: 'View 3 past scans',
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ScanHistoryScreen())),
                ),
                _buildQuickAction(
                  icon: Icons.smart_toy_rounded,
                  iconBg: AppColors.successGreen.withOpacity(0.12),
                  iconColor: AppColors.successGreen,
                  title: 'AI Assistant',
                  subtitle: 'Ask scan queries',
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ChatbotScreen())),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Purpose Advisory Banner
            const AdvisoryBanner(
              title: 'Informational Decision Support',
              message:
                  'MediCheck AI assists in extracting printed package data and cross-referencing against reference medicines and personal medication profiles. It does not replace clinical consultation.',
              type: AdvisoryType.info,
            ),

            const SizedBox(height: 16),

            // Recent Scan Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Most Recent Scan',
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.slate900),
                        ),
                        TextButton(
                          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ScanHistoryScreen())),
                          child: const Text('See all', style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const VerificationResultScreen())),
                      leading: Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: AppColors.slate100,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.medication_liquid_rounded, color: AppColors.primaryBlue),
                      ),
                      title: const Text('Glycomet 500 SR', style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.bold)),
                      subtitle: const Text('Metformin HCl • Batch PCM82491', style: TextStyle(fontSize: 11, color: AppColors.slate500)),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: AppColors.attentionBg,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: AppColors.attentionBorder),
                            ),
                            child: const Text(
                              'Attention Required',
                              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFFB45309)),
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Text('4/5 Checks Matched', style: TextStyle(fontSize: 10, color: AppColors.slate400)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentNavIndex,
        onTap: _onNavTap,
      ),
    );
  }

  Widget _buildQuickAction({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(title, style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.bold, color: AppColors.slate800)),
                    Text(subtitle, style: const TextStyle(fontSize: 10.5, color: AppColors.slate500)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
