import 'package:flutter/material.dart';
import 'levels/beginner_level_screen.dart';
import 'levels/intermediate_level_screen.dart';
import 'levels/advanced_level_screen.dart';
import 'profileScreen.dart';

class HomeSearchProfile extends StatelessWidget {
  final int selectedLevel;
  final Function(int) onLevelSelected;

  const HomeSearchProfile({
    Key? key,
    required this.selectedLevel,
    required this.onLevelSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeSearchProfile(
                      selectedLevel: 0,
                      onLevelSelected: onLevelSelected,
                    ),
                  ),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                switch (selectedLevel) {
                  case 0:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BeginnerLevelPage(),
                      ),
                    );
                    break;
                  case 1:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => IntermediateLevelPage(),
                      ),
                    );
                    break;
                  case 2:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AdvancedLevelPage(),
                      ),
                    );
                    break;
                  default:
                    // Navigate to a default page if no level is selected
                    break;
                }
              },
            ),
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
} 