import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import 'repositories/brief_banana_repository.dart';
import 'repositories/brief_banana_repository_imple.dart';
import 'repositories/datasource/supabase/supabase_client.dart';
import 'screens/banana_list_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');
  await SupabaseConfig.initialize();

  final repository = BriefBananaRepositoryImpl(SupabaseConfig.client);

  runApp(BananaPictureBookApp(repository: repository));
}

class BananaPictureBookApp extends StatelessWidget {
  const BananaPictureBookApp({super.key, required this.repository});

  final BriefBananaRepository repository;

  @override
  Widget build(BuildContext context) {
    return ShadcnApp(
      title: 'Banana Picture Book',
      home: BananaListScreen(repository: repository),
    );
  }
}
