import 'dart:io';

String readJson(String name) {
  var dir = Directory.current.path;

  if (dir.endsWith('movie')) {
    return File('$dir/movie/$name').readAsStringSync();
  }
  return File('$dir/test/$name').readAsStringSync();
}
