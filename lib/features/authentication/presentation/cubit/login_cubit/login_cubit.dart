import 'package:bloc/bloc.dart';
import 'package:cat_app/core/error/failures.dart';
import 'package:cat_app/core/usecases/usecase.dart';
import 'package:cat_app/features/authentication/domain/usecases/log_in_with_facebook.dart';
import 'package:cat_app/features/authentication/domain/usecases/log_in_with_google.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({
    required this.logInWithGoogleUseCase,
    required this.logInWithFacebookUseCase,
  }) : super(const LoginState());

  final LogInWithGoogle logInWithGoogleUseCase;
  final LogInWithFacebook logInWithFacebookUseCase;

  Future<Either<Failure, void>> logInWithGoogle() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      final void logIn = await logInWithGoogleUseCase(NoParams());
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
      return Right(logIn);
    } on Exception catch (e) {
      emit(state.copyWith(status: FormzStatus.submissionFailure, error: e));
      return (Left(LogInWithGoogleFailure()));
    } on NoSuchMethodError {
      final void pure = emit(state.copyWith(status: FormzStatus.pure));
      return Right(pure);
    }
  }

  Future<Either<Failure, void>> logInWithFacebook() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      final void logIn = await logInWithFacebookUseCase(NoParams());
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
      return Right(logIn);
    } on Exception catch (e) {
      emit(state.copyWith(status: FormzStatus.submissionFailure, error: e));
      return (Left(LogInWithFacebookFailure()));
    } on NoSuchMethodError {
      final void pure = emit(state.copyWith(status: FormzStatus.pure));
      return Right(pure);
    }
  }
}
