import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddTodoPopupCard extends StatelessWidget {
  final TextEditingController textCtrl;
  final void Function(String) onSave;

  AddTodoPopupCard({
    required this.textCtrl,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Hero(
          tag: 'add-todo-hero',
          child: Material(
            elevation: 2,
            color: Colors.grey.shade800,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 3,
                color: Color(0x99FFFFFF),
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0x33FFFFFF),
                          hintText: 'Añade tu libro...',
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x99FFFFFF),
                              width: 1,
                            ),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x99FFFFFF),
                              width: 1,
                            ),
                          ),
                          hintStyle: TextStyle(
                            color: Color(0x99FFFFFF),
                          ),
                        ),
                        cursorColor: Colors.white,
                        controller: textCtrl,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => onSave(textCtrl.text),
                      child: const Text(
                        'Guardar',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
