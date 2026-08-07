import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'repositories/brief_banana_repository_imple.dart';
import 'repositories/datasource/supabase/supabase_client.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  await SupabaseConfig.initialize();

  final repository = BriefBananaRepositoryImpl(SupabaseConfig.client);

  final bananas = await repository.findAll();

  debugPrint('件数: ${bananas.length}');

  for (final banana in bananas.take(10)) {
    debugPrint(
      '${banana.variety.musalogueName} / '
      '${banana.origin.origin}',
    );
  }

  runApp(const BananaPictureBookApp());
}

class BananaPictureBookApp extends StatelessWidget {
  const BananaPictureBookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(body: Center(child: Text('Banana Picture Book'))),
    );
  }
}
