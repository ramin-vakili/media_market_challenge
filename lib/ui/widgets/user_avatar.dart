import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// A widget which takes the url of an avatar image and shows it.
class UserAvatar extends StatelessWidget {
  const UserAvatar({
    required this.avatarUrl,
    this.width = 46,
    this.height = 46,
    Key? key,
  }) : super(key: key);

  final String avatarUrl;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) => CachedNetworkImage(
        imageUrl: avatarUrl,
        fit: BoxFit.cover,
        width: width,
        height: height,
        imageBuilder: (_, ImageProvider imageProvider) => CircleAvatar(
          foregroundImage: imageProvider,
        ),
      );
}
