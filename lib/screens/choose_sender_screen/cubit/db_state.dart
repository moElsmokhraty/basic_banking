part of 'db_cubit.dart';

@immutable
abstract class DBState {}

class DBInitial extends DBState {}

class DBCreated extends DBState {}

class DBGetUsers extends DBState {}

class DBLoading extends DBState {}

class GatDataError extends DBState {}
