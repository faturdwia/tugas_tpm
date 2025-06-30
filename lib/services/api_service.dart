import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/smartphone.dart';

class ApiService {
  static const String _baseUrl = 'https://tpm-api-responsi-e-f-872136705893.us-central1.run.app/api/v1';

  static Future<List<Smartphone>> fetchSmartphones() async {
    final url = Uri.parse('$_baseUrl/phones');
    final res = await http.get(url);
    if (res.statusCode == 200) {
      final json = jsonDecode(res.body);
      final List data = json['data'];
      return data.map((e) => Smartphone.fromJson(e)).toList();
    } else {
      throw Exception('Gagal mengambil data. Status: ${res.statusCode}');
    }
  }

  static Future<Smartphone> fetchSmartphone(int id) async {
    final url = Uri.parse('$_baseUrl/phones/$id');
    final res = await http.get(url);
    if (res.statusCode == 200) {
      return Smartphone.fromJson(jsonDecode(res.body));
    } else {
      throw Exception('Gagal mengambil detail');
    }
  }

  static Future<bool> createSmartphone(Smartphone sp) async {
    final url = Uri.parse('$_baseUrl/phones');
    final res = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(sp.toJson()),
    );
    return res.statusCode == 201;
  }

  static Future<bool> updateSmartphone(int id, Smartphone sp) async {
    final url = Uri.parse('$_baseUrl/phones/$id');
    final res = await http.patch(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(sp.toJson()),
    );
    return res.statusCode == 200;
  }

  static Future<bool> deleteSmartphone(int id) async {
    final url = Uri.parse('$_baseUrl/phones/$id');
    final res = await http.delete(url);
    return res.statusCode == 200;
  }
}
