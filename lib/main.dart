import 'package:basic_banking/bloc_observer.dart';
import 'package:basic_banking/screens/choose_receiver_screen/choose_receiver_screen.dart';
import 'package:basic_banking/screens/choose_receiver_screen/cubit/choose_receiver_cubit.dart';
import 'package:basic_banking/screens/choose_sender_screen/choose_sender_screen.dart';
import 'package:basic_banking/screens/choose_sender_screen/cubit/db_cubit.dart';
import 'package:basic_banking/screens/transfer_balance_screen/cubit/transfer_balance_cubit.dart';
import 'package:basic_banking/screens/transfer_balance_screen/transfer_balance_screen.dart';
import 'package:basic_banking/screens/sender_info_screen/cubit/sender_info_cubit.dart';
import 'package:basic_banking/screens/sender_info_screen/user_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'component.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await databaseHelper.init();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(const BasicBankingApp());
}

class BasicBankingApp extends StatelessWidget {
  const BasicBankingApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DbCubit()..getData(),
        ),
        BlocProvider(
          create: (context) => SenderInfoCubit(),
        ),
        BlocProvider(
          create: (context) => ChooseReceiverCubit(),
        ),
        BlocProvider(
          create: (context) => TransferBalanceCubit(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xff002e50)
          )
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: ChooseSenderScreen.routeName,
        routes: {
          ChooseSenderScreen.routeName: (context) => const ChooseSenderScreen(),
          SenderInfoScreen.routeName: (context) => const SenderInfoScreen(),
          ChooseReceiverScreen.routeName: (context) =>
              const ChooseReceiverScreen(),
          TransferBalanceScreen.routeName: (context) =>
              TransferBalanceScreen(),
        },
      ),
    );
  }
}
