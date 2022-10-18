import 'package:dartzmq/dartzmq.dart';
import 'package:netlogger/driver.dart' as driver;
import 'package:netlogger/args.dart';

void main(List<String> args) async {
  const name = 'Netlogger';

  print('$name Running\n');

  Configuration c = Configuration(args);
  c.pp();

  List<String?> content;

  if (c.from != null && !(c.from as String).contains('stdin')) {
    content = (await driver.getContentFromFile(c.from as String)).split('\n');
  } else {
    content = driver.getContentFromStdin();
  }

  if (c.target != null) {
    if ((c.target as String).contains('file://')) {
      driver.writeStringInFile(
          content.fold(
              "",
              (value, element) =>
                  value == "" ? "$element" : "$value\n$element"),
          c.target as String);
    } else {
      final ctx = ZContext();
      final pushSock = driver.createSocket(ctx, c.target as String);
      for (var element in content) {
        if (element != null) {
          driver.writeStringInSocket(pushSock, element);
        }
      }
      driver.closeSockets([pushSock]);
    }
  }

  print('Done...');
}
