import 'package:flutter/material.dart';
import 'HomeSearchProfile.dart';
import 'levels/beginner_level_screen.dart';
import 'levels/intermediate_level_screen.dart';
import 'levels/advanced_level_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedLevel = 0; // 0 for beginner, 1 for intermediate, 2 for advanced

  // Function to build level buttons with specified colors and sizes
  Widget buildLevelButton({required String text, required Color color, required VoidCallback onPressed}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
          ),
          onPressed: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white, // Set text color to white
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 200,
                  height: 200,
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/classroom.png',
                        width: 150,
                        height: 150,
                      ),
                      SizedBox(height: 20),
                      Text(
                        'What is your level?',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                buildLevelButton(
                  text: 'Beginner Level',
                  color: Colors.blue,
                  onPressed: () {
                    setState(() {
                      _selectedLevel = 0;
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BeginnerLevelPage(),
                      ),
                    );
                  },
                ),
                SizedBox(height: 16),
                buildLevelButton(
                  text: 'Intermediate Level',
                  color: Colors.yellow,
                  onPressed: () {
                    setState(() {
                      _selectedLevel = 1;
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AdvancedLevelPage(),
                      ),
                    );
                  },
                ),
                SizedBox(height: 16),
                buildLevelButton(
                  text: 'Advanced Level',
                  color: Colors.green,
                  onPressed: () {
                    setState(() {
                      _selectedLevel = 2;
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => IntermediateLevelPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: HomeSearchProfile(
              selectedLevel: _selectedLevel,
              onLevelSelected: (int level) {
                setState(() {
                  _selectedLevel = level;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
