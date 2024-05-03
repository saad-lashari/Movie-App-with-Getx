import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: OutlinedButton(
            onPressed: () {
              downloadMedia(' https://www.youtube.com/watch?v=JENDBXIfWWM');
            },
            child: Text('Get Me')),
      ),
    );
  }
}

Future<String> downloadMedia(String url) async {
  log('message');
  final response = await http.get(Uri.parse(url));
  log('start');
  if (response.statusCode == 200) {
    log('here==>');
    final directory = await getApplicationDocumentsDirectory();
    final filename = Uri.parse(url).pathSegments.last; // Extract filename
    final file = File('${directory.path}/$filename');
    await file.writeAsBytes(response.bodyBytes);
    return file.path; // Return the local file path
  } else {
    log('failed');
    throw Exception('Failed to download media');
  }
}
