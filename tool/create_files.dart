import 'dart:io';

main() {
  List<String> imports = [];

  for (int folderId = 0; folderId < 100; folderId++) {
    new Directory('lib/$folderId').createSync(recursive: true);

    for (int fileId = 0; fileId < 50; fileId++) {
      new File('lib/$folderId/$fileId.dart').writeAsStringSync('''
class A_${folderId}_$fileId {}
''');
      imports.add("import 'package:slow_pub_serve/$folderId/$fileId.dart';");
    }
  }

  String entryPoint = imports.join('\n');
  entryPoint += '''

import 'dart:html';
main() {
  document.body.innerHtml = 'Loaded';
}
''';

  new File('web/main.dart').writeAsStringSync(entryPoint);
}
