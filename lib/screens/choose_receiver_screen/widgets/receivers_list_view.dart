import 'package:basic_banking/screens/choose_receiver_screen/cubit/choose_receiver_cubit.dart';
import 'package:basic_banking/screens/choose_sender_screen/cubit/db_cubit.dart';
import 'package:basic_banking/screens/transfer_balance_screen/transfer_balance_screen.dart';
import 'package:basic_banking/screens/sender_info_screen/cubit/sender_info_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReceiversListView extends StatelessWidget {
  const ReceiversListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
    itemBuilder: (context, index) {
      ChooseReceiverCubit chooseReceiverCubit = BlocProvider.of<ChooseReceiverCubit>(context);
      SenderInfoCubit userInfoCubit = BlocProvider.of<SenderInfoCubit>(context);
      DbCubit dbCubit = BlocProvider.of<DbCubit>(context);
      return ListTile(
        onTap: () {
          if(dbCubit.users[index]['id'] == userInfoCubit.sender['id']) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('You cannot transfer money to yourself'),
              ),
            );
          } else {
            chooseReceiverCubit
                .selectReceiver(dbCubit.users[index]);
            Navigator.pushNamed(context, TransferBalanceScreen.routeName);
          }
        },
        title: Text(dbCubit.users[index]['name']),
        subtitle: Text(dbCubit.users[index]['email']),
        trailing: Text(dbCubit.users[index]['balance'].toString()),
      );
    },
    separatorBuilder: (context, index) {
      return Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[500],
      );
    },
    itemCount: 10,
      );
  }
}
