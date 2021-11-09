import 'package:cat_app/features/cat_app/presentation/cubit/cat_app_cubit.dart';
import 'package:flutter/material.dart';

class CatFactWidget extends StatelessWidget {
  final CatAppState state;
  final int index;
  const CatFactWidget(this.state, this.index);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'FACT',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 30,
              fontWeight: FontWeight.w900,
            ),
            textAlign: TextAlign.left,
          ),
          Container(
            height:  MediaQuery.of(context).size.height * 0.15,
            child: SingleChildScrollView(
              child: Text(
                state.facts[index].fact,
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.justify,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
