import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> displayExOh = List.filled(9, '');
  // MARK: Lets say first player is o, we may change it later
  bool ohTurn = true;

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
            onTap: (() {
              _tapped(index);
            }),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.shade700,
                ),
              ),
              child: Center(
                child: Text(
                  displayExOh[index],
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

  void _tapped(int index) {
    setState(() {
      // Update UI, put oh or x
      if (ohTurn) {
        displayExOh[index] = 'o';
      } else {
        displayExOh[index] = 'x';
      }

      // check winner occur
      _checkWinner();

      // update Logic, go to next player's turn
      ohTurn = !ohTurn;
    });
  }

  void _checkWinner() {
    // check 1st row
    if (displayExOh[0] != '' &&
        displayExOh[0] == displayExOh[1] &&
        displayExOh[0] == displayExOh[2]) {
      _showWinDialog(displayExOh[0]);
    }

    // check 2nd row
    if (displayExOh[3] != '' &&
        displayExOh[3] == displayExOh[4] &&
        displayExOh[3] == displayExOh[5]) {
      _showWinDialog(displayExOh[3]);
    }

    // check 3rd row
    if (displayExOh[6] != '' &&
        displayExOh[6] == displayExOh[7] &&
        displayExOh[6] == displayExOh[8]) {
      _showWinDialog(displayExOh[6]);
    }

    // check 1st column
    if (displayExOh[0] != '' &&
        displayExOh[0] == displayExOh[3] &&
        displayExOh[0] == displayExOh[6]) {
      _showWinDialog(displayExOh[0]);
    }

    // check 2nd column
    if (displayExOh[1] != '' &&
        displayExOh[1] == displayExOh[4] &&
        displayExOh[1] == displayExOh[7]) {
      _showWinDialog(displayExOh[1]);
    }

    // check 3rd column
    if (displayExOh[2] != '' &&
        displayExOh[2] == displayExOh[5] &&
        displayExOh[2] == displayExOh[8]) {
      _showWinDialog(displayExOh[2]);
    }

    // check left to right diagonal
    if (displayExOh[0] != '' &&
        displayExOh[0] == displayExOh[4] &&
        displayExOh[0] == displayExOh[8]) {
      _showWinDialog(displayExOh[0]);
    }

    // check right to left diagonal
    if (displayExOh[2] != '' &&
        displayExOh[2] == displayExOh[4] &&
        displayExOh[2] == displayExOh[6]) {
      _showWinDialog(displayExOh[2]);
    }
  }

  void _showWinDialog(String winner) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('WINNER IS: $winner!'),
        );
      },
    );
  }
}
