import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:iot_flutter_project/bloc/user/profile_bloc.dart';
import 'package:iot_flutter_project/bloc/user/profile_events.dart';
import 'package:iot_flutter_project/bloc/user/profile_states.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {

    context.read<ProfileBloc>().add(LoadUserProfile());

    return Scaffold(
      appBar: AppBar(title: const Text('User Profile')),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileLoaded) {
            return _buildUserProfile(context, state);
          } else if (state is ConnectivityUpdated) {
            if (!state.isConnected) {
              return _buildNoConnectionMessage(context);
            }

            return _buildUserProfile(context, state as ProfileLoaded);
          } else if (state is ProfileError) {
            return Center(child: Text('Error: ${state.error}'));
          } else if (state is ProfileInitial) {
            return const Center(child: Text('Loading...'));
          }

          return const Center(child: Text('Unknown state'));
        },
      ),
    );
  }

  Widget _buildUserProfile(BuildContext context, ProfileLoaded state) {
    final userInfo = state.userInfo;
    final username = userInfo['username'] ?? 'Username';
    final email = userInfo['email'] ?? 'Email';
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blue,
              child: Icon(
                Icons.person,
                size: 50,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              username,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              email,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoConnectionMessage(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'No Internet Connection',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              BlocProvider.of<ProfileBloc>(context).add(CheckConnectivity());
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
