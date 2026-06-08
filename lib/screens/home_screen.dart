import 'package:flutter/material.dart';
import '../widgets/app_menu_button.dart';
import 'revision_screen.dart';
import 'quiz_setup_screen.dart';
import 'progress_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _bounceAnimation;

  void _goToRevision(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const RevisionScreen()),
    );
  }

  void _goToQuiz(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const QuizSetupScreen()),
    );
  }

  void _goToProgress(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ProgressScreen()),
    );
  }

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _bounceAnimation = Tween<double>(
      begin: 0,
      end: -12,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenHeight < 700;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tables de multiplication'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(isSmallScreen ? 16 : 24),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(isSmallScreen ? 14 : 18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.orange.withValues(alpha: 0.25),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    AnimatedBuilder(
                      animation: _bounceAnimation,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(0, _bounceAnimation.value),
                          child: child,
                        );
                      },
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: isSmallScreen ? 160 : 240,
                        ),
                        child: Image.asset(
                          'assets/images/abacus.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    SizedBox(height: isSmallScreen ? 10 : 16),
                    Text(
                      '🌟 Prêt à devenir un champion ? 🌟',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: isSmallScreen ? 20 : 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: isSmallScreen ? 6 : 10),
                    Text(
                      'Révise les tables de multiplication en t’amusant !',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: isSmallScreen ? 14 : 17,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: isSmallScreen ? 18 : 28),
              AppMenuButton(
                text: 'Réviser les tables',
                icon: Icons.menu_book,
                onPressed: () => _goToRevision(context),
              ),
              SizedBox(height: isSmallScreen ? 10 : 16),
              AppMenuButton(
                text: 'Mode quiz',
                icon: Icons.quiz,
                onPressed: () => _goToQuiz(context),
              ),
              SizedBox(height: isSmallScreen ? 10 : 16),
              AppMenuButton(
                text: 'Mes progrès',
                icon: Icons.bar_chart,
                onPressed: () => _goToProgress(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}