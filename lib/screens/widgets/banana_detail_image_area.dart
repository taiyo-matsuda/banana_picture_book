import 'package:shadcn_flutter/shadcn_flutter.dart';

class BananaDetailImageArea extends StatelessWidget {
  const BananaDetailImageArea({super.key, required this.imageUrl});

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl!.isEmpty) {
      return _placeholder(context);
    }

    return Image.network(
      imageUrl!,
      width: double.infinity,
      height: 280,
      fit: BoxFit.cover,
      errorBuilder: (_, _, _) {
        return _placeholder(context);
      },
    );
  }

  Widget _placeholder(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 280,
      color: Theme.of(context).colorScheme.muted,
      child: const Center(child: Text('🍌', style: TextStyle(fontSize: 72))),
    );
  }
}
