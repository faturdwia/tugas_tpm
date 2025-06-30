import 'package:flutter/material.dart';
import '../models/smartphone.dart';
import '../services/api_service.dart';
import '../widgets/smartphone_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Smartphone>> _future;

  @override
  void initState() {
    super.initState();
    _future = ApiService.fetchSmartphones();
  }

  Future<void> _refresh() async {
    setState(() {
      _future = ApiService.fetchSmartphones();
    });
  }

  void _delete(int id) async {
    final ok = await ApiService.deleteSmartphone(id);
    if (ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Berhasil dihapus')),
      );
      _refresh();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal menghapus')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smartphones'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              final result = await Navigator.pushNamed(context, '/create');
              if (result == true) _refresh();
            },
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: FutureBuilder<List<Smartphone>>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('Data kosong'));
            }
            final data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (_, i) {
                final sp = data[i];
                return SmartphoneCard(
                  phone: sp,
                  onTap: () => Navigator.pushNamed(context, '/detail', arguments: sp.id),
                  onEdit: () async {
                    final result = await Navigator.pushNamed(context, '/edit', arguments: sp);
                    if (result == true) _refresh();
                  },
                  onDelete: () => _delete(sp.id),
                );
              },
            );
          },
        ),
      ),
    );
  }
}