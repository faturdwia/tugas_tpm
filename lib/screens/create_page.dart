import 'package:flutter/material.dart';
import '../models/smartphone.dart';
import '../services/api_service.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final _form = GlobalKey<FormState>();
  final _model = TextEditingController();
  final _brand = TextEditingController();
  final _price = TextEditingController();
  final _ram = TextEditingController();
  final _image = TextEditingController();
  final _website = TextEditingController();
  int _storage = 128;
  bool _loading = false;

  Future<void> _save() async {
    if (!_form.currentState!.validate()) return;
    setState(() => _loading = true);
    final sp = Smartphone(
      id: 0,
      model: _model.text,
      brand: _brand.text,
      price: double.parse(_price.text),
      ram: int.parse(_ram.text),
      storage: _storage,
      image: _image.text,
      website: _website.text,
    );
    final ok = await ApiService.createSmartphone(sp);
    if (mounted) {
      if (ok) {
        Navigator.pop(context, true);
      } else {
        setState(() => _loading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gagal menambah data')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Smartphone')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                controller: _model,
                decoration: const InputDecoration(labelText: 'Model'),
                validator: (v) => v!.isEmpty ? 'Wajib diisi' : null,
              ),
              TextFormField(
                controller: _brand,
                decoration: const InputDecoration(labelText: 'Brand'),
                validator: (v) => v!.isEmpty ? 'Wajib diisi' : null,
              ),
              TextFormField(
                controller: _price,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (v) => v!.isEmpty ? 'Wajib diisi' : null,
              ),
              TextFormField(
                controller: _ram,
                decoration: const InputDecoration(labelText: 'RAM (GB)'),
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v!.isEmpty) return 'Wajib diisi';
                  final val = int.tryParse(v);
                  if (val == null || val % 2 != 0) return 'Harus kelipatan 2';
                  return null;
                },
              ),
              DropdownButtonFormField<int>(
                value: _storage,
                decoration: const InputDecoration(labelText: 'Storage'),
                items: [128, 256, 512].map((e) {
                  return DropdownMenuItem(value: e, child: Text('${e} GB'));
                }).toList(),
                onChanged: (v) => setState(() => _storage = v!),
              ),
              TextFormField(
                controller: _image,
                decoration: const InputDecoration(labelText: 'Image URL'),
              ),
              TextFormField(
                controller: _website,
                decoration: const InputDecoration(labelText: 'Website URL'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _loading ? null : _save,
                child: _loading ? const CircularProgressIndicator() : const Text('SUBMIT NEW PHONE'),
              )
            ],
          ),
        ),
      ),
    );
  }
}