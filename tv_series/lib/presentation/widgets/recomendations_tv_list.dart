import 'package:core/core.dart';
import 'package:tv_series/domain/entities/tv.dart';
import 'package:flutter/material.dart';

class RecomendationsTVList extends StatelessWidget {
  const RecomendationsTVList({Key? key, required this.recommendations})
      : super(key: key);

  final List<Tv> recommendations;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tv = recommendations[index];
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(
                  context,
                  tvDetailRoutes,
                  arguments: tv.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(8),
                ),
                child: buildCardImage(tv.posterPath!),
              ),
            ),
          );
        },
        itemCount: recommendations.length,
      ),
    );
  }
}
