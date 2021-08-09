import 'package:cat_app/data_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cat_app/models/cat.dart';

class CatsCubit extends Cubit<List<Cat>> {
  final _dataService = DataService();

  CatsCubit() : super([]);

  void getAllCats() async => emit(await _dataService.getAllCats());

  void getFavCats() async => emit(await _dataService.getFavCats());
} 