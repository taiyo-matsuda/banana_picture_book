import 'package:shadcn_flutter/shadcn_flutter.dart';

class IdentifyScreen extends StatelessWidget {
  const IdentifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      headers: [AppBar(title: const Text('バナナ特定'))],
      child: const Center(
        child: Text('バナナ特定画面', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
