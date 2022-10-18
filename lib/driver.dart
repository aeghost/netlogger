import 'dart:io';
import 'package:dartzmq/dartzmq.dart';

Future<String> getContentFromFile(String path) async {
  var content = File(path).readAsString();
  return await content;
}

List<String> getContentFromStdin() {
  List<String> lines = [];
  while (true) {
    var line = stdin.readLineSync();
    if (line == null) {
      break;
    }
    lines.add(line);
  }
  var content = lines;
  return content;
}

void writeStringInFile(String content, String path) async {
  await File(path).writeAsString(content);
  return;
}

void writeStringInSocket(ZSocket sock, String content) async {
  sock.sendString(content);
}

ZSocket createSocket(ZContext ctx, String path) {
  final pushSocket = ctx.createSocket(SocketType.push);
  pushSocket.connect(path);
  return pushSocket;
}

void closeSockets(List<ZSocket> lsock) {
  for (var element in lsock) {
    element.close();
  }
}

// String mapContent()
// var readContent = '';
//     final ctx = ZContext();
//     final pull = ctx.createSocket(SocketType.pull);
//     pull.messages.listen((event) => readContent += event.toString());
