# Tetris Game - Claude Code Rules

## Project Overview
This is a Tetris game built with Flutter and Flame engine, targeting web only, with Firebase Firestore for data persistence.

## Tech Stack
- Flutter (web only)
- Flame (game engine - main package only)
- Firebase Firestore (no Auth)
- State: Flame native (Component, HasGameRef)

## Game Features
- Basic Tetris: movement, simple rotation, line clearing, game over
- Single player only
- Global ranking (score + time)
- Play time history (daily + global)

## Project Structure
```
lib/
├── game/           # Flame game classes (TetrisGame, etc.)
├── components/     # Game components (pieces, board, etc.)
├── screens/        # Flutter screens (menu, game over, ranking)
├── services/       # Firestore services
└── main.dart       # Entry point
```

## Code Guidelines

### Language
- All code in English (variables, functions, classes, comments)

### Architecture
- Use standard Flame patterns
- Keep it simple - no over-engineering
- Avoid unnecessary abstractions

### Style
- Comments only for complex/non-obvious logic
- Self-explanatory code preferred
- Follow flutter_lints rules

## Claude Behavior Rules

### DO
- Always create tests (unit + widget) for new features
- Run `flutter analyze` after changes
- Use only: flame, firebase_core, cloud_firestore
- Keep code simple and direct
- Follow existing patterns in the codebase

### DO NOT
- Never commit to Git (user does manually)
- Never run `flutter run` or `flutter build`
- Never add extra packages without asking
- Never over-engineer solutions
- Never add comments to obvious code

## Firestore Schema
```
collections:
  - rankings/
      - {docId}: { playerName: string, score: int, time: int, createdAt: timestamp }
  - playHistory/
      - {docId}: { date: string, playTimeSeconds: int }
```

## Verification
After any code change, run:
```bash
flutter analyze
flutter test
```
