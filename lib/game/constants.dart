import 'package:flutter/material.dart';

class GameConstants {
  GameConstants._();

  // Board dimensions
  static const int boardWidth = 10;
  static const int boardHeight = 20;
  static const double defaultBlockSize = 30.0;

  // Calculate responsive block size based on available space
  static double calculateBlockSize(double availableWidth, double availableHeight) {
    final blockSizeFromWidth = availableWidth / boardWidth;
    final blockSizeFromHeight = availableHeight / boardHeight;
    return blockSizeFromWidth < blockSizeFromHeight
        ? blockSizeFromWidth
        : blockSizeFromHeight;
  }

  // Timing (milliseconds between drops)
  static const int initialDropInterval = 1000;
  static const int minDropInterval = 100;
  static const int levelSpeedDecrease = 50;

  // Scoring
  static const int singleLineScore = 100;
  static const int doubleLineScore = 300;
  static const int tripleLineScore = 500;
  static const int tetrisScore = 800;
  static const int linesPerLevel = 10;

  // Colors
  static const Color boardBackground = Color(0xFF1A1A2E);
  static const Color gridLineColor = Color(0xFF2A2A4E);
}
