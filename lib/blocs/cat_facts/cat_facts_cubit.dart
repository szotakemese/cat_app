import '../../data_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/models.dart';

class CatFactsCubit extends Cubit<CatFact?> {
  final _dataService = DataService();

  CatFactsCubit() : super(null);

  void getFact() async => emit(await _dataService.getFact());
}
