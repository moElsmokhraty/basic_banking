import 'package:basic_banking/screens/choose_sender_screen/widgets/senders_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/db_cubit.dart';

class ChooseSenderScreen extends StatelessWidget {
  const ChooseSenderScreen({Key? key}) : super(key: key);

  static const String routeName = 'Users List';

  static const TextStyle _textStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    DbCubit cubit = BlocProvider.of<DbCubit>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Users List'),
        ),
        body: BlocBuilder<DbCubit, DBState>(builder: (context, state) {
          if (state is DBLoading) {
            return Center(
                child: Row(
              children: const [
                Spacer(),
                CircularProgressIndicator(),
                Spacer(),
              ],
            ));
          } else if (state is DBGetUsers) {
            if (cubit.users.isEmpty) {
              return const Center(
                  child: Text(
                'No Users',
                style: _textStyle,
              ));
            } else {
              return const SendersListView();
            }
          } else if (state is DBCreated) {
            return const Center(
                child: Text(
              'No Users',
              style: _textStyle,
            ));
          } else {
            return const Center(
                child: Text(
              'No Users',
              style: _textStyle,
            ));
          }
        }));
  }
}
