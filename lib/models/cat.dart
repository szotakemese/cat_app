class Cat {
  final String id;
  final String url;
  Cat({
    required this.id,
    required this.url,
  });

  factory Cat.allCatFromJson(Map<String, dynamic> json) => Cat(
        id: json['id'],
        url: json['url'],
      );

  factory Cat.favCatFromJson(Map<String, dynamic> json) => Cat(
        id: json['image']['id'],
        url: json['image']['url'],
      );
}
