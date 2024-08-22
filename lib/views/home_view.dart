import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/controller/score_controller.dart';
import 'package:firebase_app/views/widgets/score_card.dart';
import 'package:firebase_app/views/widgets/score_update.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    context.read<ScoreController>().listenToCricketMatch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text(
          "CricBuzz",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        surfaceTintColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.blue,
          child: Column(
            children: [
              Consumer<ScoreController>(builder: (_, scoreController, __) {
                if (scoreController.cricketMatches.isEmpty) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: scoreController.cricketMatches.length,
                  itemBuilder: (context, index) {
                    return ScoreCard(
                      index: index,
                      scoreController: scoreController,
                    );
                  },
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
