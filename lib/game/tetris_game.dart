import 'dart:math';
import 'package:flame/game.dart';
import 'package:flame/events.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import '../models/piece_type.dart';
import '../models/piece_data.dart';
import '../models/position.dart';
import '../models/game_state.dart';
import '../components/board.dart';
import '../components/tetromino.dart';
import '../components/ghost_piece.dart';
import '../components/next_piece_display.dart';
import 'constants.dart';

class TetrisGame extends FlameGame with KeyboardEvents {
  late Board board;
  late GhostPiece ghostPiece;
  late NextPieceDisplay nextPieceDisplay;

  Tetromino? currentPiece;
  PieceType? nextPieceType;

  GameState gameState = GameState.ready;
  double blockSize = GameConstants.defaultBlockSize;

  int score = 0;
  int level = 1;
  int linesCleared = 0;

  double _dropTimer = 0;
  double _playTime = 0;
  final Random _random = Random();

  Function(int score, int level, int lines)? onScoreUpdate;
  Function(int finalScore, double playTime)? onGameOver;

  @override
  Future<void> onLoad() async {
    final boardWidth = GameConstants.boardWidth * blockSize;
    final boardHeight = GameConstants.boardHeight * blockSize;

    // Center the board in the available space
    final boardX = (size.x - boardWidth) / 2;
    final boardY = (size.y - boardHeight) / 2;

    board = Board(blockSize: blockSize)..position = Vector2(boardX, boardY);
    ghostPiece = GhostPiece(blockSize: blockSize)..position = Vector2(boardX, boardY);

    // Next piece display to the right of the board (if space) or hidden
    final nextDisplayX = boardX + boardWidth + 10;
    final showNextPiece = nextDisplayX + 80 < size.x;

    nextPieceDisplay = NextPieceDisplay(
      position: Vector2(
        showNextPiece ? nextDisplayX : -200,
        boardY,
      ),
    );

    add(board);
    add(ghostPiece);
    add(nextPieceDisplay);
  }

  void startGame() {
    board.reset();
    score = 0;
    level = 1;
    linesCleared = 0;
    _playTime = 0;
    _dropTimer = 0;
    gameState = GameState.playing;

    _spawnNextPiece();
    _spawnPiece();
    onScoreUpdate?.call(score, level, linesCleared);
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (gameState != GameState.playing) return;

    _playTime += dt;
    _dropTimer += dt * 1000;

    final dropInterval = GameConstants.initialDropInterval -
        ((level - 1) * GameConstants.levelSpeedDecrease);
    final clampedInterval = dropInterval.clamp(
      GameConstants.minDropInterval,
      GameConstants.initialDropInterval,
    );

    if (_dropTimer >= clampedInterval) {
      _dropTimer = 0;
      _moveDown();
    }
  }

  void _spawnNextPiece() {
    nextPieceType = PieceType.values[_random.nextInt(PieceType.values.length)];
    nextPieceDisplay.showPiece(nextPieceType!);
  }

  void _spawnPiece() {
    final type =
        nextPieceType ?? PieceType.values[_random.nextInt(PieceType.values.length)];
    final spawnPos = PieceData.getSpawnPosition(type);

    currentPiece = Tetromino(type: type, startPosition: spawnPos, blockSize: blockSize)
      ..position = board.position;

    if (!board.isValidPosition(currentPiece!.getBlockPositions())) {
      gameState = GameState.gameOver;
      onGameOver?.call(score, _playTime);
      return;
    }

    add(currentPiece!);
    _updateGhostPiece();
    _spawnNextPiece();
  }

  void _moveDown() {
    if (currentPiece == null || gameState != GameState.playing) return;

    final prevPos = currentPiece!.boardPosition;
    currentPiece!.moveDown();

    if (!board.isValidPosition(currentPiece!.getBlockPositions())) {
      currentPiece!.undoMove(prevPos);
      _lockPiece();
    }
  }

  void moveLeft() {
    if (currentPiece == null || gameState != GameState.playing) return;

    final prevPos = currentPiece!.boardPosition;
    currentPiece!.moveLeft();

    if (!board.isValidPosition(currentPiece!.getBlockPositions())) {
      currentPiece!.undoMove(prevPos);
    } else {
      _updateGhostPiece();
    }
  }

