import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../models/cricket_model.dart';

class ScoreController extends ChangeNotifier {
  List<CricketModel> _cricketMatches = [];
  bool _cricketSnapshotHasData = false;
  StreamSubscription? _cricketSubscription;

  List<CricketModel> get cricketMatches => _cricketMatches;

  bool get cricketSnapShotHasData => _cricketSnapshotHasData;

  Future<void> listenToCricketMatch() async {
    try {
      FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;
      _cricketSubscription =
          firebaseFireStore.collection("cricket").snapshots().listen(
        (snapshot) {
          if (snapshot.size != 0) {
            _cricketSnapshotHasData = true;
            _cricketMatches = snapshot.docs.map((docs) {
              return CricketModel.fromFireStore(docs);
            }).toList();
          } else {
            _cricketSnapshotHasData = false;
          }
          notifyListeners();
        },
        onError: (error) {
          if (kDebugMode) {
            _cricketSnapshotHasData = false;
            debugPrint(error.toString());
          }
        },
      );
    } catch (exception) {
      if (kDebugMode) {
        debugPrint(exception.toString());
      }
    }
  }

  Future<bool> updateMatchInfo({
    required String matchId,
    required String team1Score,
    required String team2Score,
    required String currentOver,
    required String totalOver,
  }) async{
    bool finalResponse = false;
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    final reference = firebaseFirestore.collection("cricket").doc(matchId);
    Map<String,dynamic> matchData ={
      "team1" : int.parse(team1Score),
      "team2" : int.parse(team2Score),
      "currentOver" : double.parse(currentOver),
      "totalOver": double.parse(totalOver),
    };
    await reference.update(matchData).whenComplete((){
      finalResponse = true;
    });
    return finalResponse;
  }

  @override
  void dispose() {
    _cricketSubscription?.cancel();
    super.dispose();
  }
}
