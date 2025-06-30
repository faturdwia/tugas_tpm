import '../models/smartphone.dart';

class DataService {
  static List<Smartphone> smartphones = [
    Smartphone(
      id: 1,
      model: 'Galaxy S22',
      brand: 'Samsung',
      price: 12000000,
      ram: 8,
      storage: 256,
      image: 'https://via.placeholder.com/150', 
      website: 'https://www.samsung.com/id/smartphones/galaxy-s22/',
    ),
    Smartphone(
      id: 2,
      model: 'iPhone 13',
      brand: 'Apple',
      price: 15000000,
      ram: 6,
      storage: 128,
      image: 'https://via.placeholder.com/150',
      website: 'https://www.apple.com/id/iphone-13/',
    ),
    Smartphone(
      id: 3,
      model: 'Redmi Note 11',
      brand: 'Xiaomi',
      price: 3000000,
      ram: 4,
      storage: 64,
      image: 'https://via.placeholder.com/150',
      website: 'https://www.mi.co.id/id/redmi-note-11/',
    ),
  ];

  static void deleteSmartphone(int index) {
    smartphones.removeAt(index);
  }
}
