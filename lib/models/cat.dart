class Cat {
  final String id;
  final String url;
  bool isFav;
  Cat({
    required this.id,
    required this.url,
    this.isFav = false,
  });

  factory Cat.allCatFromJson(Map<String, dynamic> json) => Cat(
        id: json['id'],
        url: json['url'],
      );

  factory Cat.favCatFromJson(Map<String, dynamic> json) => Cat(
        id: json['image']['id'],
        url: json['image']['url'],
        isFav: true,
      );
}
