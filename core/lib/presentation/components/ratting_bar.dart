part of "components_helper.dart";

Widget buildRattingBar(double average) {
  return Row(
    children: [
      RatingBarIndicator(
        rating: average / 2,
        itemCount: 5,
        itemBuilder: (context, index) => const Icon(
          Icons.star,
          color: kMikadoYellow,
        ),
        itemSize: 10,
      ),
      Text(
        '$average',
        style: const TextStyle(fontSize: 8),
      ),
    ],
  );
}
