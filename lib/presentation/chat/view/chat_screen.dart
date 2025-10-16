import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gorouterdeeplink/core/layout/default_layout.dart';
import 'package:gorouterdeeplink/presentation/message/view_model/message_view_model.dart';

class ChatScreen extends ConsumerWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
      child: ref
          .watch(getMessagesProvider)
          .when(
            data: (data) {
              return ListView.separated(
                itemBuilder: (context, index) {
                  final message = data[index];
                  return ListTile(
                    title: Text(message.content),
                    subtitle: Text(message.createdAt.toString()),
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: data.length,
              );
            },

            error: (error, stackTrace) => Center(child: Text(error.toString())),
            loading: () => Center(child: CircularProgressIndicator()),
          ),
    );
  }
}
