import 'package:cached_network_image/cached_network_image.dart';
import 'package:cat_app/features/cat_app/domain/entities/entities.dart';
import 'package:flutter/material.dart';

class DetailImage extends StatelessWidget {
  const DetailImage({required this.additionalTag, required this.cat, Key? key})
      : super(key: key);
  final Cat cat;
  final String additionalTag;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Material(
        color: Color(0xfff0f0f0),
        child: Hero(
          tag: cat.id + additionalTag,
          child: CachedNetworkImage(
            imageUrl: cat.url,
            imageBuilder: (context, imageProvider) => Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            ),
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => new Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}
