import 'package:flutter/material.dart';

import '../models/cat.dart';

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
              alignment: Alignment.bottomCenter,
              child: Text(
                'CAT\'S DETAILS...',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
