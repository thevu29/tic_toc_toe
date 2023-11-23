import 'package:flutter/material.dart';
import 'package:tic_toc_toe/ui/theme/color.dart';
import 'package:tic_toc_toe/utils/game_logic.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Toc Toe',
      home: GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  String lastValue = "X";
  bool gameOver = false;
  int turn = 0;
  String result = "";
  List<int> scoreBoard = [0, 0, 0, 0, 0, 0, 0, 0];

  Game game = Game();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    game.board = Game.initGameBoard();
    print(game.board);
  }

  @override
  Widget build(BuildContext context) {
    double boardWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: MainColor.primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Lượt của ${lastValue}",
            style: TextStyle(
                color: Colors.white,
                fontSize: 58
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            width: boardWidth,
            height: boardWidth,
            child: GridView.count(
              crossAxisCount: Game.boardLength ~/ 3,
              padding: EdgeInsets.all(16.0),
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              children: List.generate(Game.boardLength, (index) {
                return InkWell(
                  onTap: gameOver ? null : () {
                    if (game.board![index] == "") {
                      setState(() {
                        game.board![index] = lastValue;
                        turn++;
                        gameOver = game.winnerCheck(lastValue, index, scoreBoard, 3);

                        if (gameOver) {
                          result= "$lastValue đã thắng!";
                        } else if (!gameOver && turn == 9) {
                          result = "Hòa rồi!";
                          gameOver = true;
                        }

                        if (lastValue == "X") {
                          lastValue = "O";
                        } else {
                          lastValue = "X";
                        }
                      });
                    }
                  },
                  child: Container(
                    width: Game.blockSize,
                    height: Game.blockSize,
                    decoration: BoxDecoration(
                      color: MainColor.accentColor,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Center(
                      child: Text(
                        game.board![index],
                        style: TextStyle(
                          color: game.board![index] == "X" ? Colors.yellow : Colors.pink,
                          fontSize: 64.0
                        ),
                      ),
                    ),
                  )
                );
              }),
            ),
          ),

          SizedBox(
            height: 25.0
          ),
          Text(
            result,
            style: TextStyle(
                color: Colors.white,
                fontSize: 54.0
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              setState(() {
                game.board = Game.initGameBoard();
                lastValue = "X";
                gameOver = false;
                turn = 0;
                result = "";
                scoreBoard = [0, 0, 0, 0, 0, 0, 0, 0];
              });
            },
            icon: Icon(Icons.replay),
            label: Text("Chơi lại"),
          ),
        ],
      ),
    );
  }
}
