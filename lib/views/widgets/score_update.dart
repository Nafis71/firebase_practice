import 'package:flutter/material.dart';

class ScoreUpdate extends StatefulWidget {
  final String team1Score;
  final String team2Score;
  final String team1Name;
  final String team2Name;
  final String currentOver;
  final String totalOver;
  final TextEditingController team1ScoreTEController,
      team2ScoreTEController,
      currentOverTEController,
      totalOverTEController;

  const ScoreUpdate({
    super.key,
    required this.team1Score,
    required this.team2Score,
    required this.team1Name,
    required this.team2Name,
    required this.currentOver,
    required this.totalOver,
    required this.team1ScoreTEController,
    required this.team2ScoreTEController,
    required this.currentOverTEController,
    required this.totalOverTEController,
  });

  @override
  State<ScoreUpdate> createState() => _ScoreUpdateState();
}

class _ScoreUpdateState extends State<ScoreUpdate> {

  @override
  void initState() {
    widget.team1ScoreTEController.text = widget.team1Score;
    widget.team2ScoreTEController.text = widget.team2Score;
    widget.currentOverTEController.text = widget.currentOver;
    widget.totalOverTEController.text = widget.totalOver;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.team1Name),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: widget.team1ScoreTEController,
          decoration: const InputDecoration(
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(widget.team2Name),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: widget.team2ScoreTEController,
          decoration: const InputDecoration(
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text("Current Over"),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: widget.currentOverTEController,
          decoration: const InputDecoration(
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text("Total Over"),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: widget.totalOverTEController,
          decoration: const InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
            ),
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    widget.team1ScoreTEController.dispose();
    widget.team2ScoreTEController.dispose();
    widget.currentOverTEController.dispose();
    widget.totalOverTEController.dispose();
    super.dispose();
  }
}
