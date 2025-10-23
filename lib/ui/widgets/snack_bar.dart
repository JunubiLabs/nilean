import 'package:flutter/material.dart';

enum SnackMessageType { success, info, warning, error }

class SnackMessage extends StatelessWidget {
  final SnackMessageType type;
  final String title;
  final String message;
  final VoidCallback onClose;

  const SnackMessage({
    super.key,
    required this.type,
    required this.title,
    required this.message,
    required this.onClose,
  });

  // Define colors and icons for each type
  static const Map<SnackMessageType, Color> _bgColors = {
    SnackMessageType.success: Color(0xFFE8F5E9),
    SnackMessageType.info: Color(0xFFE3F2FD),
    SnackMessageType.warning: Color(0xFFFFF9C4),
    SnackMessageType.error: Color(0xFFFFEBEE),
  };

  static const Map<SnackMessageType, Color> _borderColors = {
    SnackMessageType.success: Color(0xFF4CAF50),
    SnackMessageType.info: Color(0xFF2196F3),
    SnackMessageType.warning: Color(0xFFFFC107),
    SnackMessageType.error: Color(0xFFF44336),
  };

  static const Map<SnackMessageType, IconData> _icons = {
    SnackMessageType.success: Icons.check_circle,
    SnackMessageType.info: Icons.info,
    SnackMessageType.warning: Icons.warning,
    SnackMessageType.error: Icons.error,
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _bgColors[type],
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: _borderColors[type]!, width: 1.5),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      width: double.maxFinite,
      child: Row(
        children: [
          Icon(_icons[type], color: _borderColors[type], size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 2),
                Text(message, style: const TextStyle(fontSize: 14)),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            color: Colors.grey,
            onPressed: onClose,
            splashRadius: 20,
            tooltip: 'Close',
          ),
        ],
      ),
    );
  }
}

// Usage example:
void showSnackBar(
  BuildContext context,
  SnackMessageType type,
  String title,
  String message,
) {
  final scaffoldMessenger = ScaffoldMessenger.of(
    context,
  ); // See [6] for correct usage
  scaffoldMessenger.showSnackBar(
    SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      content: SnackMessage(
        type: type,
        title: title,
        message: message,
        onClose: () => scaffoldMessenger.hideCurrentSnackBar(),
      ),
      width: double.maxFinite,
      duration: const Duration(seconds: 5),
    ),
  );
}
