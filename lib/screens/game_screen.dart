import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import '../game/tetris_game.dart';
import '../game/constants.dart';
import '../widgets/score_display.dart';
import '../widgets/control_buttons.dart';
import 'game_over_screen.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  TetrisGame? _game;
  int _score = 0;
  int _level = 1;
  int _lines = 0;
  bool _gameStarted = false;

  void _initGame(double blockSize) {
    if (_game != null) return;

    _game = TetrisGame()..blockSize = blockSize;
    _game!.onScoreUpdate = (score, level, lines) {
      setState(() {
        _score = score;
        _level = level;
        _lines = lines;
      });
    };
    _game!.onGameOver = (finalScore, playTime) {
      _showGameOver(finalScore, playTime);
    };
  }

  void _showGameOver(int finalScore, double playTime) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => GameOverScreen(
          score: finalScore,
          playTimeSeconds: playTime,
        ),
      ),
    );
  }

  void _startGame() {
    setState(() {
      _gameStarted = true;
    });
    _game?.startGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1A),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final screenWidth = constraints.maxWidth;
            final screenHeight = constraints.maxHeight;
            final isMobile = screenWidth < 600;

            // Calculate available space for the game
            final topBarHeight = 56.0;
            final controlsHeight = isMobile ? 100.0 : 90.0;
            final scoreHeight = isMobile ? 60.0 : 0.0;
            final padding = 16.0;

            final availableHeight = screenHeight -
                topBarHeight -
                controlsHeight -
                scoreHeight -
                padding * 2;
            final availableWidth = isMobile
                ? screenWidth - padding * 2
                : screenWidth * 0.6;

            final blockSize = GameConstants.calculateBlockSize(
              availableWidth,
              availableHeight,
            );

            _initGame(blockSize);

            return Column(
              children: [
                // Top bar
                SizedBox(
                  height: topBarHeight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const Spacer(),
                        if (_gameStarted)
                          IconButton(
                            icon: const Icon(Icons.pause, color: Colors.white),
                            onPressed: () => _game?.togglePause(),
                          ),
                      ],
                    ),
                  ),
                ),
                // Score display for mobile (horizontal compact)
                if (isMobile)
                  Container(
                    height: scoreHeight,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildCompactStat('SCORE', _score.toString()),
                        _buildCompactStat('LEVEL', _level.toString()),
                        _buildCompactStat('LINES', _lines.toString()),
                      ],
                    ),
                  ),
                // Game area
                Expanded(
                  child: isMobile
                      ? _buildMobileLayout()
                      : _buildDesktopLayout(),
                ),
                // Controls
                ControlButtons(
                  onLeft: () => _game?.moveLeft(),
                  onRight: () => _game?.moveRight(),
                  onDown: () => _game?.moveDown(),
                  onRotate: () => _game?.rotate(),
                  onHardDrop: () => _game?.hardDrop(),
                  compact: isMobile,
                ),
                SizedBox(height: isMobile ? 8 : 16),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildCompactStat(String label, String value) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white54,
            fontSize: 10,
            letterSpacing: 1,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (_game != null) GameWidget(game: _game!),
          if (!_gameStarted) _buildStartButton(),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: ScoreDisplay(
            score: _score,
            level: _level,
            lines: _lines,
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (_game != null) GameWidget(game: _game!),
                if (!_gameStarted) _buildStartButton(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStartButton() {
    return ElevatedButton(
      onPressed: _startGame,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.cyan,
        padding: const EdgeInsets.symmetric(
          horizontal: 48,
          vertical: 16,
        ),
      ),
      child: const Text(
        'START',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
