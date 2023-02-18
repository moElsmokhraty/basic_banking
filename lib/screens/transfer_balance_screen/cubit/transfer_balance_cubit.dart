import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'transfer_balance_state.dart';

class TransferBalanceCubit extends Cubit<TransferBalanceState> {
  TransferBalanceCubit() : super(TransferBalanceInitial());

  String? validateTransferBalance({dynamic value, required double senderBalance, required double receiverBalance}){
    if (double.parse(value) <= 0){
      emit(TransferBalanceError());
      return 'Please enter a valid amount of money';
    }else if(double.parse(value) > senderBalance){
      emit(TransferBalanceError());
      return 'You don\'t have enough money';
    } else{
      emit(TransferBalanceSuccess());
      return null;
    }
  }
}
