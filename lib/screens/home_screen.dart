import 'package:flutter/material.dart';
import 'pose_detection_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutCubic,
          ),
        );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _navigateToPoseDetection() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const PoseDetectionScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    final isSmallScreen = screenWidth < 360;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0A1628), // Dark navy blue (top)
              Color(0xFF1A2B45), // Slightly lighter navy (middle)
              Color(0xFF0A1628), // Dark navy blue (bottom)
            ],
          ),
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.08),

                  // App Logo/Icon
                  _buildLogo(screenWidth, isSmallScreen),

                  SizedBox(height: screenHeight * 0.04),

                  // Title
                  _buildTitle(screenWidth, isSmallScreen),

                  SizedBox(height: screenHeight * 0.02),

                  // Subtitle
                  _buildSubtitle(screenWidth, isSmallScreen),

                  SizedBox(height: screenHeight * 0.06),

                  // Feature cards
                  Expanded(
                    child: _buildFeatureCards(screenWidth, isSmallScreen),
                  ),

                  SizedBox(height: screenHeight * 0.04),
                  // Start button
                  _buildStartButton(screenWidth, isSmallScreen),

                  SizedBox(height: screenHeight * 0.04),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Build animated logo
  Widget _buildLogo(double screenWidth, bool isSmallScreen) {
    final size = isSmallScreen ? 100.0 : 120.0;

    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFFCAFF33), // Lime green
        boxShadow: [
          BoxShadow(
            color: Color(0x80CAFF33), // Lime green with transparency
            blurRadius: 30,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Icon(
        Icons.accessibility_new,
        size: size * 0.6,
        color: Color(0xFF0A1628), // Dark navy icon on bright background
      ),
    );
  }

  /// Build title text
  Widget _buildTitle(double screenWidth, bool isSmallScreen) {
    final fontSize = isSmallScreen ? 28.0 : 36.0;

    return Text(
      'Pose Detection',
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        letterSpacing: 1.5,
        shadows: [
          Shadow(
            color: Colors.black.withValues(alpha: 0.3),
            offset: const Offset(2, 2),
            blurRadius: 4,
          ),
        ],
      ),
    );
  }

  /// Build subtitle text
  Widget _buildSubtitle(double screenWidth, bool isSmallScreen) {
    final fontSize = isSmallScreen ? 14.0 : 16.0;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
      child: Text(
        'Track your body movements in real-time',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: fontSize,
          color: Colors.white70,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  /// Build feature cards
  Widget _buildFeatureCards(double screenWidth, bool isSmallScreen) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
      child: Column(
        children: [
          _buildFeatureCard(
            icon: Icons.camera_alt,
            title: 'Real-Time Detection',
            description:
                'Detect your pose instantly using advanced ML technology',
            screenWidth: screenWidth,
            isSmallScreen: isSmallScreen,
          ),
          SizedBox(height: screenWidth * 0.04),
          _buildFeatureCard(
            icon: Icons.settings_accessibility,
            title: 'Skeletal Tracking',
            description: 'Visualize your body joints and connections live',
            screenWidth: screenWidth,
            isSmallScreen: isSmallScreen,
          ),
          SizedBox(height: screenWidth * 0.04),
          _buildFeatureCard(
            icon: Icons.sports_gymnastics,
            title: 'Sports & Fitness',
            description: 'Perfect for exercise form analysis and training',
            screenWidth: screenWidth,
            isSmallScreen: isSmallScreen,
          ),
        ],
      ),
    );
  }

  /// Build individual feature card
  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String description,
    required double screenWidth,
    required bool isSmallScreen,
  }) {
    final titleSize = isSmallScreen ? 16.0 : 18.0;
    final descSize = isSmallScreen ? 12.0 : 14.0;
    final iconSize = isSmallScreen ? 32.0 : 40.0;

    return Container(
      padding: EdgeInsets.all(screenWidth * 0.04),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(
                0xFFCAFF33,
              ).withValues(alpha: 0.2), // Lime green tint
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: const Color(0xFFCAFF33), // Lime green
              size: iconSize,
            ),
          ),
          SizedBox(width: screenWidth * 0.04),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: titleSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(fontSize: descSize, color: Colors.white70),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Build start button
  Widget _buildStartButton(double screenWidth, bool isSmallScreen) {
    final buttonWidth = isSmallScreen ? screenWidth * 0.7 : screenWidth * 0.6;
    final fontSize = isSmallScreen ? 16.0 : 18.0;

    return Container(
      width: buttonWidth,
      height: isSmallScreen ? 50 : 56,
      decoration: BoxDecoration(
        color: const Color(0xFFCAFF33), // Lime green
        borderRadius: BorderRadius.circular(28),
        boxShadow: const [
          BoxShadow(
            color: Color(0x80CAFF33), // Lime green with transparency
            blurRadius: 20,
            spreadRadius: 2,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _navigateToPoseDetection,
          borderRadius: BorderRadius.circular(28),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.play_arrow_rounded,
                  color: const Color(0xFF0A1628), // Dark navy
                  size: isSmallScreen ? 24 : 28,
                ),
                const SizedBox(width: 8),
                Text(
                  'Start Detection',
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF0A1628), // Dark navy text
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
