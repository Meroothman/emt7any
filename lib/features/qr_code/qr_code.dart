import 'dart:convert';
import 'package:emt7any/core/theme/app_colors.dart';
import 'package:emt7any/features/students/cubit/student_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScannerScreen extends StatefulWidget {
  const QrScannerScreen({super.key});

  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  String? _extractedStudentId;
  String? _studentName;
  String? _studentNationalId;
  bool _isProcessing = false;
  bool _hasScanned = false;
  final MobileScannerController _scannerController = MobileScannerController();

  @override
  void dispose() {
    _scannerController.dispose();
    super.dispose();
  }

  void _handleScanResult(String? qrData) {
    if (_extractedStudentId != null || _isProcessing || _hasScanned) return;

    if (qrData != null && qrData.isNotEmpty) {
      print('QR Data Received: $qrData');

      final studentData = _extractStudentDataEnhanced(qrData);
      print('Extracted Data: $studentData');

      if (studentData['student_id'] != null) {
        setState(() {
          _extractedStudentId = studentData['student_id'];
          _studentName = studentData['name'];
          _studentNationalId = studentData['national_id'];
          _hasScanned = true;
        });

        // وقف الماسح نهائياً
        _scannerController.stop();
        _scannerController.dispose();

        _showCustomSnackBar(
          message: 'تم مسح QR code بنجاح',
          backgroundColor: AppColors.success,
          icon: Icons.check_circle,
        );
      } else {
        _showCustomSnackBar(
          message: 'تعذر استخراج البيانات من رمز QR',
          backgroundColor: AppColors.error,
          icon: Icons.error,
        );
      }
    }
  }

  Map<String, String?> _extractStudentDataEnhanced(String qrData) {
    print('Trying Enhanced Extraction...');
    try {
      final data = json.decode(qrData);
      return {
        'student_id': data['student_id']?.toString(),
        'name': data['name']?.toString(),
        'national_id': data['national_id']?.toString(),
      };
    } catch (e) {
      print('Direct JSON failed: $e');
    }

    try {
      String cleaned = qrData.replaceAll('\n', '').replaceAll('\r', '').trim();
      cleaned = cleaned
          .replaceAll('“', '"')
          .replaceAll('”', '"')
          .replaceAll('\"', '"');
      if (!cleaned.endsWith('}')) cleaned = '$cleaned}';
      if (!cleaned.startsWith('{')) cleaned = '{$cleaned';

      final data = json.decode(cleaned);
      return {
        'student_id': data['student_id']?.toString(),
        'name': data['name']?.toString(),
        'national_id': data['national_id']?.toString(),
      };
    } catch (e) {
      print('Cleaned JSON failed: $e');
    }

    final studentId = _extractField(qrData, ['student_id', 'studentId', 'id']);
    final name = _extractField(qrData, ['name', 'student_name', 'studentName']);
    final nationalId = _extractField(qrData, [
      'national_id',
      'nationalId',
      'nationalID',
    ]);

    return {'student_id': studentId, 'name': name, 'national_id': nationalId};
  }

  String? _extractField(String data, List<String> fieldNames) {
    for (String field in fieldNames) {
      final patterns = [
        '"$field":\\s*"([^"]*)"',
        '"$field":\\s*(\\d+)',
        '$field:\\s*"([^"]*)"',
        '$field:\\s*(\\d+)',
        '$field\\s*=\\s*"([^"]*)"',
        '$field\\s*=\\s*(\\d+)',
      ];

      for (String pattern in patterns) {
        final match = RegExp(pattern).firstMatch(data);
        if (match != null && match.group(1) != null) {
          return match.group(1);
        }
      }
    }
    return null;
  }

  void _confirmScan() {
    if (_extractedStudentId != null) {
      context.read<StudentCubit>().confirmAndScanQrCode(_extractedStudentId!);
      setState(() {
        _isProcessing = true;
      });
    }
  }

  void _handleScanSuccess() {
    _closeScreen();
    _showCustomSnackBar(
      message: 'تم إرسال بيانات الطالب بنجاح',
      backgroundColor: AppColors.success,
      icon: Icons.check_circle,
    );
  }

  void _handleScanError(String message) {
    setState(() {
      _isProcessing = false;
    });

    _showCustomSnackBar(
      message: message,
      backgroundColor: AppColors.error,
      icon: Icons.error,
    );
  }

  void _showCustomSnackBar({
    required String message,
    required Color backgroundColor,
    required IconData icon,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.white, size: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  textDirection: TextDirection.rtl,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
        padding: EdgeInsets.zero,
        margin: const EdgeInsets.all(20),
      ),
    );
  }

  void _closeScreen() {
    if (mounted) {
      _scannerController.stop();
      _scannerController.dispose();
      Navigator.pop(context);
    }
  }

  void _handleCancel() {
    _closeScreen();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        if (!didPop) {
          _closeScreen();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text('مسح رمز QR'),
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: _closeScreen,
          ),
        ),
        body: BlocListener<StudentCubit, StudentState>(
          listener: (context, state) {
            if (state is StudentScanSuccess) {
              _handleScanSuccess();
            } else if (state is StudentScanError) {
              _handleScanError(state.message);
            }
          },
          child: Column(
            children: [
              if (_extractedStudentId != null)
                ExtractedDataCard(
                  studentId: _extractedStudentId!,
                  studentName: _studentName ?? 'غير متوفر',
                  studentNationalId: _studentNationalId ?? 'غير متوفر',
                  isProcessing: _isProcessing,
                  onConfirm: _confirmScan,
                  onCancel: _handleCancel,
                ),
              Expanded(
                child: ScannerContent(
                  hasScanned: _hasScanned,
                  extractedStudentId: _extractedStudentId,
                  onScanDetected: _handleScanResult,
                ),
              ),
              if (_extractedStudentId == null)
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: _closeScreen,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.error,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.arrow_back),
                          SizedBox(width: 8),
                          Text('رجوع'),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class ExtractedDataCard extends StatelessWidget {
  final String studentId;
  final String studentName;
  final String studentNationalId;
  final bool isProcessing;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const ExtractedDataCard({
    super.key,
    required this.studentId,
    required this.studentName,
    required this.studentNationalId,
    required this.isProcessing,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      color: AppColors.info.withOpacity(0.9),
      child: Column(
        children: [
          const Icon(Icons.check_circle, color: Colors.white, size: 40),
          const SizedBox(height: 8),
          const Text(
            'تم استخراج البيانات بنجاح',
            textDirection: TextDirection.rtl,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                _buildInfoRow('رقم الطالب', studentId),
                const SizedBox(height: 8),
                _buildInfoRow('اسم الطالب', studentName),
                const SizedBox(height: 8),
                _buildInfoRow('الرقم القومي', studentNationalId),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ConfirmButton(isProcessing: isProcessing, onConfirm: onConfirm),
              CancelButton(isProcessing: isProcessing, onCancel: onCancel),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      textDirection: TextDirection.rtl,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            textDirection: TextDirection.rtl,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              value,
              textDirection: TextDirection.rtl,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ),
      ],
    );
  }
}

class ConfirmButton extends StatelessWidget {
  final bool isProcessing;
  final VoidCallback onConfirm;

  const ConfirmButton({
    super.key,
    required this.isProcessing,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isProcessing ? null : onConfirm,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.success,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: isProcessing
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.send),
                SizedBox(width: 8),
                Text('تأكيد الإرسال'),
              ],
            ),
    );
  }
}

