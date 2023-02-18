import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'sender_info_state.dart';

class SenderInfoCubit extends Cubit<SenderInfoState> {
  SenderInfoCubit() : super(SenderInfoInitial());

  Map<String, dynamic>  sender = {};


  void selectSender(Map<String, dynamic> user){
    sender = user;
    emit(SenderSelected());
  }
}
