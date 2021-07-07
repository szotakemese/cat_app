import 'package:flutter/material.dart';

class CatFactWidget extends StatelessWidget {
  final state;
  const CatFactWidget(this.state);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'FACT',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 30,
              fontWeight: FontWeight.w900,
            ),
            textAlign: TextAlign.left,
          ),
          Text(
            state.catFact.fact,
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
