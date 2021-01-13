import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_9.dart';


class ChatPage extends StatefulWidget {

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  final CollectionReference collectionReference = FirebaseFirestore.instance.collection('users');

  String message = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          margin: EdgeInsets.all(5),
          child: CircleAvatar(
            child: Text('S', style: TextStyle( color: Colors.white, fontWeight: FontWeight.w500 )),
          ),
        ),
        title: Text('Sub'),
        elevation: 0.0,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: collectionReference.doc('yisus dev').snapshots(),
        builder: (context, snapshot) {
          if( snapshot.hasData ){
            List<dynamic> list = snapshot.data.data()['chat-sub'];
            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) {
              if( list[index]['id'] == 'yisus dev' ){
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: ChatBubble(
                    alignment: Alignment.topRight,
                    clipper: ChatBubbleClipper9(type: BubbleType.sendBubble),
                    child: Text(list[index]['message']),
                  ),
                );
              } else{
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: ChatBubble(
                    backGroundColor: Colors.grey[350],
                    clipper: ChatBubbleClipper9(type: BubbleType.receiverBubble),
                    child: Text(list[index]['message']),
                  ),
                );
              }
             },
            );
          } else{
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Container(
              height: 50,
              width: 300,
              child: TextFormField(
                onChanged: (value){
                  message = value;
                  print(message);
                },
              ),
            ),
          ),
          Expanded(child: SizedBox()),
          FloatingActionButton(
            child: Icon(Icons.send),
            onPressed: () async{
              var data = await collectionReference.doc('yisus dev').get();
              List<dynamic> list = data.data()['chat-sub'];
              list.add({ 'id': 'yisus dev', 'message': message });
              await collectionReference.doc('yisus dev').update({ 'chat-sub': list });
              await collectionReference.doc('sub').update({ 'chat-yisus dev': list });
            }
          )
        ],
      ),
   );
  }
}