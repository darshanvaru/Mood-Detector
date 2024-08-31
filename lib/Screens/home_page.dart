import 'dart:math';
import 'package:flutter/material.dart';
import '../Widgets/app_bottom_nav_bar.dart';
import 'main_camera.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> with TickerProviderStateMixin {
  bool _photoClicked = false;
  late AnimationController _outerCircleController;
  late AnimationController _middleCircleController;
  late Animation<double> _outerCircleAnimation;
  late Animation<double> _middleCircleAnimation;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _initOuterCircleAnimation();
    _initMiddleCircleAnimation();
  }

  void _initOuterCircleAnimation() {
    _outerCircleController = AnimationController(
      duration: Duration(seconds: _random.nextInt(2) + 3),
      vsync: this,
    )..repeat(reverse: true);

    _outerCircleAnimation = Tween<double>(
      begin: 1.0,
      end: _random.nextDouble() * 0.06 + 1.05,
    ).animate(
      CurvedAnimation(parent: _outerCircleController, curve: Curves.easeInOut),
    );
  }

  void _initMiddleCircleAnimation() {
    _middleCircleController = AnimationController(
      duration: Duration(seconds: _random.nextInt(2) + 3),
      vsync: this,
    )..repeat(reverse: true);

    _middleCircleAnimation = Tween<double>(
      begin: 1.0,
      end: _random.nextDouble() * 0.05 + 1.05,
    ).animate(
      CurvedAnimation(parent: _middleCircleController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _outerCircleController.dispose();
    _middleCircleController.dispose();
    super.dispose();
  }

  void _togglePhotoClicked() {
    setState(() {
      _photoClicked = !_photoClicked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Center(
          child: Text(
            'Emotion Eye',
            style: TextStyle(
              fontFamily: 'Proximal Nova',
              fontSize: 24.0,
            ),
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(height: 10),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.circle, size: 10, color: Colors.grey),
              SizedBox(width: 10),
              Icon(Icons.circle, size: 10, color: Colors.blue),
              SizedBox(width: 10),
              Icon(Icons.circle, size: 10, color: Colors.grey),
            ],
          ),
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                AnimatedBuilder(
                  animation: _outerCircleAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _outerCircleAnimation.value,
                      child: Container(
                        width: 240,
                        height: 240,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue[100],
                        ),
                      ),
                    );
                  },
                ),
                AnimatedBuilder(
                  animation: _middleCircleAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _middleCircleAnimation.value,
                      child: Container(
                        width: 175,
                        height: 175,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue[300],
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  width: 110,
                  height: 110,
                  child: FloatingActionButton(
                    onPressed: () {
                      _togglePhotoClicked(); // This toggles the _photoClicked state
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MainCamera()
                          ));
                    },
                    shape: const CircleBorder(),
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    heroTag: null,
                    child: const Icon(Icons.camera_alt, size: 50),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const AppBottomNavBar(selectedIndex: 0),
    );
  }
}
