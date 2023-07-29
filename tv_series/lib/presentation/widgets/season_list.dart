import 'package:cached_network_image/cached_network_image.dart';
import 'package:tv_series/domain/entities/tv_detail.dart';
import 'package:core/utils/routes.dart';
import 'package:flutter/material.dart';

class SeasonList extends StatelessWidget {
  const SeasonList({
    Key? key,
    required this.tvDetail,
  }) : super(key: key);

  final TvDetail tvDetail;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        var poster = tvDetail.seasons[index].posterPath;
        return SizedBox(
          height: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                flex: 4,
                child: SizedBox(
                  height: 150,
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, seasonTvRoutes, arguments: [
                        tvDetail.id,
                        tvDetail.seasons[index].seasonNumber
                      ]);
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CachedNetworkImage(
                        imageUrl: 'https://image.tmdb.org/t/p/w500$poster',
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: 100,
                  child: Text(
                    tvDetail.seasons[index].name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        );
      },
      itemCount: tvDetail.seasons.length,
    );
  }
}
