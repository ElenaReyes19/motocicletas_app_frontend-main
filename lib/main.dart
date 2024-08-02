import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patinete_app_frontend/presentation/screens/motocicleta_form.dart';

import 'data/repository/motocicleta_repository.dart';
import 'helpers/navigator_key.dart';
import 'presentation/cubit/motocicleta_cubit.dart';
import 'presentation/screens/motocicleta_table.dart';

void main() {
  final MotocicletaRepository motocicletaRepository =
      MotocicletaRepository(apiUrl: 'https://a8v55x1swe.execute-api.us-west-1.amazonaws.com/Dev');
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              MotocicletaCubit(motocicletaRepository: motocicletaRepository),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
        navigatorKey: navigatorKey, // Use the imported navigatorKey
      ),
    ),
  );
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Motocicletas')),
      body: MotocicletaTable(),
      floatingActionButton: FloatingActionButton(
        onPressed: showCreateDialog,
        child: Icon(Icons.add),
      ),
    );
  }

  void showCreateDialog() {
    showDialog(
      context: navigatorKey.currentContext!,
      builder: (context) => MotocicletaForm(),
    );
  }
}