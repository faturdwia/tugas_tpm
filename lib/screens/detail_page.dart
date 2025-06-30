import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/smartphone.dart';

class DetailPage extends StatelessWidget {
  final Smartphone smartphone;
  const DetailPage({super.key, required this.smartphone});

  Future<void> _open(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Smartphone')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                smartphone.image,
                height: 200,
                errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported, size: 100),
              ),
            ),
            const SizedBox(height: 16),
            Text(smartphone.model, style: Theme.of(context).textTheme.titleLarge),
            Text(smartphone.brand),
            const SizedBox(height: 8),
            Text('Harga: ${smartphone.price} USD'),
            Text('RAM: ${smartphone.ram} GB'),
            Text('Storage: ${smartphone.storage} GB'),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => _open(smartphone.website),
              child: const Text('Buka Website'),
            )
          ],
        ),
      ),
    );
  }
}
