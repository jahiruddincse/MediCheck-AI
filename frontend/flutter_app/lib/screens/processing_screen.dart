import 'package:flutter/material.dart';
import 'dart:async';
import '../theme/app_theme.dart';
import 'extracted_info_screen.dart';

class ProcessingScreen extends StatefulWidget {
  const ProcessingScreen({Key? key}) : super(key: key);

  @override
  State<ProcessingScreen> createState() => _ProcessingScreenState();
}

class _ProcessingScreenState extends State<ProcessingScreen> {
  int _currentStepIndex = 0;
  Timer? _timer;

  final List<String> _steps = [
    'Image received',
    'Image preprocessing (OpenCV)',
    'Detecting medicine information (YOLO)',
    'Extracting text (EasyOCR)',
    'Structuring information (AI/NLP)',
    'Checking reference database',
    'Preparing report',
  ];

  @override
  void initState() {
    super.initState();
    _startStepping();
  }

  void _startStepping() {
    _timer = Timer.periodic(const Duration(milliseconds: 400), (timer) {
      if (_currentStepIndex < _steps.length - 1) {
        setState(() {
          _currentStepIndex++;
        });
      } else {
        timer.cancel();
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const ExtractedInfoScreen()),
            );
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Header
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F9FF),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFBAE6FD)),
                    ),
                    child: const Text(
                      'AI VISION & OCR PIPELINE',
                      style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.bold, color: AppColors.primaryBlue),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Analyzing Package',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: AppColors.slate900),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Extracting printed details and comparing with reference datasets',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12.5, color: AppColors.slate500),
                  ),
                ],
              ),

              // Animated Scanner Radar Indicator
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFFBAE6FD), width: 2),
                      ),
                    ),
                    Container(
                      width: 110,
                      height: 110,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppColors.primaryBlue, AppColors.tealAccent],
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primaryBlue.withOpacity(0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Icon(Icons.document_scanner_rounded, size: 44, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),

              // Checklist Steps
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.slate50,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.slate200),
                ),
                child: Column(
                  children: List.generate(_steps.length, (index) {
                    final isDone = index <= _currentStepIndex;
                    final isCurrent = index == _currentStepIndex;

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: isDone ? AppColors.successBg : AppColors.slate200,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: isDone
                                  ? const Icon(Icons.check, size: 13, color: AppColors.successGreen)
                                  : Container(
                                      width: 6,
                                      height: 6,
                                      decoration: const BoxDecoration(
                                        color: AppColors.slate400,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              _steps[index],
                              style: TextStyle(
                                fontSize: 12.5,
                                fontWeight: isCurrent ? FontWeight.bold : (isDone ? FontWeight.w500 : FontWeight.normal),
                                color: isDone ? AppColors.slate800 : AppColors.slate400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),

              // Fast skip
              TextButton(
                onPressed: () {
                  _timer?.cancel();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const ExtractedInfoScreen()),
                  );
                },
                child: const Text('Skip Waiting & View Results', style: TextStyle(fontSize: 12, color: AppColors.slate500)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
