import 'package:args/args.dart';

class Configuration {
  String? target;
  String? from;
  String? filters;
  int size = 0;
  bool verbose = false;

  pp() {
    print('''
Used configuration:
  Targeted socket [target: $target]
  From source [from: $from]
  Irrelevant filtered pattern [filters: $filters]
  Irrevevant messages size [size: $size]
  Log level [verbose: $verbose]
''');
  }

  Configuration(List<String> args) {
    var parser = ArgParser();

    parser.addFlag(
      "verbose",
      abbr: 'v',
      defaultsTo: false,
      callback: (v) => verbose = v,
      help: 'Display many logs',
    );

    parser.addOption("target",
        abbr: 't',
        mandatory: true,
        // defaultsTo: 'tcp://localhost:4200',
        callback: (v) => target = v,
        help: 'Targeted socket',
        valueHelp: 'ADDR_SOCKS');

    parser.addOption("from",
        abbr: 'f',
        mandatory: false,
        defaultsTo: 'stdin',
        callback: (v) => from = v,
        help: 'Read from ? (stdin | ADDR_SOCKS)',
        valueHelp: 'stdin | ADDR_SOCKS');

    parser.addOption("filter",
        abbr: 'l',
        mandatory: false,
        defaultsTo: null,
        callback: (v) => filters = v,
        help: 'Filter matching strings',
        valueHelp: 'REGEX');

    parser.addOption("size",
        abbr: 's',
        mandatory: false,
        defaultsTo: "0",
        callback: (v) => {
              if (v != null) {size = int.parse(v)}
            },
        help: 'Minimum size, if less, log will be ignored',
        valueHelp: 'INTEGER');

    parser.parse(args);
  }
}
