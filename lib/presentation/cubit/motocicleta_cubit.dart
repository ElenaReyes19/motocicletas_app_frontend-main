import 'package:bloc/bloc.dart';
import '../../data/models/motocicleta_model.dart';
import '../../data/repository/motocicleta_repository.dart';
import 'motocicleta_state.dart';

class MotocicletaCubit extends Cubit<MotocicletaState> {
  final MotocicletaRepository motocicletaRepository;

  MotocicletaCubit({required this.motocicletaRepository}) : super(MotocicletaInitial());

  Future<void> crearMotocicleta(Motocicleta motocicleta) async {
    try {
      emit(MotocicletaLoading());
      await motocicletaRepository.crearMotocicleta(motocicleta);
      final motocicletas = await motocicletaRepository.consultarMotocicletas();
      emit(MotocicletaSuccess(motocicletas: motocicletas));
    } catch (e) {
      emit(MotocicletaError(message: e.toString()));
    }
  }

  Future<void> consultarMotocicleta(String id) async {
    try {
      emit(MotocicletaLoading());
      final motocicleta = await motocicletaRepository.consultarMotocicleta(id);
      emit(MotocicletaSuccess(motocicletas: [motocicleta]));
    } catch (e) {
      emit(MotocicletaError(message: e.toString()));
    }
  }

  Future<void> actualizarMotocicleta(Motocicleta motocicleta) async {
    try {
      emit(MotocicletaLoading());
      await motocicletaRepository.actualizarMotocicleta(motocicleta);
      final motocicletas = await motocicletaRepository.consultarMotocicletas();
      emit(MotocicletaSuccess(motocicletas: motocicletas));
    } catch (e) {
      emit(MotocicletaError(message: e.toString()));
    }
  }

  Future<void> eliminarMotocicleta(String id) async {
    try {
      emit(MotocicletaLoading());
      await motocicletaRepository.eliminarMotocicleta(id);
      final motocicletas = await motocicletaRepository.consultarMotocicletas();
      emit(MotocicletaSuccess(motocicletas: motocicletas));
    } catch (e) {
      emit(MotocicletaError(message: e.toString()));
    }
  }

  Future<void> consultarMotocicletas() async {
    try {
      emit(MotocicletaLoading());
      final motocicletas = await motocicletaRepository.consultarMotocicletas();
      emit(MotocicletaSuccess(motocicletas: motocicletas));
    } catch (e) {
      emit(MotocicletaError(message: e.toString()));
    }
  }
}