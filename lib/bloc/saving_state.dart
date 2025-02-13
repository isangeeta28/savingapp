//part of 'savings_bloc.dart';

import 'package:equatable/equatable.dart';
import '../models/saving_model.dart';

abstract class SavingsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SavingsInitial extends SavingsState {}

class SavingsLoaded extends SavingsState {
  final SavingsModel savings;

  SavingsLoaded(this.savings);

  @override
  List<Object?> get props => [savings];
}
