import 'dart:io';

class FileStorage {
  Future<String> readFile(Directory dir) async {
    var file = new File('${dir.path}/file.txt');
    return file.readAsString();
  }

  Future<File> writeFile(Directory dir, String data) async {
    var file = new File('${dir.path}/file.txt');
    return file.writeAsString(data);
  }
}