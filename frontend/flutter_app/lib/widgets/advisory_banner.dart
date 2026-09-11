import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

enum AdvisoryType { attention, info, success }

class AdvisoryBanner extends StatelessWidget {
  final String title;
  final String message;
  final AdvisoryType type;

  const AdvisoryBanner({
    Key? key,
    required this.title,
    required this.message,
    this.type = AdvisoryType.info,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color border;
    Color iconColor;
    Color textColor;
    IconData icon;

    switch (type) {
      case AdvisoryType.attention:
        bg = AppColors.attentionBg;
        border = AppColors.attentionBorder;
        iconColor = AppColors.attentionAmber;
        textColor = const Color(0xFF92400E);
        icon = Icons.warning_amber_rounded;
        break;
      case AdvisoryType.success:
        bg = AppColors.successBg;
        border = AppColors.successBorder;
        iconColor = AppColors.successGreen;
        textColor = const Color(0xFF065F46);
        icon = Icons.check_circle_outline_rounded;
        break;
      case AdvisoryType.info:
      default:
        bg = const Color(0xFFF0F9FF);
        border = const Color(0xFFBAE6FD);
        iconColor = AppColors.primaryBlue;
        textColor = const Color(0xFF0369A1);
        icon = Icons.info_outline_rounded;
        break;
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: iconColor),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title.isNotEmpty) ...[
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 3),
                ],
                Text(
                  message,
                  style: TextStyle(
                    fontSize: 11.5,
                    height: 1.4,
                    color: textColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
