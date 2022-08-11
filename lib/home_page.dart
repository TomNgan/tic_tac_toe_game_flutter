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

  TextStyle myTextStyle = const TextStyle(color: Colors.white, fontSize: 30);
  int ohScore = 0;
  int xScore = 0;
  int filledBoxees = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Player O',
                          style: myTextStyle,
                        ),
                        Text(
                          ohScore.toString(),
                          style: myTextStyle,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Player X',
                          style: myTextStyle,
                        ),
                        Text(
                          xScore.toString(),
                          style: myTextStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: GridView.builder(
              itemCount: 9,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
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
          ),
          Expanded(
            child: Container(),
          ),
        ],
      ),
    );
  }

  void _tapped(int index) {
    setState(() {
      // Turn change when users put a sign on the empty box.
      if (displayExOh[index] == '') {
        filledBoxees += 1;

        if (ohTurn) {
          displayExOh[index] = 'o';
        } else {
          displayExOh[index] = 'x';
        }

        // update Logic, go to next player's turn
        ohTurn = !ohTurn;

        // check winner occur
        _checkWinner();
      }
    });
  }

  void _checkWinner() {
    if (displayExOh[0] != '' && // check 1st row
        displayExOh[0] == displayExOh[1] &&
        displayExOh[0] == displayExOh[2]) {
      _showWinDialog(displayExOh[0]);
    } else if (displayExOh[3] != '' && // check 2nd row
        displayExOh[3] == displayExOh[4] &&
        displayExOh[3] == displayExOh[5]) {
      _showWinDialog(displayExOh[3]);
    } else if (displayExOh[6] != '' && // check 3rd row
        displayExOh[6] == displayExOh[7] &&
        displayExOh[6] == displayExOh[8]) {
      _showWinDialog(displayExOh[6]);
    } else if (displayExOh[0] != '' && // check 1st column
        displayExOh[0] == displayExOh[3] &&
        displayExOh[0] == displayExOh[6]) {
      _showWinDialog(displayExOh[0]);
    } else if (displayExOh[1] != '' && // check 2nd column
        displayExOh[1] == displayExOh[4] &&
        displayExOh[1] == displayExOh[7]) {
      _showWinDialog(displayExOh[1]);
    } else if (displayExOh[2] != '' && // check 3rd column
        displayExOh[2] == displayExOh[5] &&
        displayExOh[2] == displayExOh[8]) {
      _showWinDialog(displayExOh[2]);
    } else if (displayExOh[0] != '' && // check left to right diagonal
        displayExOh[0] == displayExOh[4] &&
        displayExOh[0] == displayExOh[8]) {
      _showWinDialog(displayExOh[0]);
    } else if (displayExOh[2] != '' && // check right to left diagonal
        displayExOh[2] == displayExOh[4] &&
        displayExOh[2] == displayExOh[6]) {
      _showWinDialog(displayExOh[2]);
    } else if (filledBoxees == 9) {
      // draw case
      _showDrawDialog();
    }
  }

  void _showWinDialog(String winner) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('WINNER IS: $winner!'),
          actions: [
            TextButton(
              onPressed: () {
                _clearBoard();
                Navigator.of(context).pop();
              },
              child: const Text('Play Again!'),
            )
          ],
        );
      },
    );

    if (winner == 'o') {
      ohScore += 1;
    } else if (winner == 'x') {
      xScore += 1;
    }
  }

  void _showDrawDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('DRAW!'),
          actions: [
            TextButton(
              onPressed: () {
                _clearBoard();
                Navigator.of(context).pop();
              },
              child: const Text('Play Again!'),
            )
          ],
        );
      },
    );
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayExOh[i] = '';
      }
    });

    filledBoxees = 0;
  }
}
