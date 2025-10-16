import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gorouterdeeplink/domain/model/message_model.dart';
import 'package:gorouterdeeplink/domain/repo/message_repo.dart';

class MessageViewModel extends AsyncNotifier<void> {
  late final MessageRepo _messageRepo;

  @override
  FutureOr<void> build() {
    _messageRepo = ref.read(messageRepo);
  }

  Future<void> sendMessages() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final message = MessageModel(
        title: 'Hello, this is a test message!',
        content: 'asdmklasmdlkamlsd',
        createdAt: DateTime.now().microsecondsSinceEpoch,
      );
      await _messageRepo.sendMessages(message);
    });
  }
}

final messageViewModelProvider = AsyncNotifierProvider<MessageViewModel, void>(
  () => MessageViewModel(),
);

final getMessagesProvider = StreamProvider.autoDispose((ref) {
  final db = FirebaseFirestore.instance;

  return db
      .collection('messages')
      .orderBy('createdAt')
      .snapshots()
      .map(
        (e) => e.docs.map((doc) => MessageModel.fromJson(doc.data())).toList(),
      );
});
