import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gorouterdeeplink/domain/model/message_model.dart';
import 'package:gorouterdeeplink/domain/repo/message_repo.dart';

class MessageRepoImpl extends MessageRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Future<void> sendMessages(MessageModel message) async {
    try {
      await _firestore.collection('messages').add(message.toJson());
    } catch (e) {
      log((e.toString()));
    }
  }
}
