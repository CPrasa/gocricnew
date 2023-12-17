import 'dart:ui';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String team1Name;
  final String team2Name;
  final String team1Score1;
  final String team2Score1;
  final String team1Overs1;
  final String team2Overs1;

  final String team1Score2;
  final String team2Score2;
  final String team1Overs2;
  final String team2Overs2;

  final String status;
  final String commentary;

  const ProductCard({
    Key? key,
    required this.team1Name,
    required this.team2Name,
    required this.team1Overs1,
    required this.team2Overs1,
    required this.team1Score1,
    required this.team2Score1,
    required this.team1Overs2,
    required this.team2Overs2,
    required this.team1Score2,
    required this.team2Score2,
    required this.status,
    required this.commentary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: SizedBox(
        width: double.infinity,
        child: Card(
          color: Colors.deepPurple.shade500,
          elevation: 10,
          shadowColor: Colors.black,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 10,
                sigmaY: 10,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          status,
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildTeamInfo(context, team1Name),
                        _buildScoreInfo(context, team1Score1, team1Overs1,
                            team1Score2, team1Overs2),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildTeamInfo(context, team2Name),
                        _buildScoreInfo(context, team2Score1, team2Overs1,
                            team2Score2, team2Overs2),
                      ],
                    ),
                    Text(
                      commentary,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTeamInfo(BuildContext context, String teamName) {
    return Column(
      children: [
        Text(
          teamName,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ],
    );
  }

  Widget _buildScoreInfo(BuildContext context, String score1, String overs1,
      String score2, String overs2) {
    return Center(
      child: Container(
        padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(
                  score1,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Text(
                  score2,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  overs1,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  overs2,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
