import 'package:flutter/material.dart';
import 'game_screen.dart';
import 'ranking_screen.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1A1A2E), Color(0xFF0F0F1A)],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final screenWidth = constraints.maxWidth;
              final isMobile = screenWidth < 400;
              final titleSize = isMobile ? 48.0 : 72.0;
              final buttonWidth = (screenWidth * 0.7).clamp(200.0, 280.0);

              return Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'TETRIS',
                        style: TextStyle(
                          fontSize: titleSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: isMobile ? 8 : 16,
                          shadows: const [
                            Shadow(
                              color: Colors.cyan,
                              blurRadius: 20,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: isMobile ? 48 : 80),
                      _buildMenuButton(
                        context,
                        'START GAME',
                        Icons.play_arrow,
                        Colors.cyan,
                        buttonWidth,
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const GameScreen()),
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildMenuButton(
                        context,
                        'RANKINGS',
                        Icons.leaderboard,
                        Colors.amber,
                        buttonWidth,
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const RankingScreen()),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildMenuButton(
    BuildContext context,
    String text,
    IconData icon,
    Color color,
    double width,
    VoidCallback onPressed,
  ) {
    return SizedBox(
      width: width,
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color.withValues(alpha: 0.2),
          foregroundColor: color,
          side: BorderSide(color: color, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 24),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
