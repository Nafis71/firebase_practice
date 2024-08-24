import 'package:firebase_app/controller/score_controller.dart';
import 'package:firebase_app/views/widgets/score_update.dart';
import 'package:flutter/material.dart';

import '../../models/cricket_model.dart';

class ScoreCard extends StatelessWidget {
  final int index;
  final ScoreController scoreController;

  const ScoreCard(
      {super.key, required this.index, required this.scoreController});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  child: Image.network(
                    scoreController.cricketMatches[index].team1Pic!,
                    width: 50,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Text(
                        scoreController.cricketMatches[index].team1Score
                            .toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        scoreController.cricketMatches[index].team1Name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
                const Expanded(
                  child: Text(
                    textAlign: TextAlign.center,
                    "VS",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  child: Image.network(
                    scoreController.cricketMatches[index].team2Pic!,
                    width: 50,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Text(
                        scoreController.cricketMatches[index].team2Score
                            .toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        scoreController.cricketMatches[index].team2Name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Current Over : ${scoreController.cricketMatches[index].currentOver}",
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      "Total Over : ${scoreController.cricketMatches[index].totalOver}",
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: () {
                    showAlertDialog(
                      cricketMatches: scoreController.cricketMatches[index],
                      mainContext: context,
                    );
                  },
                  child: const Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void showAlertDialog(
      {required BuildContext mainContext,
      required CricketModel cricketMatches}) {
    showDialog(
      context: mainContext,
      builder: (context) {
        TextEditingController team1ScoreTEController = TextEditingController();
        TextEditingController team2ScoreTEController = TextEditingController();
        TextEditingController currentOverTEController = TextEditingController();
        TextEditingController totalOverTEController = TextEditingController();
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text("Update Score"),
          content: SizedBox(
            height: 350,
            child: SingleChildScrollView(
              child: ScoreUpdate(
                team1Score: cricketMatches.team1Score.toString(),
                team2Score: cricketMatches.team2Score.toString(),
                team1Name: cricketMatches.team1Name,
                team2Name: cricketMatches.team2Name,
                currentOver: cricketMatches.currentOver.toString(),
                totalOver: cricketMatches.totalOver.toString(),
                team1ScoreTEController: team1ScoreTEController,
                team2ScoreTEController: team2ScoreTEController,
                currentOverTEController: currentOverTEController,
                totalOverTEController: totalOverTEController,
              ),
            ),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                  foregroundColor: Colors.blue,
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16)),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              style: TextButton.styleFrom(
                  foregroundColor: Colors.blue,
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16)),
              onPressed: () {
                updateMatchInfo(
                    matchId: cricketMatches.matchId.toString(),
                    team1Score: team1ScoreTEController.text,
                    team2Score: team2ScoreTEController.text,
                    currentOver: currentOverTEController.text,
                    totalOver: totalOverTEController.text,
                    context: mainContext);
                Navigator.pop(context);
              },
              child: const Text("Update"),
            ),
          ],
        );
      },
    );
  }

  Future<void> updateMatchInfo(
      {required String matchId,
      required String team1Score,
      required String team2Score,
      required String currentOver,
      required String totalOver,
      required BuildContext context}) async {
    bool status = await scoreController.updateMatchInfo(
      matchId: matchId,
      team1Score: team1Score,
      team2Score: team2Score,
      currentOver: currentOver,
      totalOver: totalOver,
    );
    if (status && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Successfully updated"),
        ),
      );
      return;
    }
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to update"),
        ),
      );
    }
  }
}
