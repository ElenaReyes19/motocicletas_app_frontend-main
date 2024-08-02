import 'package:flutter/material.dart';

import '../../data/models/motocicleta_model.dart';

class MotocicletaDetails extends StatelessWidget {
  final Motocicleta motocicleta;

  const MotocicletaDetails({super.key, required this.motocicleta});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Detalles de la Motocicleta',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailRow('ID:', motocicleta.id.toString()),
          _buildDetailRow('Marca:', motocicleta.marca),
          _buildDetailRow('Modelo:', motocicleta.modelo),
          _buildDetailRow('Cilindrada:', motocicleta.cilindrada.toString()),
          _buildDetailRow('Color:', motocicleta.color),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cerrar'),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          SizedBox(width: 8.0),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey[700],
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}