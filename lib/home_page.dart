import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String displayExOh = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: GridView.builder(
        itemCount: 9,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: ((context, index) {
          return GestureDetector(
            onTap: _tapped,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.shade700,
                ),
              ),
              child: Center(
                child: Text(
                  displayExOh,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  void _tapped() {
    setState(() {
      displayExOh = 'o';
    });
  }
}
