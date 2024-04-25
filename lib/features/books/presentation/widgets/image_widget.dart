import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  final String? url;
  final double width;
  final double height;
  const ImageWidget({Key? key,required this.url,required this.width,required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.all(2),
      child: CachedNetworkImage(
        width: width,
        height: height,
        fit: BoxFit.fitWidth,
        placeholder: (context, url) => Image.asset("images/placeholder.jpg"),
        imageUrl: url!,
        errorWidget: (context, url, _) =>
            Image.asset("images/placeholder.jpg"),
      ),
    );
  }
}
