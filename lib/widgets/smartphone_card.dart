import 'package:flutter/material.dart';
import '../models/smartphone.dart';

class SmartphoneCard extends StatelessWidget {
  final Smartphone phone;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const SmartphoneCard({
    super.key,
    required this.phone,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        onTap: onTap,
        leading: Image.network(
          phone.image,
          width: 60,
          height: 60,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported),
        ),
        title: Text(phone.model),
        subtitle: Text('${phone.brand} • ${phone.price} USD'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(onPressed: onEdit, icon: const Icon(Icons.edit)),
            IconButton(onPressed: onDelete, icon: const Icon(Icons.delete, color: Colors.red)),
          ],
        ),
      ),
    );
  }
}