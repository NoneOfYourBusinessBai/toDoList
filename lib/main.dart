import 'dart:math';

import 'package:flutter/material.dart';
import 'add_todo_popup_card.dart';
import 'hero_dialog_route.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: MyHomePage(title: 'Libros para comprar:'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class ToDoItem {
  String text;
  int order;
  bool checked;

  ToDoItem(this.text, {required this.order, this.checked: false});
}

class _MyHomePageState extends State<MyHomePage> {
  List<ToDoItem> items = [
    ToDoItem('LOS CUATRO ACUERDOS', order: 0),
    ToDoItem('LOS MITOS QUE NOS DIERON TRAUMAS', order: 1),
    ToDoItem('LAS 5 HERIDAS EMOCIONALES', order: 2),
    ToDoItem('SANA TU FAMILIA', order: 3),
    ToDoItem('BECOMING SUPERNATURAL', order: 4),
  ];

  updateList(e) {
    setState(() {
      List<ToDoItem> checkeds =
          this.items.where((element) => element.checked).toList();
      checkeds.sort((a, b) => a.order - b.order);

      List<ToDoItem> uncheckeds =
          this.items.where((element) => !element.checked).toList();
      uncheckeds.sort((a, b) => a.order - b.order);

      this.items.clear();
      this.items.addAll([...uncheckeds, ...checkeds]);
    });
  }

  final textCtrl = TextEditingController();

  openPopUpCard(void Function(String) onSave) {
    Navigator.of(context).push(HeroDialogRoute(
      builder: (context) {
        return AddTodoPopupCard(
          textCtrl: textCtrl,
          onSave: (text) {
            onSave(text);
            updateList(e);
            textCtrl.text = '';
            Navigator.of(context).pop();
          },
        );
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(widget.title),
        toolbarHeight: 100,
      ),
      body: ListView(
        children: [
          ...this.items.map((e) => ListTile(
                leading: Checkbox(
                  checkColor: Colors.transparent,
                  activeColor: Colors.grey.shade400,
                  onChanged: (e) {},
                  value: e.checked,
                ),
                title: Opacity(
                  opacity: e.checked ? 0.5 : 1,
                  child: Text(
                    e.text,
                    style: TextStyle(
                      color: e.checked ? Colors.grey.shade500 : Colors.black,
                      decoration: e.checked ? TextDecoration.lineThrough : null,
                    ),
                  ),
                ),
                trailing: PopupMenuButton<String>(
                  onSelected: (t) {
                    switch (t) {
                      case 'edit':
                        this.textCtrl.text = e.text;
                        openPopUpCard((text) {
                          this
                              .items
                              .firstWhere((element) => element.order == e.order)
                              .text = text;
                        });
                        break;
                      case 'delete':
                        this
                            .items
                            .removeWhere((element) => element.order == e.order);
                        updateList(e);
                        break;
                    }
                  },
                  icon: Icon(Icons.more_vert),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    side: BorderSide(color: Color(0x99FFFFFF), width: 2),
                  ),
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem<String>(
                        height: 12,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.edit, color: Colors.pink),
                            Text(
                              'Edit',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Colors.pink,
                              ),
                            ),
                          ],
                        ),
                        value: 'edit',
                      ),
                      PopupMenuDivider(
                        height: 8,
                      ),
                      PopupMenuItem<String>(
                        height: 12,
                        value: 'delete',
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.delete, color: Colors.purple),
                            Text(
                              'Delete',
                              style: TextStyle(color: Colors.purple),
                            )
                          ],
                        ),
                      ),
                    ];
                  },
                  color: Colors.grey.shade700,
                ),
                onTap: () {
                  e.checked = !e.checked;
                  updateList(e);
                },
              )),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 14.0),
        child: GestureDetector(
          onTap: () => openPopUpCard((text) => items.add(ToDoItem(
                text,
                order: items
                        .reduce((value, element) =>
                            element.order > value.order ? element : value)
                        .order +
                    1,
              ))),
          child: Hero(
            tag: 'add-todo-hero',
            child: Material(
              color: Colors.purple.shade700,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
                side: const BorderSide(
                  width: 1,
                  color: Color(0x99FFFFFF),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: const Icon(
                  Icons.add_rounded,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
