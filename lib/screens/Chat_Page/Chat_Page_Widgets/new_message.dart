import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../globals.dart';

class NewMessage extends StatefulWidget {
  final bool isAdmin;
  final String projectId;
  NewMessage({Key key, this.projectId, @required this.isAdmin})
      : super(key: key);

  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  FocusNode _message = new FocusNode();
  final _controller = new TextEditingController();
  var _enteredMessage = "";
  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    final userName = await FirebaseFirestore.instance
        .collection('users')
        .doc(userIdGlobal)
        .get()
        .then((value) => value['userName']);

    final DocumentReference reference =
        FirebaseFirestore.instance.collection('users').doc(userIdGlobal);
    FirebaseFirestore.instance
        .collection("projects")
        .doc(widget.projectId)
        .collection('chat')
        .add({
      'text': _enteredMessage,
      'time': Timestamp.now(),
      'userId': userIdGlobal,
      'userName': userName,
      'imageReference': reference,
      'isAdmin': widget.isAdmin,
    });
    _controller.clear();
    _enteredMessage = "";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50,
          decoration: BoxDecoration(
              color: isDark ? Color(0xFF6F737A) : Color(0xFFEBEDEF),
              // border: Border.all(width: 3),
              borderRadius: BorderRadius.circular(20)),
          margin: EdgeInsets.only(left: 10, right: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 5.0, bottom: 5),
                  child: TextField(
                    textAlignVertical: TextAlignVertical.center,
                    textCapitalization: TextCapitalization.sentences,
                    focusNode: _message,
                    onSubmitted: (str) {
                      if (_enteredMessage.trim().isEmpty != true ||
                          _enteredMessage.isEmpty != true) {
                        _sendMessage();
                        FocusScope.of(context).requestFocus(_message);
                      }
                    },
                    style: TextStyle(color: textColor()),
                    controller: _controller,
                    decoration: InputDecoration(
                        hintText: "Send message", border: InputBorder.none),
                    onChanged: (message) {
                      {
                        _enteredMessage = message;
                        setState(() {});
                      }
                    },
                  ),
                ),
              ),
              IconButton(
                  icon: Icon(Icons.perm_media, color: Colors.black87),
                  onPressed: () {
                    if (_enteredMessage.trim().isEmpty != true ||
                        _enteredMessage.isEmpty != true) {
                      _sendMessage();
                    }
                  }),
              IconButton(
                  icon: Icon(
                    Icons.send,
                    color: (_enteredMessage.trim().isEmpty)
                        ? Colors.black87
                        : Colors.blue[700].withAlpha(150),
                  ),
                  onPressed: () {
                    if (_enteredMessage.trim().isEmpty != true ||
                        _enteredMessage.isEmpty != true) {
                      _sendMessage();
                    }
                  })
            ],
          ),
        ),
        SizedBox(height: 5),
      ],
    );
  }
}
