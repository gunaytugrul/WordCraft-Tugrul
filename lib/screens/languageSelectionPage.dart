import 'package:flutter/material.dart';

class LanguageSelectionScreen extends StatefulWidget {
  @override
  _LanguageSelectionScreenState createState() => _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  List<String> languages = [
    'English',
    'Spanish',
    'French',
    'German',
    'Italian',
    'Japanese',
  ];
  String selectedLanguage = '';

  @override
  Widget build(BuildContext context) {
    // Cihazın genişliğine göre dinamik olarak crossAxisCount hesaplanıyor
    double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = screenWidth ~/ 150; // 150, bir elemanın genişliği için varsayılan değer

    return Scaffold(
      appBar: AppBar(
        title: Text('Select Language'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: languages.length,
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedLanguage = languages[index];
                      });
                      // Seçilen dil burada kullanılabilir
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: selectedLanguage == languages[index] ? Colors.blueAccent : Colors.pink[200],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: EdgeInsets.all(15.0),
                      child: Center(
                        child: Text(
                          languages[index],
                          style: TextStyle(
                            fontSize: 18.0,
                            color: selectedLanguage == languages[index] ? Colors.white : Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  );
                },
              ),
              if (selectedLanguage.isNotEmpty) // Seçilen dil varsa göster
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: Center(
                    child: Text(
                      'Selected Language: $selectedLanguage',
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}