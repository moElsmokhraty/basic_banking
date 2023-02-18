import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../choose_receiver_screen/choose_receiver_screen.dart';
import 'cubit/sender_info_cubit.dart';

class SenderInfoScreen extends StatelessWidget {
  const SenderInfoScreen({Key? key}) : super(key: key);

  static const String routeName = 'User Info';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Info'),
      ),
      body: BlocBuilder<SenderInfoCubit, SenderInfoState>(
        builder: (context, state){
          SenderInfoCubit cubit = BlocProvider.of<SenderInfoCubit>(context);
          return Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset('assets/logo.png', height: 100,),
                TextField(
                  controller: TextEditingController(text: cubit.sender['name']),
                  enabled: false,
                  decoration: const InputDecoration(
                    labelText: 'User Name',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person_rounded),
                  ),
                ),
                TextField(
                  controller: TextEditingController(text: cubit.sender['email']),
                  enabled: false,
                  decoration: const InputDecoration(
                    labelText: 'User Email',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email_rounded),
                  ),
                ),
                TextField(
                  controller: TextEditingController(text: cubit.sender['phone']),
                  enabled: false,
                  decoration: const InputDecoration(
                    labelText: 'User Phone',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.phone_rounded),
                  ),
                ),
                TextField(
                  controller: TextEditingController(text: cubit.sender['balance'].toString()),
                  enabled: false,
                  decoration: const InputDecoration(
                    labelText: 'User Balance',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.monetization_on_rounded),
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(const Color(
                          0xff002e50)),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, ChooseReceiverScreen.routeName);
                    },
                    child: const Text(
                      'Transfer Money',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }

      ),
    );
  }
}
