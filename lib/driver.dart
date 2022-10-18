import 'dart:io';
import 'dart:typed_data';
import 'package:dartzmq/dartzmq.dart';

Future<Uint8List> getContent(String path) async {
  var content = File(path).readAsBytes();
  return await content;
}

void writeContentInFile(String content, String path) async {
  await File(path).writeAsString(content);
  return;
}

void writeString(ZContext ctx, String content, String path) async {
  final pushSocket = ctx.createSocket(SocketType.push);
  pushSocket.connect(path);
  pushSocket.sendString(content);
  pushSocket.close();
}

// String mapContent()
// var readContent = '';
//     final ctx = ZContext();
//     final pull = ctx.createSocket(SocketType.pull);
//     pull.messages.listen((event) => readContent += event.toString());
