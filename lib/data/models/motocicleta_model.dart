class Motocicleta {
  final int? id;
  final String marca;
  final String modelo;
  final int cilindrada;
  final String color;

  Motocicleta({
    this.id,
    required this.marca,
    required this.modelo,
    required this.cilindrada,
    required this.color,
  });

  // Método para convertir el objeto json a una Motocicleta
  factory Motocicleta.fromJson(Map<String, dynamic> json) {
    return Motocicleta(
      id: json['id'],
      marca: json['marca'],
      modelo: json['modelo'],
      cilindrada: json['cilindrada'],
      color: json['color'],
    );
  }

  // Método para convertir el objeto a json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'marca': marca,
      'modelo': modelo,
      'cilindrada': cilindrada,
      'color': color,
    };
  }
}