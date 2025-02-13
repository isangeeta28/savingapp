import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:savingapp/bloc/saving_event.dart';
import 'package:savingapp/bloc/saving_state.dart';

import '../models/saving_model.dart';
import '../services/storage_services.dart';

class SavingsBloc extends Bloc<SavingsEvent, SavingsState> {
  final StorageService _storageService = StorageService();

  SavingsBloc() : super(SavingsInitial()) {
    on<LoadSavingsEvent>(_onLoadSavings);
    on<AddSavingsEvent>(_onAddSavings);
    on<WithdrawEvent>(_onWithdraw);
  }

  Future<void> _onLoadSavings(LoadSavingsEvent event, Emitter<SavingsState> emit) async {
    final savings = await _storageService.loadSavings();
    emit(SavingsLoaded(savings));
  }

  Future<void> _onAddSavings(AddSavingsEvent event, Emitter<SavingsState> emit) async {
    final currentSavings = await _storageService.loadSavings();
    final newSavings = SavingsModel(
      compA: currentSavings.compA + (event.amount ~/ 2),
      compB: currentSavings.compB + (event.amount ~/ 2),
      history: [
        ...currentSavings.history,
        "Added ₹${event.amount} (₹${event.amount ~/ 2} to each)"
      ],
    );
    await _storageService.saveSavings(newSavings);
    emit(SavingsLoaded(newSavings));
  }

  Future<void> _onWithdraw(WithdrawEvent event, Emitter<SavingsState> emit) async {
    final currentSavings = await _storageService.loadSavings();
    if (event.fromCompA && currentSavings.compA >= event.amount) {
      currentSavings.compA -= event.amount;
      currentSavings.history.add("Withdrew ₹${event.amount} from CompA");
    } else if (!event.fromCompA && currentSavings.compB >= event.amount) {
      currentSavings.compB -= event.amount;
      currentSavings.history.add("Withdrew ₹${event.amount} from CompB");
    }
    await _storageService.saveSavings(currentSavings);
    emit(SavingsLoaded(currentSavings));
  }

}
