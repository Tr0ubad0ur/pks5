import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:pr3/api/supbase.dart';
import 'package:pr3/pages/authPage.dart';


class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  String? _userEmail;

  @override
  void initState() {
    super.initState();
        _loadUserEmail();
  }

  Future<void> _loadUserEmail() async {
    final supabase = SupabaseService().client;
    final session = supabase.auth.currentSession;

    if (session != null && session.user != null) {
      setState(() {
        _userEmail = session.user!.email;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    final supabase = SupabaseService().client;
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Профиль',
            style: TextStyle(fontWeight: FontWeight.bold,
              letterSpacing: 3,
              fontSize: 30,
                color: Colors.white
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await supabase.auth.signOut(); // Используем supabase для выхода
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const AuthPage()),
              );
            },
          ),
        ],
        backgroundColor: const Color.fromRGBO(161, 13, 1, 1),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(''),
                  backgroundColor: Color.fromRGBO(161, 13, 1, 1)
              ),
              const SizedBox(height: 16),
              const Text(
                'Вишняков Матвей',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Телефон: +7 (985) 074-55-55',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                'Email: ${_userEmail ?? 'Загрузка...'}',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}