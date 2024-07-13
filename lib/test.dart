import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TestConsumer extends ConsumerStatefulWidget {
  const TestConsumer({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LiginPageState();
}

class _LiginPageState extends ConsumerState<TestConsumer> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
