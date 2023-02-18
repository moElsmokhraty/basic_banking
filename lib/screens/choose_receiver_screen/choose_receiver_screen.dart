import 'package:basic_banking/screens/choose_receiver_screen/cubit/choose_receiver_cubit.dart';
import 'package:basic_banking/screens/choose_receiver_screen/widgets/receivers_list_view.dart';
import 'package:basic_banking/screens/sender_info_screen/cubit/sender_info_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChooseReceiverScreen extends StatelessWidget {
  const ChooseReceiverScreen({Key? key}) : super(key: key);

  static const String routeName = 'Choose Receiver';

  @override
  Widget build(BuildContext context) {
    SenderInfoCubit userInfoCubit = BlocProvider.of<SenderInfoCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Receiver'),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          children: [
            const SizedBox(height: 30),
            TextField(
              controller: TextEditingController(text: userInfoCubit.sender['name']),
              enabled: false,
              decoration: const InputDecoration(
                labelText: 'Sender Name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person_rounded, color: Color(0xff002e50),),
              ),
            ),
            const SizedBox(height: 10,),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
                child: BlocBuilder<ChooseReceiverCubit, ChooseReceiverState>(builder: (context, state) {
                  return const ReceiversListView();
                })
            ),
          ],
        ),
      ),
    );
  }
}
