import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  const Avatar({Key? key, required this.photo}) : super(key: key);

  final String photo;

  @override
  Widget build(BuildContext context) {
    final photo = this.photo;
    // return CircleAvatar(
    //   radius: _avatarSize,
    //   backgroundImage: photo != null ? CachedNetworkImageProvider(photo) : null,
    //   child: photo == null
    //       ? const Icon(Icons.person_outline, size: _avatarSize)
    //       : null,
    // );
    return Container(
      child: CachedNetworkImage(
        imageUrl: photo,
        imageBuilder: (context, imageProvider) => Container(
          width: 100.0,
          height: 100.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          ),
        ),
        errorWidget: (context, url, error) => Container(
          decoration: BoxDecoration(
            color: Colors.orange,
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: new Icon(
              Icons.person_outline,
              size: 90,
            ),
          ),
        ),
      ),
    );
  }
}
