import 'package:equatable/equatable.dart';

class CatFact extends Equatable {
  final String fact;
  final int length;

  CatFact({
    required this.fact,
    required this.length,
  });

  Map<String, dynamic> toMap() {
    return {
      'fact': fact,
      'length': length,
    };
  }

  @override
  List<Object?> get props => [
        fact,
        length,
      ];
}
