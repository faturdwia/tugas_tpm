class Smartphone {
  final int id;
  final String model;
  final String brand;
  final double price;
  final int ram;
  final int storage;
  final String image;
  final String website;

  Smartphone({
    required this.id,
    required this.model,
    required this.brand,
    required this.price,
    required this.ram,
    required this.storage,
    required this.image,
    required this.website,
  });

  factory Smartphone.fromJson(Map<String, dynamic> json) {
    return Smartphone(
      id: json['id'] ?? 0,
      model: json['model'] ?? '',
      brand: json['brand'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      ram: json['ram'] ?? 0,
      storage: json['storage'] ?? 0,
      image: json['image'] ?? '',
      website: json['website'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'model': model,
      'brand': brand,
      'price': price,
      'ram': ram,
      'storage': storage,
      'image': image,
      'website': website,
    };
  }
}
