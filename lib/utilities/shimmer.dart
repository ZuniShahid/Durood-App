import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../constants/circle_image.dart';

class ShimmerAnnouncementCard extends StatelessWidget {
  const ShimmerAnnouncementCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
                color: Colors.white,
                border: Border.all(color: Colors.green),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 3),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: Colors.grey, // Shimmer color
                      ),
                      child: const Text(
                        'New',
                        style:
                            TextStyle(fontSize: 8, color: Colors.transparent),
                      ),
                    ),
                  ),
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleImage(
                        imageUrl: '',
                      ),
                      SizedBox(width: 16),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Loading...',
                              style: TextStyle(
                                fontSize: 16, // Adjust the size as needed
                                color: Colors.transparent, // Shimmer color
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Loading...',
                              style: TextStyle(
                                fontSize: 14, // Adjust the size as needed
                                color: Colors.transparent, // Shimmer color
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Loading...',
                        style: TextStyle(
                          fontSize: 14, // Adjust the size as needed
                          color: Colors.transparent, // Shimmer color
                        ),
                      ),
                      SizedBox(width: 30),
                      Text(
                        'Loading...',
                        style: TextStyle(
                          fontSize: 14, // Adjust the size as needed
                          color: Colors.transparent, // Shimmer color
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
