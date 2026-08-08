import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import 'core/router/app_router.dart';
import 'repositories/brief_banana_repository_imple.dart';
import 'repositories/datasource/supabase/supabase_client.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');
  await SupabaseConfig.initialize();

  final repository = BriefBananaRepositoryImpl(SupabaseConfig.client);

  final router = createAppRouter(repository: repository);

  runApp(BananaPictureBookApp(routerConfig: router));
}

class BananaPictureBookApp extends StatelessWidget {
  const BananaPictureBookApp({super.key, required this.routerConfig});

  final GoRouter routerConfig;

  @override
  Widget build(BuildContext context) {
    return ShadcnApp.router(
      title: 'Banana Picture Book',
      routerConfig: routerConfig,
    );
  }
}
