import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PerformanceConfig {
  // Disable debug logging in production
  static void disableDebugLogs() {
    if (kReleaseMode) {
      debugPrint = (String? message, {int? wrapWidth}) {};
    }
  }

  // Optimize widget rebuilds
  static bool shouldRebuild(dynamic previous, dynamic current) {
    return previous.runtimeType != current.runtimeType;
  }

  // Reduce overdraw
  static BoxDecoration? optimizeDecoration(BoxDecoration? decoration) {
    if (decoration == null) return null;
    
    // Remove unnecessary shadows in debug mode
    if (kDebugMode) {
      return decoration.copyWith(boxShadow: null);
    }
    
    return decoration;
  }

  // Memory optimization settings
  static const int maxCacheSize = 100;
  static const Duration cacheExpiry = Duration(hours: 5);
  
  // Animation settings
  static const Duration defaultAnimationDuration = Duration(milliseconds: 200);
  static const Curve defaultAnimationCurve = Curves.easeInOut;
  
  // List view optimization
  static const double listItemExtent = 120.0;
  static const bool addAutomaticKeepAlives = false;
  static const bool addRepaintBoundaries = true;
  static const bool addSemanticIndexes = false;
}