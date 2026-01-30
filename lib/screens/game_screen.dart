import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import '../game/tetris_game.dart';
import '../widgets/score_display.dart';
import '../widgets/control_buttons.dart';
import 'game_over_screen.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late TetrisGame _game;
  int _score = 0;
  int _level = 1;
  int _lines = 0;
  bool _gameStarted = false;

  @override
  void initState() {
    super.initState();
    _game = TetrisGame();
    _game.onScoreUpdate = (score, level, lines) {
      setState(() {
        _score = score;
        _level = level;
        _lines = lines;
      });
    };
    _game.onGameOver = (finalScore, playTime) {
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
    _game.startGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1A),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
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
                      onPressed: () => _game.togglePause(),
                    ),
                ],
              ),
            ),
            Expanded(
              child: Row(
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
                          GameWidget(game: _game),
                          if (!_gameStarted)
                            ElevatedButton(
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
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ControlButtons(
              onLeft: () => _game.moveLeft(),
              onRight: () => _game.moveRight(),
              onDown: () => _game.moveDown(),
              onRotate: () => _game.rotate(),
              onHardDrop: () => _game.hardDrop(),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
