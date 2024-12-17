import 'package:flutter/material.dart';
import 'package:liveapp/entities/football.dart';

class FootBallScoreCard extends StatelessWidget {
  const FootBallScoreCard({
    super.key, required this.football,
  });
  final Football football;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildTeamName(football.team1name,football.team1Score),
            Text('vs'),
            _buildTeamName(football.team2name,football.team2Score)
          ],
        ),
      ),
    );
  }

  Column _buildTeamName(String teamName,int score) {
    return Column(
            children: [
              Text(score.toString(),style: TextStyle(
                  fontSize: 24,fontWeight: FontWeight.w600
              ),),
              Text(teamName,style: TextStyle(
                  fontSize: 18,fontWeight: FontWeight.w400
              ),),
            ],
          );
  }
}