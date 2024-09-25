import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../shared/components.dart';

class PostsShimmerItem extends StatelessWidget {
  const PostsShimmerItem({super.key, required this.height});

  final int height;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              const CircleAvatar(
                backgroundColor: Colors.grey,
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 15,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    height: 10,
                    width: 70,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(15)),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Card(
          color: HexColor('1E1C1C'),
          margin: const EdgeInsets.symmetric(horizontal: 8),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: height.toDouble()),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
