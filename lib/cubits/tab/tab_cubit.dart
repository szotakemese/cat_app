import 'package:bloc/bloc.dart';
import 'tab.dart';

class TabCubit extends Cubit<AppTab> {
  TabCubit() : super(AppTab.all);

  void updateTab(AppTab tab) {
    emit(tab);
  }
}
