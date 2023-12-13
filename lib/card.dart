import 'dart:ui';

import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String team1Name;
  final String team2Name;
  final String team1Score;
  final String team2Score;
  final String team1Overs;
  final String team2Overs;

  const ProductCard({
    super.key,
    required this.team1Name,
    required this.team2Name,
    required this.team1Overs,
    required this.team2Overs,
    required this.team1Score,
    required this.team2Score,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: SizedBox(
        width: double.infinity,
        child: Card(
          elevation: 10,
          shadowColor: Colors.blueGrey,
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
                    const Text(
                      'states',
                      textAlign: TextAlign.start,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildTeamInfo(context, team1Name),
                        _buildScoreInfo(context, team1Score, team1Overs),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildTeamInfo(context, team2Name),
                        _buildScoreInfo(context, team2Score, team2Overs),
                      ],
                    ),
                    const Text('commentry')
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );

    // Container(
    //   margin: const EdgeInsets.all(20),
    //   padding: const EdgeInsets.all(16.0),
    //   decoration: BoxDecoration(
    //     color: const Color.fromARGB(255, 157, 222, 255),
    //     borderRadius: BorderRadius.circular(20),
    //   ),
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     children: [
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //         children: [
    //           _buildTeamInfo(context, team1Name),
    //           _buildVersusText(context),
    //           _buildTeamInfo(context, team2Name),
    //         ],
    //       ),
    //       const SizedBox(height: 10),
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //         children: [
    //           _buildScoreInfo(context, team1Score, team1Overs),
    //           _buildDivider(context),
    //           _buildScoreInfo(context, team2Score, team2Overs),
    //         ],
    //       ),
    //     ],
    //   ),
    // );
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

  // Widget _buildVersusText(BuildContext context) {
  //   return Text(
  //     'vs',
  //     style: Theme.of(context).textTheme.titleMedium,
  //   );
  // }

  Widget _buildScoreInfo(BuildContext context, String score, String overs) {
    return Center(
      child: Container(
        padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              score,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              '($overs)',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildDivider(BuildContext context) {
  //   return const SizedBox(
  //     height: 50,
  //     child: VerticalDivider(
  //       color: Colors.black,
  //       thickness: 1,
  //     ),
  //   );
  // }
}
