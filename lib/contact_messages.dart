import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartie/summary_screen.dart';

class ContactMessages extends StatefulWidget {
  final Contact contact;

  ContactMessages({super.key, required this.contact});

  @override
  _ContactMessagesState createState() => _ContactMessagesState();
}

class _ContactMessagesState extends State<ContactMessages> {
  final TextEditingController _controller = TextEditingController();

  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MessageProvider(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(title: Text(widget.contact.name)),
        body: Column(
          children: [
            if (widget.contact.message.text != "")
              Container(
                  padding: EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                    left: 10,
                    right: 80,
                  ),
                  child: ListTile(
                    title: Text(widget.contact.message.text),
                    textColor: Colors.white,
                    tileColor: Colors.blue,
                  ),
                ),
            Expanded(
              child: Consumer<MessageProvider>(
                builder: (context, messageProvider, child) {
                  return ListView.builder(
                    itemCount: messageProvider.messages.length,
                    itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.only(
                            top: 10,
                            bottom: 10,
                            left: 80,
                            right: 10,
                          ),
                          child: ListTile(
                            title: Text(messageProvider.messages[index].text),
                            textColor: Colors.white,
                            tileColor: Colors.green,
                          ),
                        );
                      
                      
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Consumer<MessageProvider>(
                builder: (context, messageProvider, child) {
                  return Container(
                    color: Colors.white,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            decoration: InputDecoration(
                              labelText: 'Send a message',
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.send),
                          onPressed: () {
                            if (_controller.text.isNotEmpty) {
                              Provider.of<MessageProvider>(
                                context,
                                listen: false,
                              ).addMessage(_controller.text);
                              _controller.clear();
                            }
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Message {
  final String text;
  Message(this.text);
}

class MessageProvider with ChangeNotifier {
  List<Message> _messages = [];
  List<Message> get messages => _messages;

  Future<void> addMessage(String text) async {
    _messages.add(Message(text));
    notifyListeners();
  }
}
