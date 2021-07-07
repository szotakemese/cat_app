import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/cat_facts/cat_facts.dart';

import '../models/models.dart';
import '../widgets/widgets.dart';

class CatDetailScreen extends StatelessWidget {
  final Cat cat;

  const CatDetailScreen({Key? key, required this.cat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ID: ' + cat.id),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
                tag: cat.id,
                child: Image.network(
                  cat.url,
                  fit: BoxFit.fitWidth,
                )),
            Container(
              child: BlocBuilder<CatFactsBloc, CatFactsState>(
                  builder: (context, state) {
                if (state is LoadingCatFactsState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is LoadedCatFactsState) {
                  return CatFactWidget(state);
                } else if (state is FailedLoadCatFactsState) {
                  return Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Center(
                      child: Text(
                        'Error occured: ${state.error}',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
