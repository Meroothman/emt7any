import 'package:emt7any/core/widgets/custom_button.dart';
import 'package:emt7any/features/qr_code/qr_code.dart';
import 'package:flutter/material.dart';

class StartScanButton extends StatelessWidget {
  const StartScanButton({super.key});

  void _navigateToScanner(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const QrScannerScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: 'بدء المسح',
      onPressed: () => _navigateToScanner(context),
      icon: Icons.qr_code_scanner,
    );
  }
}
