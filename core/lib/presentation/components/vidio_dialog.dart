part of 'components_helper.dart';

Future<dynamic> buildVideoDialog(BuildContext context, Video video) {
  return showDialog(
  barrierDismissible: false,
  barrierColor: Colors.black.withOpacity(0.8),
    context: context,
    builder: (context) {
      return Dialog(
        insetPadding: EdgeInsets.zero,
        backgroundColor: Colors.white.withOpacity(0.5),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4.0),
              child: video.results.isNotEmpty
                  ? VideoScreen(video: video)
                  : const SizedBox(
                      height: 100,
                      child: Center(
                        child: Text("Vidio not found"),
                      ),
                    ),
            ),
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                  SystemChrome.setPreferredOrientations(
                      DeviceOrientation.values);
                },
                icon: const Icon(Icons.close))
          ],
        ),
      );
    },
  );
}
