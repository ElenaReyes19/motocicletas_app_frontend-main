import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/motocicleta_model.dart';
import '../cubit/motocicleta_cubit.dart';

class MotocicletaForm extends StatelessWidget {
  final Motocicleta? motocicleta;

  MotocicletaForm({super.key, this.motocicleta});

  final _formKey = GlobalKey<FormState>();
  final _marcaController = TextEditingController();
  final _modeloController = TextEditingController();
  final _cilindradaController = TextEditingController();
  final _colorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (motocicleta != null) {
      _marcaController.text = motocicleta!.marca;
      _modeloController.text = motocicleta!.modelo;
      _cilindradaController.text = motocicleta!.cilindrada.toString();
      _colorController.text = motocicleta!.color;
    }

    return AlertDialog(
      title: Text(
        motocicleta == null ? 'Crear Motocicleta' : 'Editar Motocicleta',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTextField(_marcaController, 'Marca'),
              _buildTextField(_modeloController, 'Modelo'),
              _buildTextField(_cilindradaController, 'Cilindrada', isNumber: true),
              _buildTextField(_colorController, 'Color'),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final motocicletaCubit = context.read<MotocicletaCubit>();
              if (motocicleta == null) {
                motocicletaCubit.crearMotocicleta(
                  Motocicleta(
                    marca: _marcaController.text,
                    modelo: _modeloController.text,
                    cilindrada: int.parse(_cilindradaController.text),
                    color: _colorController.text,
                  ),
                );
              } else {
                motocicletaCubit.actualizarMotocicleta(
                  Motocicleta(
                    id: motocicleta!.id,
                    marca: _marcaController.text,
                    modelo: _modeloController.text,
                    cilindrada: int.parse(_cilindradaController.text),
                    color: _colorController.text,
                  ),
                );
              }
              Navigator.of(context).pop();
            }
          },
          child: Text(motocicleta == null ? 'Crear' : 'Actualizar'),
        ),
      ],
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, {bool isNumber = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
        ),
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor ingrese $label';
          }
          if (isNumber && int.tryParse(value) == null) {
            return 'Por favor ingrese un número válido para $label';
          }
          return null;
        },
      ),
    );
  }
}