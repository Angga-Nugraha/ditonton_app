import 'package:core/core.dart';
import 'package:tv_series/domain/entities/tv.dart';
import 'package:flutter/material.dart';

class TVCard extends StatelessWidget {
  final Tv tv;

  const TVCard(this.tv, {super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: kRichBlack,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              tvDetailRoutes,
              arguments: tv.id,
            );
          },
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Card(
                child: Container(
                  margin: const EdgeInsets.only(
                    left: 16 + 80 + 16,
                    bottom: 8,
                    right: 8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tv.name ?? '-',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: kHeading6,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        tv.overview ?? '-',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 16,
                  bottom: 16,
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  child: buildCardImage(tv.posterPath!, screenWidth: 80),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
