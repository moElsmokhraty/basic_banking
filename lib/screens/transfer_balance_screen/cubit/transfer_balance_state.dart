part of 'transfer_balance_cubit.dart';

@immutable
abstract class TransferBalanceState {}

class TransferBalanceInitial extends TransferBalanceState {}

class TransferBalanceError extends TransferBalanceState {}

class TransferBalanceSuccess extends TransferBalanceState {}
