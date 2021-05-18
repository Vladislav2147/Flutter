import 'package:databases/db/filestorage.dart';
import 'package:databases/db/hiveorm.dart';
import 'package:databases/filewidget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';

import 'datawidget.dart';


class FileStoragePage extends StatefulWidget {
  @override
  _FileStoragePageState createState() => _FileStoragePageState();
}

class _FileStoragePageState extends State<FileStoragePage> {
  final textController = TextEditingController();
  final fileStorage = FileStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("File Storage")),
      body: Column(
        children: [
          TextField(
            controller: textController,
            style: TextStyle(fontSize: 22),
            decoration: InputDecoration(
              hintText: 'Data',
            ),
          ),
          FileWidget(
              writeFunc: () async {
                fileStorage.writeFile(await getTemporaryDirectory(), textController.text);
              },
              readFunc: () async {
                textController.text = await fileStorage.readFile(await getTemporaryDirectory());
              },
              text: 'Temp Dir:'
          ),
          FileWidget(
              writeFunc: () async {
                fileStorage.writeFile(await getApplicationDocumentsDirectory(), textController.text);
              },
              readFunc: () async {
                textController.text = await fileStorage.readFile(await getApplicationDocumentsDirectory());
              },
              text: 'App docs Dir:'
          ),
          FileWidget(
              writeFunc: () async {
                fileStorage.writeFile(await getApplicationSupportDirectory(), textController.text);
              },
              readFunc: () async {
                textController.text = await fileStorage.readFile(await getApplicationSupportDirectory());
              },
              text: 'App support Dir:'
          ),
          FileWidget(
              writeFunc: () async {
                try {
                  fileStorage.writeFile(await getLibraryDirectory(), textController.text);
                } catch(e) {
                  showError(e);
                }

              },
              readFunc: () async {
                try {
                  textController.text = await fileStorage.readFile(await getLibraryDirectory());
                } catch(e) {
                  showError(e);
                }
              },
              text: 'Library Dir:'
          ),
          FileWidget(
              writeFunc: () async {
                try {
                  fileStorage.writeFile(
                      await getExternalStorageDirectory(), textController.text);
                } catch(e) {
                  showError(e);
                }
              },
              readFunc: () async {
                try {
                  textController.text = await fileStorage.readFile(await getExternalStorageDirectory());
                } catch(e) {
                  showError(e);
                }
              },
              text: 'External Storage Dir:'
          ),
          FileWidget(
              writeFunc: () async {
                try {
                  fileStorage.writeFile((await getExternalCacheDirectories())[0], textController.text);
                } catch(e) {
                  showError(e);
                }
              },
              readFunc: () async {
                try {
                  textController.text = await fileStorage.readFile((await getExternalCacheDirectories())[0]);
                } catch(e) {
                  showError(e);
                }
              },
              text: 'External Cache Dir:'
          ),
        ],
      ),
    );
  }

  void showError(UnsupportedError e) {
    Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}