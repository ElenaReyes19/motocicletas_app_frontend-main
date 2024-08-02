import 'package:equatable/equatable.dart';
import '../../data/models/motocicleta_model.dart';

abstract class MotocicletaState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MotocicletaInitial extends MotocicletaState {}

class MotocicletaLoading extends MotocicletaState {}

class MotocicletaSuccess extends MotocicletaState {
  final List<Motocicleta> motocicletas;

  MotocicletaSuccess({required this.motocicletas});

  @override
  List<Object?> get props => [motocicletas];
}

class MotocicletaError extends MotocicletaState {
  final String message;

  MotocicletaError({required this.message});

  @override
  List<Object?> get props => [message];
}