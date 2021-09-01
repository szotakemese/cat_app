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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'url': url,
      'isFav': isFav ? 1 : 0,
    };
  }

  @override
  String toString() {
    return 'Cat{id: $id, url: $url, isFav: $isFav}';
  }
}
