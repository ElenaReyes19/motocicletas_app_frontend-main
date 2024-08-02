import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/motocicleta_model.dart';
import '../../helpers/navigator_key.dart';
import '../../presentation/cubit/motocicleta_state.dart';
import '../cubit/motocicleta_cubit.dart';
import 'motocicleta_delete_confirmation.dart';
import 'motocicleta_details.dart';
import 'motocicleta_form.dart';

class MotocicletaTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Realiza la petición para cargar las motocicletas
    context.read<MotocicletaCubit>().consultarMotocicletas();

    return BlocBuilder<MotocicletaCubit, MotocicletaState>(
      builder: (context, state) {
        if (state is MotocicletaLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is MotocicletaSuccess) {
          return ListView.builder(
            padding: EdgeInsets.all(16.0),
            itemCount: state.motocicletas.length,
            itemBuilder: (context, index) {
              final motocicleta = state.motocicletas[index];
              return Card(
                elevation: 4.0,
                margin: EdgeInsets.symmetric(vertical: 8.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ID: ${motocicleta.id}',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                      SizedBox(height: 4.0),
                      Text('Marca: ${motocicleta.marca}',
                          style: TextStyle(fontSize: 14)),
                      SizedBox(height: 4.0),
                      Text('Modelo: ${motocicleta.modelo}',
                          style: TextStyle(fontSize: 14)),
                      SizedBox(height: 4.0),
                      Text('Cilindrada: ${motocicleta.cilindrada}',
                          style: TextStyle(fontSize: 14)),
                      SizedBox(height: 4.0),
                      Text('Color: ${motocicleta.color}',
                          style: TextStyle(fontSize: 14)),
                      SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: Icon(Icons.visibility,
                                color: Colors.blue, size: 20),
                            onPressed: () {
                              showMotocicletaDetails(context, motocicleta);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.edit,
                                color: Colors.orange, size: 20),
                            onPressed: () {
                              showMotocicletaForm(context, motocicleta);
                            },
                          ),
                          IconButton(
                            icon:
                                Icon(Icons.delete, color: Colors.red, size: 20),
                            onPressed: () {
                              showMotocicletaDeleteConfirmation(context, motocicleta);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else if (state is MotocicletaError) {
          return Center(child: Text('Error: ${state.message}'));
        }
        return Center(child: Text('No hay motocicletas disponibles.'));
      },
    );
  }

  void showMotocicletaDetails(BuildContext context, Motocicleta motocicleta) {
    showDialog(
      context: navigatorKey.currentContext!,
      builder: (context) => MotocicletaDetails(motocicleta: motocicleta),
    );
  }

  void showMotocicletaForm(BuildContext context, Motocicleta? motocicleta) {
    showDialog(
      context: navigatorKey.currentContext!,
      builder: (context) => MotocicletaForm(motocicleta: motocicleta),
    );
  }

  void showMotocicletaDeleteConfirmation(BuildContext context, Motocicleta motocicleta) {
    showDialog(
      context: navigatorKey.currentContext!,
      builder: (context) => MotocicletaDeleteConfirmation(motocicleta: motocicleta),
    );
  }
}