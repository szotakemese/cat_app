class Favourite {
  final String imageId;
  final String subId;
  Favourite({
    required this.imageId,
    required this.subId,
  });

  factory Favourite.fromJson(Map<String, dynamic> json) => Favourite(
        imageId: json['image_id'],
        subId: json['sub_id'],
      );
}
