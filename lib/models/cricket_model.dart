import 'package:cloud_firestore/cloud_firestore.dart';

class CricketModel{
  int? team1Score;
  int? team2Score;
  String? team1Pic;
  String? team2Pic;
  String? matchId;
  double? currentOver, totalOver;


  CricketModel.fromFireStore(QueryDocumentSnapshot documentSnapshot){
    matchId = documentSnapshot.id;
    team1Score = documentSnapshot['team1'];
    team2Score = documentSnapshot['team2'];
    team1Pic = documentSnapshot['team1Pic'];
    team2Pic = documentSnapshot['team2Pic'];
    currentOver = double.tryParse(documentSnapshot['currentOver'].toString());
    totalOver = double.tryParse(documentSnapshot['totalOver'].toString());
  }

  String get team1Name => matchId!.split("vs").first;
  String get team2Name => matchId!.split("vs").last;
}