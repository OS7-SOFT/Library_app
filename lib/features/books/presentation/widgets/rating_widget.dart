import 'package:flutter/material.dart';

class RatingWidget extends StatelessWidget {
  final dynamic averageRating;
  final dynamic ratingCount;
  final double size;
  final bool isCenter;
  const RatingWidget(
      {Key? key,
      required this.averageRating,
      this.ratingCount,
      this.size = 15,
      this.isCenter = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isCenter ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: averageRating != null
          ? [
              Row(children: stars(averageRating, size)),
             const SizedBox(
                width: 5,
              ),
              Text("($ratingCount)")
            ]
          : [],
    );
  }

  //Add stars
  List<Icon> stars(dynamic count, size) {
    List<Icon> stars = [];
    for (var i = 1; i <= 5; i++) {
      if (count >= i) {
        stars.add(Icon(
          Icons.star,
          color: Colors.orange,
          size: size,
        ));
        //Check if count is contains .5 then add star half
        if (stars.length == double.parse(count.toString()[0]) &&
            count.toString().contains('.')) {
          stars.add(Icon(
            Icons.star_half,
            color: Colors.orange,
            size: size,
          ));

          i++;
        }
      } else {
        stars.add(
          Icon(
            Icons.star_border,
            color: Colors.grey,
            size: size,
          ),
        );
      }
    }
    return stars;
  }
}
