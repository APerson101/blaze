import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class WithDrawalStatus extends ConsumerWidget {
  const WithDrawalStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(_withdrawalStatus).when(
        data: (status) {
          return status['status'] == 'done'
              ? Material(
                  child: DecoratedBox(
                      decoration: const BoxDecoration(
                        color: Colors.lightGreen,
                      ),
                      child: Column(children: [
                        const Icon(Icons.airplane_ticket),
                        const Text("Successful"),
                        ElevatedButton(
                          child: const Text("back"),
                          onPressed: () {
                            GoRouter.of(context)
                              ..pop()
                              ..pop()
                              ..pop();
                          },
                        )
                      ])),
                )
              : Material(
                  child: DecoratedBox(
                      decoration: const BoxDecoration(
                        color: Colors.redAccent,
                      ),
                      child: Column(children: [
                        const Icon(Icons.airplane_ticket),
                        const Text("Failed"),
                        Text(status['reason']!),
                        ElevatedButton(
                          child: const Text("back"),
                          onPressed: () {
                            GoRouter.of(context).pop();
                          },
                        )
                      ])),
                );
        },
        error: (err, stc) => Material(
              child: Column(
                children: [
                  const Center(child: Text("Failed to send")),
                  ButtonBar(
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            GoRouter.of(context).pop();
                          },
                          child: const Text("Back")),
                      ElevatedButton(
                          onPressed: () {}, child: const Text("retry")),
                    ],
                  )
                ],
              ),
            ),
        loading: () => const Material(
            child: Center(child: CircularProgressIndicator.adaptive())));
  }
}

final _withdrawalStatus = FutureProvider((ref) async {
  return {'status': 'done'};
});
