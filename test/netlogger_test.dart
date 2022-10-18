import 'dart:io';

import 'package:dartzmq/dartzmq.dart';
import 'package:netlogger/driver.dart' as driver;
import 'package:test/test.dart';

void main() {
  test('getContentFromFile', () async {
    const testPath = './assets/test_file.txt';
    var c = await driver.getContentFromFile(testPath);
    expect(c, [116, 101, 115, 116, 95, 115, 116, 114, 105, 110, 103, 59]);
  });

  test('getContentFromStdin', () async {
    var c = driver.getContentFromStdin();
    expect(c, 'Instance of \'Stdin\'');
  });

  test('writeStringInFile', () async {
    const testPath = './assets/test_target.txt';
    var flag = true;
    try {
      driver.writeStringInFile('test_string;', testPath);
      flag = true;
    } on Error {
      flag = false;
    }
    expect(flag, true);
  });

  test('writeStringInSocket', () async {
    const testSock = 'ipc://_test/test';
    const content = 'test_string';
    var readContent = '';
    final ctx = ZContext();
    final pull = ctx.createSocket(SocketType.pull);
    final push = driver.createSocket(ctx, testSock);
    pull.messages.listen((event) => readContent += event.toString());

    var flag = true;
    try {
      driver.writeStringInSocket(push, content);
      sleep(Duration(seconds: 2));
      print(readContent);
      flag = content == readContent;
    } on Error {
      print('Error');
      flag = false;
    }

    driver.closeSockets([push, pull]);
    expect(flag, true);
  });
}
