import 'package:firebase_app/controller/score_controller.dart';
import 'package:firebase_app/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScoreApp extends StatelessWidget {
  const ScoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context)=> ScoreController()),
    ],
    child: MaterialApp(
      title: "Score App",
      home: const HomeView(),
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white
      ),
    ),
    );
  }
}
