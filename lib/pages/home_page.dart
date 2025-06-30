import 'package:flutter/material.dart';
import '../models/smartphone.dart';
import '../services/data_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home Page")),
      body: ListView.builder(
        itemCount: DataService.smartphones.length,
        itemBuilder: (context, index) {
          final phone = DataService.smartphones[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              leading: Image.network(
                phone.image,
                width: 50,
                errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
              ),
              title: Text(phone.model),
              subtitle: Text("${phone.brand} - ${phone.price.toStringAsFixed(0)} USD"),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/detail',
                  arguments: phone,
                );
              },
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/edit',
                          arguments: phone,
                        );
                      },
                    ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        DataService.deleteSmartphone(index);
                      });
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
