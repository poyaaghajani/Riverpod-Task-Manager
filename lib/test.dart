import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_manager/features/auth/controllers/code_provider.dart';

// class TestConsumer extends ConsumerStatefulWidget {
//   const TestConsumer({super.key});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _LiginPageState();
// }

// class _LiginPageState extends ConsumerState<TestConsumer> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           children: [
//             TextButton(
//               onPressed: () {},
//               child: const Text("Pressed"),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

class TextPage extends ConsumerWidget {
  const TextPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String code = ref.watch(codeStateProvider);

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                ref
                    .read(codeStateProvider.notifier)
                    .setStart("Mn delam mario mikhad, mari mano nemikhad");
              },
              child: const Text("Pressed"),
            ),
            Text(code),
          ],
        ),
      ),
    );
  }
}
