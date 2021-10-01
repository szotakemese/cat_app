// import 'package:cat_app/core/error/failures.dart';
// import 'package:cat_app/core/usecases/usecase.dart';
// import 'package:cat_app/features/cat_app/domain/entities/entities.dart';
// import 'package:cat_app/features/cat_app/domain/repositories/cat_app_repository.dart';
// import 'package:dartz/dartz.dart';
// import 'package:equatable/equatable.dart';

// class SetFav implements UseCase<void, NoParams> {
//   final CatAppRepository catAppRepository;

//   SetFav(this.catAppRepository);

//   @override
//   Future<Either<Failure, List<Cat>>> call(int page) async {
//     return await catAppRepository.setFav(page);
//   }
// }

// class NoParams extends Equatable {
//   final int number;

//   NoParams({required this.number}) : super();

//   @override
//   List<Object> get props => [number];
// }
