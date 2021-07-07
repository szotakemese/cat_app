class CatFact {
  final String fact;
  final int length;
  CatFact({
    required this.fact,
    required this.length,
  });

  factory CatFact.fromJson(Map<String, dynamic> json) => CatFact(
        fact: json['fact'],
        length: json['length'],
      );
}
