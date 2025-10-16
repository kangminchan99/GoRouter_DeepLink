import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gorouterdeeplink/core/layout/default_layout.dart';
import 'package:gorouterdeeplink/presentation/message/view_model/message_view_model.dart';

class MessageScreen extends ConsumerWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
      child: Center(
        child: ElevatedButton(
          onPressed: () =>
              ref.read(messageViewModelProvider.notifier).sendMessages(),
          child: Text('send'),
        ),
      ),
    );
  }
}
