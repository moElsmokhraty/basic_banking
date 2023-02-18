import 'package:basic_banking/component.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';

part 'db_state.dart';

class DbCubit extends Cubit<DBState> {
  DbCubit() : super(DBInitial());

  late Database database;

  List<Map<String, dynamic>> users = [];

  void insertUser(Map<String, dynamic> user) async {
    await databaseHelper.insert(user).then((value) {
      emit(DBGetUsers());
      print(value);
    });
  }

  Future<void> getData() async {
    emit(DBLoading());
    await databaseHelper.queryAllRows().then((value) {
      users = value;
      emit(DBGetUsers());
    }).catchError((error) {
      print(error.toString());
      emit(GatDataError());
    });
  }

  Future<void> update({required int id, required Map<String, dynamic> user}) async {
    emit(DBLoading());
    databaseHelper.updateItem(id, user).then((value){
      getData();
    }).catchError((error) {
      print(error.toString());
      emit(GatDataError());
    });
  }

  editUser({required int id, required Map<String, dynamic> user, required double money}) async {
    await update(id: id, user: {
      'name': user['name'],
      'email': user['email'],
      'phone': user['phone'],
      'balance': money,
    });
    }
}
