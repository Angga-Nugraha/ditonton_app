part of 'components_helper.dart';

Widget showDuration(int runtime) {
  final int hours = runtime ~/ 60;
  final int minutes = runtime % 60;

  if (hours > 0) {
    return Text(
      '${hours}h ${minutes}m',
      style: const TextStyle(fontSize: 10),
    );
  } else {
    return Text(
      '${minutes}m',
      style: const TextStyle(fontSize: 10),
    );
  }
}
