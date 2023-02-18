import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'choose_receiver_state.dart';

class ChooseReceiverCubit extends Cubit<ChooseReceiverState> {
  ChooseReceiverCubit() : super(ChooseReceiverInitial());

  Map<String, dynamic> receiver = {};

  void selectReceiver(Map<String, dynamic> user) {
    receiver = user;
    emit(ChooseReceiverSelected());
  }
}
