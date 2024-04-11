import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:iot_flutter_project/repository/local_storage_repository.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<Map<String, String>> _userInfoFuture;
  late bool _isConnected;

  @override
  void initState() {
    super.initState();
    _userInfoFuture = _getUserInfo();
    _checkConnectivity();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {
        _isConnected = (result != ConnectivityResult.none);
      });
    });
  }

  Future<void> _checkConnectivity() async {
    final result = await Connectivity().checkConnectivity();
    setState(() {
      _isConnected = (result != ConnectivityResult.none);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Profile')),
      body: _isConnected ? _buildUserProfile() : _buildNoConnectionMessage(),
    );
  }

  Widget _buildUserProfile() {
    return FutureBuilder(
      future: _userInfoFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        final Map<String, String> userInfo =
            snapshot.data as Map<String, String>;
        final String username = userInfo['username'] ?? 'Username';
        final String email = userInfo['email'] ?? 'Email';

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
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/edit_profile').then((_) {
                      setState(() {
                        _userInfoFuture = _getUserInfo();
                      });
                    });
                  },
                  child: const Text('Edit Profile'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    _showLogoutConfirmationDialog(context);
                  },
                  child: const Text('Logout'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildNoConnectionMessage() {
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
            onPressed: _checkConnectivity,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  final LocalStorageRepository _localStorageRepository =
      LocalStorageRepository();

  Future<Map<String, String>> _getUserInfo() async {
    final userInfo = await _localStorageRepository.getUserInfo();
    return userInfo;
  }

  Future<void> _logout(BuildContext context) async {
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  Future<void> _showLogoutConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                _logout(context);
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }
}
