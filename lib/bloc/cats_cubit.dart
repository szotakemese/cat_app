import 'package:cat_app/data_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/cat.dart';

class CatsCubit extends Cubit<List<Cat>> {
  final _dataService = DataService();

  CatsCubit() : super([]);

  void getCats() async => emit(await _dataService.getCats());
}