import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gorouterdeeplink/data/repo/message_repo_impl.dart';
import 'package:gorouterdeeplink/domain/model/message_model.dart';

abstract class MessageRepo {
  Future<void> sendMessages(MessageModel message);
}

final messageRepo = Provider<MessageRepoImpl>((ref) => MessageRepoImpl());