class CancelButton extends StatelessWidget {
  final bool isProcessing;
  final VoidCallback onCancel;

  const CancelButton({
    super.key,
    required this.isProcessing,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isProcessing ? null : onCancel,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.error,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [Icon(Icons.cancel), SizedBox(width: 8), Text('إلغاء')],
      ),
    );
  }
}

class ScannerContent extends StatelessWidget {
  final bool hasScanned;
  final String? extractedStudentId;
  final Function(String?) onScanDetected;

  const ScannerContent({
    super.key,
    required this.hasScanned,
    required this.extractedStudentId,
    required this.onScanDetected,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (!hasScanned || extractedStudentId == null)
          MobileScanner(
            onDetect: (capture) {
              final barcodes = capture.barcodes;
              if (barcodes.isNotEmpty) {
                onScanDetected(barcodes.first.rawValue);
              }
            },
          ),
        Center(
          child: Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              border: Border.all(
                color: hasScanned ? AppColors.success : AppColors.primary,
                width: 3,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: hasScanned
                ? const Icon(
                    Icons.check_circle,
                    color: AppColors.success,
                    size: 60,
                  )
                : null,
          ),
        ),
        const ScannerInstructions(),
      ],
    );
  }
}

class ScannerInstructions extends StatelessWidget {
  const ScannerInstructions({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 100,
      left: 0,
      right: 0,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 32),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.7),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Text(
          'وجه الكاميرا نحو رمز QR',
          textAlign: TextAlign.center,
          textDirection: TextDirection.rtl,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
