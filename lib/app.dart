import 'package:flutter/material.dart';
import 'package:liveapp/screen/match_list_screen.dart';

class LiveApp extends StatelessWidget {
  const LiveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MatchListScreen(),
    );
  }
}
