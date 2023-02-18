import 'package:basic_banking/screens/choose_sender_screen/cubit/db_cubit.dart';
import 'package:basic_banking/screens/sender_info_screen/cubit/sender_info_cubit.dart';
import 'package:basic_banking/screens/sender_info_screen/user_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SendersListView extends StatelessWidget {
  const SendersListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DbCubit dbCubit = BlocProvider.of<DbCubit>(context);
    SenderInfoCubit userInfoCubit = BlocProvider.of<SenderInfoCubit>(context);
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            userInfoCubit.selectSender(dbCubit.users[index]);
            Navigator.pushNamed(context, SenderInfoScreen.routeName);
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
      itemCount: dbCubit.users.length,
    );
  }
}
