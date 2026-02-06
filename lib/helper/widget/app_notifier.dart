import 'package:flutter/material.dart';
import 'package:yuk_baca_quran/core/navigation/navigation_service.dart';

class AppNotifier {
  AppNotifier._();

  // ======================
  // SNACKBAR
  // ======================
  static void showSuccess(String message) {
    _showSnackBar(
      message,
      backgroundColor: Colors.green,
      icon: Icons.check_circle,
    );
  }

  static void showError(String message) {
    _showSnackBar(message, backgroundColor: Colors.red, icon: Icons.error);
  }

  static void _showSnackBar(
    String message, {
    required Color backgroundColor,
    required IconData icon,
  }) {
    final context = NavigationService.context;

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        content: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(message, style: const TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  // ======================
  // DIALOG
  // ======================
  static Future<void> showSuccessDialog({
    required String title,
    required String message,
  }) {
    return _showDialog(
      title: title,
      message: message,
      icon: Icons.check_circle,
      iconColor: Colors.green,
    );
  }

  static Future<void> showErrorDialog({
    required String title,
    required String message,
  }) {
    return _showDialog(
      title: title,
      message: message,
      icon: Icons.error,
      iconColor: Colors.red,
    );
  }

  static Future<void> _showDialog({
    required String title,
    required String message,
    required IconData icon,
    required Color iconColor,
  }) {
    final context = NavigationService.context;

    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Row(
          children: [
            Icon(icon, color: iconColor),
            const SizedBox(width: 8),
            Expanded(child: Text(title)),
          ],
        ),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
