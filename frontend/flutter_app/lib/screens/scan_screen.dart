import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'processing_screen.dart';
import 'pipeline_screen.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> with SingleTickerProviderStateMixin {
  late AnimationController _laserController;

  @override
  void initState() {
    super.initState();
    _laserController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _laserController.dispose();
    super.dispose();
  }

  void _triggerScan() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ProcessingScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.slate900,
      appBar: AppBar(
        backgroundColor: AppColors.slate900,
        foregroundColor: Colors.white,
        title: const Text('Scan Medicine Package', style: TextStyle(color: Colors.white, fontSize: 16)),
        actions: [
          IconButton(
            icon: const Icon(Icons.hub_outlined, color: Color(0xFF38BDF8)),
            tooltip: 'View AI Pipeline',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const PipelineScreen()));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Camera Viewfinder Box
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF090E1A),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.slate700, width: 2),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Simulated Medicine Package
                  Container(
                    width: 250,
                    height: 190,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.slate200, width: 1.5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('USV Private Limited', style: TextStyle(fontSize: 9.5, color: AppColors.slate500)),
                            Text('Rx ONLY', style: TextStyle(fontSize: 9.5, color: AppColors.primaryBlue, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('GLYCOMET 500 SR', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Color(0xFF0C4A6E))),
                            Text('Metformin Hydrochloride', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.tealDark)),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: AppColors.slate100,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: AppColors.slate200),
                          ),
                          child: const Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('B.No: PCM82491', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, fontFamily: 'monospace')),
                                  Text('EXP: 07/2027', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF92400E), fontFamily: 'monospace')),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('MFD: 08/2024', style: TextStyle(fontSize: 9, color: AppColors.slate500)),
                                  Text('MRP ₹45.20', style: TextStyle(fontSize: 9, color: AppColors.slate500)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Animated Scanning Laser Beam
                  AnimatedBuilder(
                    animation: _laserController,
                    builder: (context, child) {
                      return Positioned(
                        top: 40 + (_laserController.value * 280),
                        left: 20,
                        right: 20,
                        child: Container(
                          height: 3,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Colors.transparent, Color(0xFF38BDF8), AppColors.tealAccent, Colors.transparent],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF38BDF8).withOpacity(0.8),
                                blurRadius: 12,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  // Guide Frame Target Corners
                  Positioned(
                    top: 20,
                    left: 20,
                    child: _buildCorner(isTop: true, isLeft: true),
                  ),
                  Positioned(
                    top: 20,
                    right: 20,
                    child: _buildCorner(isTop: true, isLeft: false),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    child: _buildCorner(isTop: false, isLeft: true),
                  ),
                  Positioned(
                    bottom: 20,
                    right: 20,
                    child: _buildCorner(isTop: false, isLeft: false),
                  ),

                  // Guide Text
                  Positioned(
                    bottom: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.slate700),
                      ),
                      child: const Text(
                        'Center medicine package inside frame',
                        style: TextStyle(color: AppColors.slate200, fontSize: 11),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Tips Carousel
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                _buildTipItem('Keep package flat', Icons.crop_square_rounded, 'Flatness'),
                const SizedBox(width: 8),
                _buildTipItem('Use good lighting', Icons.wb_sunny_outlined, 'Lighting'),
                const SizedBox(width: 8),
                _buildTipItem('Make text clearly visible', Icons.text_fields_rounded, 'Clarity'),
              ],
            ),
          ),

          // Bottom Shutter & Gallery Controls
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 28),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: _triggerScan,
                  icon: const Icon(Icons.photo_library_outlined, color: AppColors.slate400, size: 28),
                  tooltip: 'Upload from Gallery',
                ),
                // Primary Shutter Button
                GestureDetector(
                  onTap: _triggerScan,
                  child: Container(
                    width: 74,
                    height: 74,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white.withOpacity(0.3), width: 3),
                    ),
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [AppColors.primaryBlue, AppColors.tealAccent],
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(Icons.camera_alt_rounded, color: Colors.white, size: 30),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const PipelineScreen()));
                  },
                  icon: const Icon(Icons.schema_outlined, color: AppColors.slate400, size: 28),
                  tooltip: 'AI Pipeline',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCorner({required bool isTop, required bool isLeft}) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        border: Border(
          top: isTop ? const BorderSide(color: Color(0xFF38BDF8), width: 3) : BorderSide.none,
          bottom: !isTop ? const BorderSide(color: Color(0xFF38BDF8), width: 3) : BorderSide.none,
          left: isLeft ? const BorderSide(color: Color(0xFF38BDF8), width: 3) : BorderSide.none,
          right: !isLeft ? const BorderSide(color: Color(0xFF38BDF8), width: 3) : BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildTipItem(String text, IconData icon, String title) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.slate800.withOpacity(0.6),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.slate700),
        ),
        child: Column(
          children: [
            Icon(icon, size: 16, color: const Color(0xFF38BDF8)),
            const SizedBox(height: 4),
            Text(title, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
            Text(text, textAlign: TextAlign.center, style: const TextStyle(color: AppColors.slate400, fontSize: 9)),
          ],
        ),
      ),
    );
  }
}
