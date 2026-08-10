import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import 'core/di/injection.dart';
import 'core/router/app_router.dart';
import 'repositories/datasource/supabase/supabase_client.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');
  await SupabaseConfig.initialize();

  setupDependencies();

  final router = createAppRouter();

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
