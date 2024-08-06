import 'package:firebase_app/controller/score_controller.dart';
import 'package:flutter/material.dart';

class ScoreCard extends StatelessWidget {
  final int index;
  final ScoreController scoreController;
  const ScoreCard({super.key, required this.index, required this.scoreController});

  @override
  Widget build(BuildContext context) {
    return  Card(
      color: Colors.white,
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(
                  scoreController.cricketMatches[index].team1Score.toString(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(scoreController.cricketMatches[index].team1Name)
              ],
            ),
            const Text("VS",style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Column(
              children: [
                Text(
                  scoreController.cricketMatches[index].team2Score.toString(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(scoreController.cricketMatches[index].team2Name)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
