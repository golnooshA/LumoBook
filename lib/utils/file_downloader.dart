import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

Future<String> downloadBookFile(String url, String filename) async {
  final status = await Permission.storage.request();
  if (!status.isGranted) {
    throw Exception('Storage permission denied');
  }

  Directory? dir;

  if (Platform.isAndroid) {
    dir = await getExternalStorageDirectory(); // or getDownloadsDirectory();
  } else {
    dir = await getApplicationDocumentsDirectory();
  }

  final file = File('${dir!.path}/$filename');
  final response = await http.get(Uri.parse(url));
  if (response.statusCode != 200) throw Exception('Failed to download');

  await file.writeAsBytes(response.bodyBytes);
  return file.path;
}
