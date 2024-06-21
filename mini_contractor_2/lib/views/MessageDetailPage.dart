import 'package:flutter/material.dart';
import 'package:mini_contractor_2/controllers/chatController.dart';
import 'package:mini_contractor_2/models/message.dart';

class MessageDetailPage extends StatefulWidget {
  final String workOrderId;
  final String userId;

  const MessageDetailPage({Key? key, required this.workOrderId, required this.userId}) : super(key: key);

  @override
  _MessageDetailPageState createState() => _MessageDetailPageState();
}

class _MessageDetailPageState extends State<MessageDetailPage> {
  final chatController _chatController = chatController();
  late String? lastMsgActionedId; // Nullable last message actionedId
  late String? lastMsgUserId; // Nullable last message userId
  final ScrollController _scrollController = ScrollController(); // Scroll controller

  @override
  void dispose() {
    _scrollController.dispose(); // Dispose the ScrollController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _messageController = TextEditingController();

    Future<void> addMessage(BuildContext context) async {
      String message = '';
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Add Message'),
            content: TextField(
              controller: _messageController,
              onChanged: (value) {
                message = value;
              },
              decoration: InputDecoration(
                hintText: 'Type your message here',
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  if (message.isNotEmpty) {
                    // Send the message
                    await _chatController.sendMessage(
                      message,
                      widget.workOrderId,
                      lastMsgUserId!,
                      lastMsgActionedId!,
                      context,
                    );
                    _messageController.clear();
                    Navigator.of(context).pop(); // Close the dialog
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please enter a message'),
                      ),
                    );
                  }
                },
                child: Text('Send'),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Message Detail'),
      ),
      body: FutureBuilder<List<MessageData>>(
        future: _chatController.chat(widget.workOrderId, widget.userId, context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<MessageData> messages = snapshot.data ?? [];
            if (messages.isNotEmpty) {
              // Update last message's userId and actionedId
              lastMsgActionedId = messages.last.actionedOn?.userId;
              lastMsgUserId = messages.last.userId?.userId;
            }
            return ListView.builder(
              controller: _scrollController, // Attach ScrollController here
              itemCount: messages.length,
              itemBuilder: (context, index) {
                String msgActionedId = messages[index].actionedOn?.userId ?? '';
                String msgUserId = messages[index].userId?.userId ?? '';
                return Card(
                  child: ListTile(
                    title: Text(messages[index].userId.firstName),
                    subtitle: Text(messages[index].text),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
        child: FloatingActionButton(
          onPressed: () => addMessage(context),
          tooltip: 'Add Message',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
