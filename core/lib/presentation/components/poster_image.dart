part of 'components_helper.dart';

Widget buildCardImage(String poster, {double? screenWidth}) {
  return CachedNetworkImage(
    imageUrl: '$baseImageUrl$poster',
    width: screenWidth,
    placeholder: (context, url) => const Center(
      child: CircularProgressIndicator(),
    ),
    errorWidget: (context, url, error) => const Icon(Icons.error),
  );
}
