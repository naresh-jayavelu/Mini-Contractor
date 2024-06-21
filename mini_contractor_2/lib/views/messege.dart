import 'package:flutter/material.dart';
import 'package:mini_contractor_2/controllers/chatController.dart';
import 'package:mini_contractor_2/controllers/encrypteddata.dart';
import 'package:mini_contractor_2/models/message.dart';
import 'package:mini_contractor_2/views/MessageDetailPage.dart';

class ChatList extends StatelessWidget {
  final chatController _chatController = chatController();
  final SecureStorageService secureStorage = SecureStorageService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, String?>>(
      future: secureStorage.getUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          Map<String, String?> userData = snapshot.data!;
          String userId = userData['id']??'';

          return FutureBuilder<List<MessageList>>(
            future: _chatController.chatList(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
                List<MessageList> data = snapshot.data!;

                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return buildCard(context, data[index], userId);
                  },
                );
              }
            },
          );
        }
      },
    );
  }

  Widget buildCard(BuildContext context, MessageList message, String userId) {
    return Card(
      child: ListTile(
        title: Text(
          message.workOrder.description,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(userId==message.userId ? "Sent: ${message.text}" : "Received: ${message.text}"),
        onTap: () {
          // Handle card click, for example, navigate to message detail page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MessageDetailPage(workOrderId: message.workOrder.Id, userId: userId)),
          );
        },
      ),
    );
  }
}
