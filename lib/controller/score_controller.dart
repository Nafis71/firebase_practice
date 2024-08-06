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
  @override
  void dispose() {
    _cricketSubscription?.cancel();
    super.dispose();
  }
}
