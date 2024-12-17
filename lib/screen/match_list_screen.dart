import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:liveapp/entities/football.dart';
import 'package:liveapp/widget/football_score_card.dart';
class MatchListScreen extends StatefulWidget {
  const MatchListScreen({super.key});

  @override
  State<MatchListScreen> createState() => _MatchListScreenState();
}

class _MatchListScreenState extends State<MatchListScreen> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  List<Football>matchList = [];

  Future<void> _getFootBallMatches() async {
    matchList.clear();
    final QuerySnapshot result = await firebaseFirestore.collection('Football')
        .get();
    for (QueryDocumentSnapshot doc in result.docs) {
      matchList.add(
        Football(
          matchName: doc.id,
          team1name: doc.get('team1name'),
          team2name: doc.get('team2name'),
          team1Score: doc.get('Team1'),
          team2Score: doc.get('Team2'),
        ),);
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getFootBallMatches();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FootBall"),
        backgroundColor: Colors.blue,
      ),
      body: StreamBuilder(
          stream: firebaseFirestore.collection('football').snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }

            if (snapshot.hasData == false) {
              return const Center(
                child: Text('Empty list'),
              );
            }
            matchList.clear();
            for (QueryDocumentSnapshot doc in snapshot.data?.docs ?? []) {
              matchList.add(
                Football(
                  matchName: doc.id,
                  team1name: doc.get('team1Name'),
                  team2name: doc.get('team2Name'),
                  team1Score: doc.get('team1'),
                  team2Score: doc.get('team2'),
                ),
              );
            }

            return ListView.builder(
              itemCount: matchList.length,
              itemBuilder: (context, index) {
                return FootBallScoreCard(
                  football: matchList[index],
                );
              },
            );
          }),
    );
  }
}
