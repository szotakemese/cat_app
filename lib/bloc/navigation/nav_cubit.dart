import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/cat.dart';

class NavCubit extends Cubit<Cat?> {
  NavCubit() : super(null);

  void showCatDetails(Cat cat) => emit(cat);

  void popToCats() => emit(null);
}