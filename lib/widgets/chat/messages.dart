import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './message_bubble.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (ctx, AsyncSnapshot streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final documents = streamSnapshot.data.docs;
          return ListView.builder(
            reverse: true,
            itemCount: documents.length,
            itemBuilder: (ctx, index) => MessageBubble(
                documents[index]['text'],
                documents[index]['userId'] ==
                    FirebaseAuth.instance.currentUser.uid,
                documents[index]['username'],
                documents[index]['userImage'],
                key: ValueKey(documents[index].id)),
          );
        });
  }
}
