import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movie_library/blocs/sign_in/sign_in_bloc.dart';

import 'package:movie_library/blocs/user/user_bloc.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 32),
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/account.png'),
            ),
            const SizedBox(height: 12),
            BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state.status == UserStatus.success) {
                  return Text(state.user!.name);
                } else {
                  return const Text('Guest');
                }
              },
            ),

            const SizedBox(height: 32),
            const Divider(),

            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                context.read<SignInBloc>().add(SignOutRequired());
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
