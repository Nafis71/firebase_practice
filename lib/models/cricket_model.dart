import 'package:cloud_firestore/cloud_firestore.dart';

class CricketModel{
  String? matchName;
  int? team1Score;
  int? team2Score;

  CricketModel({required this.matchName, required this.team1Score, required this.team2Score});

  CricketModel.fromFireStore(QueryDocumentSnapshot documentSnapshot){
    matchName = documentSnapshot.id;
    team1Score = documentSnapshot['team1'];
    team2Score = documentSnapshot['team2'];
  }

  String get team1Name => matchName!.split("vs").first;
  String get team2Name => matchName!.split("vs").last;
}