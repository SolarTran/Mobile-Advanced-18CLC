import 'package:flutter/material.dart';
import 'light_color.dart';

class RatingStarWidget extends StatefulWidget {
  final double rating;
  const RatingStarWidget({Key? key, required this.rating,}) : super(key: key);

  @override
  _RatingStarState createState() => _RatingStarState();
}

class _RatingStarState extends State<RatingStarWidget> {
  Widget _start(int index) {
    bool halfStar = false;
    if ((widget.rating * 2) % 2 != 0) {
      if (index < widget.rating && index == widget.rating - .5) {
        halfStar = true;
      }
    }

    return Icon(
      halfStar ? Icons.star_half : Icons.star,
      color: index < widget.rating ? LightColor.orange : LightColor.grey,
      size: 10,
    );
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 5),
      duration: const Duration(milliseconds: 500),
      builder: (context, value, child) {
        return Wrap(
          children: Iterable.generate(value.toInt(), (index) => _start(index))
              .toList(),
        );
      },
    );
  }
}
