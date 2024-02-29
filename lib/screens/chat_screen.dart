import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_chat_app/utils/global_variables.dart';
import 'package:my_chat_app/widgets/my_textfield.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageController = TextEditingController();

  late List<Map<String, dynamic>> messages;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getAllMessages();
  }

  late List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = [];

  void getAllMessages() async {
    final messages =
        FirebaseFirestore.instance.collection('messages').snapshots();
    messages.listen((event) {
      docs = event.docs;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
            onPressed: () {
              getAllMessages();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
        backgroundColor: mainColor,
        title: const Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/logo.png'),
              backgroundColor: Colors.transparent,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'MessageMe',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Messages(
              messages: docs,
            ),
          )),
          Row(
            children: [
              Expanded(
                child: TextField(
                  style: const TextStyle(fontSize: 16),
                  controller: messageController,
                  decoration: const InputDecoration(
                    hintText: 'Type a message',
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.zero),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.zero),
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  final map = {
                    'text': messageController.text,
                    'sender': FirebaseAuth.instance.currentUser!.email,
                    'time': Timestamp.now()
                  };
                  try {
                    FirebaseFirestore.instance.collection('messages').add(map);
                    print('added');
                    messageController.text = "";
                  } catch (e) {
                    print(e.toString());
                  }
                  //   print(messageController.text);
                },
                icon: const Icon(Icons.send),
                iconSize: 30,
                padding: const EdgeInsets.all(0),
                splashColor: Colors.transparent,
              )
            ],
          ),
        ],
      ),
    );
  }
}

class Messages extends StatefulWidget {
  const Messages({super.key, required this.messages});

  final List<QueryDocumentSnapshot<Map<String, dynamic>>> messages;

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('messages')
          .orderBy('time')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data!.size,
              itemBuilder: (context, index) {
                final doc = snapshot.data!.docs[index];
                return SignleMessage(
                  sender: doc.get('sender'),
                  text: doc.get('text'),
                );
              });
        }
        return Container();
      },
    );
  }
}

class SignleMessage extends StatelessWidget {
  const SignleMessage({super.key, required this.text, required this.sender});

  final String text;
  final String sender;

  @override
  Widget build(BuildContext context) {
    bool isMe = FirebaseAuth.instance.currentUser!.email == sender;
    return Column(
      crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(sender),
        Material(
          elevation: 5,
          color: isMe ? secondColor : mainColor,
          shape: RoundedRectangleBorder(
              borderRadius: isMe
                  ? const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                      topLeft: Radius.circular(10))
                  : const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                      topRight: Radius.circular(10))),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              text,
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        )
      ],
    );
  }
}
