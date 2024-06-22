import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rsvp/components/chat_bubble.dart';
import 'package:rsvp/components/textfield.dart';
import 'package:rsvp/services/chat_services/chat_services.dart';

class MyChatPage extends StatefulWidget {
  final String EventTitle;
  final String username;

  MyChatPage({super.key, required this.EventTitle, required this.username});

  @override
  State<MyChatPage> createState() => _MyChatPageState();
}

class _MyChatPageState extends State<MyChatPage> {
  final TextEditingController _messageController = TextEditingController();

  final ChatServices _chatService = ChatServices();

  FocusNode myFocusNode = FocusNode(); //for textfield focus

  @override
  void initState() {
    super.initState();

    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        Future.delayed(
          const Duration(milliseconds: 500),
          () => scrollDown(),
        );
      }
    });

    Future.delayed(
      const Duration(milliseconds: 500),
      () => scrollDown(),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    myFocusNode.dispose();
    super.dispose();
  }

  final ScrollController _scrollController = ScrollController();

  void scrollDown() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
  }

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.EventTitle, _messageController.text);

      _messageController.clear();
    }
    scrollDown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.EventTitle} Chat",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        centerTitle: false,
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
      ),
      body: Column(
        children: [
          // display all the messages
          Expanded(child: _buildMessageList(context)),
          _buildUserInput(context),
        ],
      ),
    );
  }

  Widget _buildMessageList(BuildContext context) {
    return StreamBuilder(
        stream: _chatService.getMessages(widget.EventTitle),
        builder: ((context, snapshot) {
          //errors
          if (snapshot.hasError) {
            return const Text('Error');
          }

          //loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading...');
          }
          return ListView(
            controller: _scrollController,
            children: snapshot.data!.docs
                .map((doc) => _buildMessageItem(doc))
                .toList(),
          );
        }));
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    bool isCurrentUser = data['sender'] == widget.username;

    var allignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;
    return Container(
      alignment: allignment,
      child:
          MyChatBubble(sender: data['sender'], message: data["message"], isCurrentUser: isCurrentUser),
    );
  }

  Widget _buildUserInput(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Row(children: [
        Expanded(
            child: MyTextField(
          hintText: "Type a message",
          obscureText: false,
          controller: _messageController,
          focusNode: myFocusNode,
        )),
        Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).colorScheme.tertiary,
            ),
            margin: const EdgeInsets.only(right: 25),
            child: IconButton(
                onPressed: sendMessage,
                icon: Icon(Icons.send,
                    color: Theme.of(context).colorScheme.secondary))),
      ]),
    );
  }
}
