import 'package:equatable/equatable.dart';

// part of 'savings_bloc.dart';

abstract class SavingsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadSavingsEvent extends SavingsEvent {}

class AddSavingsEvent extends SavingsEvent {
  final int amount;

  AddSavingsEvent(this.amount);

  @override
  List<Object?> get props => [amount];
}

class WithdrawEvent extends SavingsEvent {
  final int amount;
  final bool fromCompA;

  WithdrawEvent(this.amount, this.fromCompA);

  @override
  List<Object?> get props => [amount, fromCompA];
}
