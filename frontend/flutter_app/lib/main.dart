import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'screens/scan_screen.dart';
import 'screens/pipeline_screen.dart';
import 'screens/processing_screen.dart';
import 'screens/extracted_info_screen.dart';
import 'screens/verification_result_screen.dart';
import 'screens/my_medications_screen.dart';
import 'screens/medication_safety_screen.dart';
import 'screens/scan_history_screen.dart';
import 'screens/chatbot_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/about_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MediCheckApp());
}

class MediCheckApp extends StatelessWidget {
  const MediCheckApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MediCheck AI',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomeScreen(),
        '/scan': (context) => const ScanScreen(),
        '/pipeline': (context) => const PipelineScreen(),
        '/processing': (context) => const ProcessingScreen(),
        '/extracted-info': (context) => const ExtractedInfoScreen(),
        '/verification-result': (context) => const VerificationResultScreen(),
        '/my-medications': (context) => const MyMedicationsScreen(),
        '/medication-safety': (context) => const MedicationSafetyScreen(),
        '/scan-history': (context) => const ScanHistoryScreen(),
        '/chatbot': (context) => const ChatbotScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/about': (context) => const AboutScreen(),
      },
    );
  }
}
