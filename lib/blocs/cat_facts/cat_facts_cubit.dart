import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cat_app/models/models.dart';

class CatFactsCubit extends Cubit<CatFact?> {
  final dataService;

  CatFactsCubit(this.dataService) : super(null);

  void getFact() async => emit(await dataService.getFact());
}
