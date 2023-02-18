import 'package:basic_banking/screens/choose_receiver_screen/cubit/choose_receiver_cubit.dart';
import 'package:basic_banking/screens/choose_sender_screen/choose_sender_screen.dart';
import 'package:basic_banking/screens/choose_sender_screen/cubit/db_cubit.dart';
import 'package:basic_banking/screens/sender_info_screen/cubit/sender_info_cubit.dart';
import 'package:basic_banking/screens/transfer_balance_screen/cubit/transfer_balance_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransferBalanceScreen extends StatelessWidget {
  TransferBalanceScreen({Key? key}) : super(key: key);

  static const String routeName = 'Transfer Balance';

  static const TextStyle _textStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  final formKey = GlobalKey<FormState>();

  late String money;

  TextEditingController moneyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransferBalanceCubit, TransferBalanceState>(
      builder: (context, state) {
        TransferBalanceCubit transferBalanceCubit =
            BlocProvider.of<TransferBalanceCubit>(context);
        ChooseReceiverCubit chooseReceiverCubit =
            BlocProvider.of<ChooseReceiverCubit>(context);
        SenderInfoCubit userInfoCubit =
            BlocProvider.of<SenderInfoCubit>(context);
        DbCubit dbCubit = BlocProvider.of<DbCubit>(context);
        return Scaffold(
            appBar: AppBar(
              title: const Text('Transfer Balance'),
            ),
            body: Form(
              key: formKey,
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  const Text(
                    'Confirm Transfer',
                    style: TextStyle(
                      color: Color(0xff002e50),
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  Image.asset(
                    'assets/logo.png',
                    height: 100,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: Text(
                          userInfoCubit.sender["name"],
                          overflow: TextOverflow.visible,
                          style: _textStyle,
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_outlined,
                        size: 22,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: Text(
                          chooseReceiverCubit.receiver["name"],
                          overflow: TextOverflow.visible,
                          style: _textStyle,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        userInfoCubit.sender["balance"].toString(),
                        style: _textStyle,
                      ),
                      Text(
                        chooseReceiverCubit.receiver["balance"].toString(),
                        style: _textStyle,
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  TextFormField(
                    controller: moneyController,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      money = value;
                    },
                    validator: (value) {
                      if (moneyController.text.isEmpty) {
                        return 'Please enter amount of money to transfer';
                      } else {
                        return transferBalanceCubit.validateTransferBalance(
                            value: value,
                            senderBalance: userInfoCubit.sender['balance'],
                            receiverBalance:
                                chooseReceiverCubit.receiver['balance']);
                      }
                    },
                    decoration: const InputDecoration(
                      labelText: 'Amount',
                      border: OutlineInputBorder(),
                      hintText: 'Enter Amount',
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff002e50),
                      ),
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          await dbCubit
                              .editUser(
                                  id: userInfoCubit.sender['id'],
                                  money: userInfoCubit.sender['balance'] -
                                      double.parse(money),
                                  user: userInfoCubit.sender)
                              .then((value) {
                            dbCubit
                                .editUser(
                                    id: chooseReceiverCubit.receiver['id'],
                                    money: chooseReceiverCubit
                                            .receiver['balance'] +
                                        double.parse(money),
                                    user: chooseReceiverCubit.receiver)
                                .then((value) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('Transfer Successful'),
                              ));
                              Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  ChooseSenderScreen.routeName,
                                  (route) => false);
                            });
                          });
                        }
                      },
                      child: const Text(
                        'Transfer',
                        style: _textStyle,
                      ),
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }
}
