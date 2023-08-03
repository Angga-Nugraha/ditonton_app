part of 'components_helper.dart';

Future<dynamic> buildDialog(BuildContext context, String content) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Text(content),
      );
    },
  );
}
