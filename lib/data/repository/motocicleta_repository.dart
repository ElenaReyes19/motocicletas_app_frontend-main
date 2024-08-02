import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/motocicleta_model.dart';

class MotocicletaRepository {
  final String apiUrl;

  MotocicletaRepository({
    required this.apiUrl,
  });

  Future<void> crearMotocicleta(Motocicleta motocicleta) async {
    final response = await http.post(
      Uri.parse('$apiUrl/crear_motocicleta'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        //'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode(motocicleta.toJson()..remove('id')),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al crear motocicleta.');
    }
  }

  Future<Motocicleta> consultarMotocicleta(String id) async {
    final response = await http.get(
      Uri.parse('$apiUrl/consultar_motocicleta/$id'),
      headers: <String, String>{
        //'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      return Motocicleta.fromJson(jsonDecode(response.body)['data']);
    } else {
      throw Exception('Error al cargar motocicleta.');
    }
  }

  Future<void> actualizarMotocicleta(Motocicleta motocicleta) async {
    final response = await http.put(
      Uri.parse('$apiUrl/actualizar_motocicleta'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        //'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode(motocicleta.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al actualizar motocicleta.');
    }
  }

  Future<void> eliminarMotocicleta(String id) async {
    final response = await http.delete(
      Uri.parse('$apiUrl/eliminar_motocicleta/$id'),
      headers: <String, String>{
        //'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Error al eliminar motocicleta.');
    }
  }

  Future<List<Motocicleta>> consultarMotocicletas() async {
    final response = await http.get(
      Uri.parse('$apiUrl/consultar_motocicletas'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        //'Authorization': 'Bearer $accessToken',
      },
    );
    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body)['data'];
      return List<Motocicleta>.from(
          l.map((model) => Motocicleta.fromJson(model)));
    } else {
      throw Exception('Error al cargar motocicletas.');
    }
  }
}