  void moveRight() {
    if (currentPiece == null || gameState != GameState.playing) return;

    final prevPos = currentPiece!.boardPosition;
    currentPiece!.moveRight();

    if (!board.isValidPosition(currentPiece!.getBlockPositions())) {
      currentPiece!.undoMove(prevPos);
    } else {
      _updateGhostPiece();
    }
  }

  void moveDown() => _moveDown();

  void rotate() {
    if (currentPiece == null || gameState != GameState.playing) return;

    currentPiece!.rotate();

    if (!board.isValidPosition(currentPiece!.getBlockPositions())) {
      currentPiece!.undoRotate();
    } else {
      _updateGhostPiece();
    }
  }

  void hardDrop() {
    if (currentPiece == null || gameState != GameState.playing) return;

    while (true) {
      final prevPos = currentPiece!.boardPosition;
      currentPiece!.moveDown();

      if (!board.isValidPosition(currentPiece!.getBlockPositions())) {
        currentPiece!.undoMove(prevPos);
        break;
      }
    }

    _lockPiece();
  }

  void _lockPiece() {
    if (currentPiece == null) return;

    board.lockPiece(
      currentPiece!.getBlockPositions(),
      currentPiece!.color,
    );

    currentPiece!.removeFromParent();
    currentPiece = null;
    ghostPiece.clear();

    final lines = board.clearLines();
    if (lines > 0) {
      _updateScore(lines);
    }

    if (board.isGameOver()) {
      gameState = GameState.gameOver;
      onGameOver?.call(score, _playTime);
      return;
    }

    _spawnPiece();
  }

  void _updateScore(int lines) {
    linesCleared += lines;

    switch (lines) {
      case 1:
        score += GameConstants.singleLineScore * level;
      case 2:
        score += GameConstants.doubleLineScore * level;
      case 3:
        score += GameConstants.tripleLineScore * level;
      case 4:
        score += GameConstants.tetrisScore * level;
    }

    level = (linesCleared ~/ GameConstants.linesPerLevel) + 1;

    onScoreUpdate?.call(score, level, linesCleared);
  }

  void _updateGhostPiece() {
    if (currentPiece == null) return;

    var ghostY = currentPiece!.boardPosition.y;
    final ghostX = currentPiece!.boardPosition.x;

    while (true) {
      final testPositions = PieceData.getRotations(currentPiece!.type)[
              currentPiece!.rotationState]
          .map((p) => Position(ghostX + p.x, ghostY + 1 + p.y))
          .toList();

      if (!board.isValidPosition(testPositions)) {
        break;
      }
      ghostY++;
    }

    final ghostPositions = PieceData.getRotations(currentPiece!.type)[
            currentPiece!.rotationState]
        .map((p) => Position(ghostX + p.x, ghostY + p.y))
        .toList();

    ghostPiece.updateGhost(
      type: currentPiece!.type,
      targetPositions: ghostPositions,
    );
  }

  @override
  KeyEventResult onKeyEvent(
    KeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    if (event is! KeyDownEvent) return KeyEventResult.ignored;
    if (gameState != GameState.playing) return KeyEventResult.ignored;

    switch (event.logicalKey) {
      case LogicalKeyboardKey.arrowLeft:
        moveLeft();
        return KeyEventResult.handled;
      case LogicalKeyboardKey.arrowRight:
        moveRight();
        return KeyEventResult.handled;
      case LogicalKeyboardKey.arrowDown:
        _moveDown();
        return KeyEventResult.handled;
      case LogicalKeyboardKey.arrowUp:
      case LogicalKeyboardKey.space:
        rotate();
        return KeyEventResult.handled;
      case LogicalKeyboardKey.enter:
        hardDrop();
        return KeyEventResult.handled;
      default:
        return KeyEventResult.ignored;
    }
  }

  void togglePause() {
    if (gameState == GameState.playing) {
      gameState = GameState.paused;
    } else if (gameState == GameState.paused) {
      gameState = GameState.playing;
    }
  }

  double get playTimeSeconds => _playTime;
}
