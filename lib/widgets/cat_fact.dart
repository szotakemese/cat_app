import 'package:cat_app/blocs/cats_list/cats_state.dart';
import 'package:flutter/material.dart';

class CatFactWidget extends StatelessWidget {
  final CatsState state;
  final int index;
  const CatFactWidget(this.state, this.index);
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
            state.facts[index].fact,
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
