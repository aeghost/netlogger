import 'package:dartzmq/dartzmq.dart';
import 'package:netlogger/driver.dart' as driver;
import 'package:netlogger/args.dart';

void main(List<String> args) async {
  const name = 'Netlogger';

  print('$name Running\n');

  Configuration c = Configuration(args);
  c.pp();

  var content = [];

  if (c.from != null) {
    content = await driver.getContent(c.from as String);
  }

  if (content != [] && c.target != null) {
    if ((c.target as String).contains('file://')) {
      driver.writeContentInFile(content.toString(), c.target as String);
    } else {
      final ctx = ZContext();
      driver.writeString(ctx, content.toString(), c.target as String);
    }
  }

  print('Done...');
}
