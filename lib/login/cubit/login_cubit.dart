import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authenticationRepository) : super(const LoginState());

  final AuthenticationRepository _authenticationRepository;

  Future<void> logInWithGoogle() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _authenticationRepository.logInWithGoogle();
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on Exception catch (e) {
      if(e is LogInWithGoogleFailure){
        print('EXCEPTION: $e}');
      }
      emit(state.copyWith(status: FormzStatus.submissionFailure, error: e));
    } on NoSuchMethodError {
      emit(state.copyWith(status: FormzStatus.pure));
    }
  }

  Future<void> logInWithFacebook() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _authenticationRepository.logInWithFacebok();
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on Exception catch (e) {
      if(e is LogInWithFacebookFailure){
        print('EXCEPTION: $e');
      }
      emit(state.copyWith(status: FormzStatus.submissionFailure, error: e));
    } on NoSuchMethodError {
      emit(state.copyWith(status: FormzStatus.pure));
    }
  }
}
