import 'dart:io';

import 'package:dartzmq/dartzmq.dart';
import 'package:netlogger/driver.dart' as driver;
import 'package:test/test.dart';

void main() {
  test('getContent', () async {
    const testPath = './assets/test_file.txt';
    var c = await driver.getContent(testPath);
    expect(c, [116, 101, 115, 116, 95, 115, 116, 114, 105, 110, 103, 59]);
  });

  test('writeInFile', () async {
    const testPath = './assets/test_target.txt';
    var flag = true;
    try {
      driver.writeContentInFile('test_string;', testPath);
      flag = true;
    } on Error {
      flag = false;
    }
    expect(flag, true);
  });

  test('writeString', () async {
    const testSock = 'ipc://_test/test';
    const content = 'test_string';
    var readContent = '';
    final ctx = ZContext();
    final pull = ctx.createSocket(SocketType.pull);
    pull.messages.listen((event) => readContent += event.toString());

    var flag = true;
    try {
      driver.writeString(ctx, content, testSock);
      sleep(Duration(seconds: 2));
      print(readContent);
      flag = content == readContent;
    } on Error {
      print('Error');
      flag = false;
    }
    expect(flag, true);
  });
}
