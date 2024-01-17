// product_card.dart
import 'package:flutter/material.dart';
import 'card.dart'; // Import the necessary file, adjust as needed

class CustomProductCard extends StatelessWidget {
  final Map<String, dynamic> eventData;

  CustomProductCard({required this.eventData});

  @override
  Widget build(BuildContext context) {
    return ProductCard(
      team1Name: eventData['T1'][0]['Nm'],
      team2Name: eventData['T2'][0]['Nm'],
      team1Overs1:
          eventData['Tr1CO1'] != null ? '(${eventData['Tr1CO1']})' : '',
      team1Overs2:
          eventData['Tr1CO2'] != null ? '(${eventData['Tr1CO2']})' : '',
      team1Score1: eventData['Tr1C1'] != null
          ? '${eventData['Tr1C1'].toString()}/${eventData['Tr1CW1'].toString()}'
          : 'yet to bat',
      team1Score2: eventData['Tr1C2'] != null
          ? '${eventData['Tr1C2'].toString()}/${eventData['Tr1CW2'].toString()}'
          : '',
      team2Score1: eventData['Tr2C1'] != null
          ? '${eventData['Tr2C1'].toString()}/${eventData['Tr2CW1'].toString()}'
          : 'yet to bat',
      team2Score2: eventData['Tr2C2'] != null
          ? '${eventData['Tr2C2'].toString()}/${eventData['Tr2CW2'].toString()}'
          : '',
      team2Overs1:
          eventData['Tr2CO1'] != null ? '(${eventData['Tr2CO1']})' : '(0.0)',
      team2Overs2: eventData['Tr2C2'] != null
          ? '(${eventData['Tr2C1'].toString()}/${eventData['Tr2CW1'].toString()})'
          : '',
      status:
          '${eventData['EtTx']} (${eventData['ErnInf']})\n${eventData['EpsL']}',
      commentary: eventData['ECo'],
    );
  }
}
