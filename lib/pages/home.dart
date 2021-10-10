import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:band_names/models/band.dart';
import 'package:flutter/painting.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: '1', name: 'Metallica', votes: 5),
    Band(id: '2', name: 'ColdPlay', votes: 3),
    Band(id: '3', name: 'Heroes del Silencio', votes: 4),
    Band(id: '4', name: 'Mana', votes: 2),
    Band(id: '5', name: 'Soda Stereo', votes: 1),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Band Names',
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 1,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (context, i) => _bandTiles(bands[i]),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: addNewBand,
      ),
    );
  }

  Widget _bandTiles(Band band) {
    return Dismissible(
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        debugPrint('direction: $direction');
        debugPrint('id: ${band.id}');
        
        //TODO: Llamar borrado en el server
      },
      background: Container(
        padding: const EdgeInsets.only(left: 30.0),
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children: const [
              Icon(
                Icons.delete,
                size: 20,
                color: Colors.white,
              ),
              SizedBox(width: 10.0),
              Text(
                'Delete Band',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
            ],
          ),
        ),
      ),
      key: Key(band.id),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(band.name.substring(0, 2)),
          backgroundColor: Colors.blue[100],
        ),
        title: Text(band.name),
        trailing: Text(
          '${band.votes}',
          style: const TextStyle(fontSize: 20.0),
        ),
        onTap: () {
          debugPrint(band.name);
        },
      ),
    );
  }

  addNewBand() {
    final textController = TextEditingController();

    if (Platform.isAndroid) {
      // Android
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('New Band Name:'),
            content: TextField(
              controller: textController,
            ),
            actions: [
              MaterialButton(
                child: const Text('Add'),
                elevation: 5,
                textColor: Colors.blue,
                onPressed: () => addBandName(textController.text),
              )
            ],
          );
        },
      );
    }

    showCupertinoDialog(
      context: context,
      builder: (_) {
        return CupertinoAlertDialog(
          title: const Text('New Ban Name'),
          content: CupertinoTextField(
            controller: textController,
          ),
          actions: [
            CupertinoDialogAction(
              child: const Text('Add'),
              isDefaultAction: true,
              onPressed: () => addBandName(textController.text),
            ),
            CupertinoDialogAction(
              child: const Text('Cancel'),
              isDestructiveAction: true,
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  void addBandName(String name) {
    debugPrint('========================   $name');
    if (name.length > 1) {
      // Podemos Agregar
      bands.add(Band(
        id: DateTime.now().toString(),
        name: name,
        votes: 0,
      ));
      setState(() {});
    }
    Navigator.pop(context);
  }
}
