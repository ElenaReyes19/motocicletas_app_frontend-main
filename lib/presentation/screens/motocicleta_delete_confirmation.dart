import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/motocicleta_model.dart';
import '../cubit/motocicleta_cubit.dart';

class MotocicletaDeleteConfirmation extends StatelessWidget {
  final Motocicleta motocicleta;

  const MotocicletaDeleteConfirmation({super.key, required this.motocicleta});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Eliminar Motocicleta'),
      content: const Text('¿Estás seguro de que quieres eliminar esta motocicleta?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            context
                .read<MotocicletaCubit>()
                .eliminarMotocicleta(motocicleta.id.toString());
            Navigator.of(context).pop();
          },
          child: const Text('Eliminar'),
        ),
      ],
    );
  }
}