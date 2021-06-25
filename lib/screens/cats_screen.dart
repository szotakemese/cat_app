import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cats_cubit.dart';
import '../models/cat.dart';

// import '../data_service.dart';

class CatsScreen extends StatefulWidget {
  @override
  _CatsScreenState createState() => _CatsScreenState();
}

class _CatsScreenState extends State<CatsScreen> {
  // final _dataService = DataService();
  // var _response;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cats'),
      ),
      body: BlocBuilder<CatsCubit, List<Cat>>(
        builder: (context, cats) {
          if (cats.isEmpty) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: cats.length,
            itemBuilder: (context, index) {
              return Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: ListTile(
                      leading: Container(
                        width: 60,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(cats[index].url),
                          ),
                        ),
                        //child: FittedBox(child: Image.network(cats[index].url,), fit: BoxFit.cover,),
                      ),
                      title: Text(cats[index].id),
                    ),
                  ),
              );
            },
          );
        },
      ),
    );
  }

  // void _makeRequest() async {
  //   final response = await _dataService.getCats();
  //   setState(() {
  //     _response = response;
  //   });
  // }
}
