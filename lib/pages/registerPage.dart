import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:pr3/api/supbase.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _supabase = SupabaseService().client;

  Future<void> _signUp() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    try {
      // Попытка регистрации
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
      );

      // Проверяем, есть ли пользователь в ответе
      if (response.user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Регистрация прошла успешно. Проверьте вашу почту для подтверждения.'),
          ),
        );
        Navigator.of(context).pop(); // Возвращаемся на страницу авторизации
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Произошла ошибка при регистрации.')),
        );
      }
    } on AuthException catch (error) {
      // Обрабатываем ошибки авторизации
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.message)),
      );
    } catch (error) {
      // Обрабатываем другие ошибки
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Произошла ошибка: ${error.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Регистрация')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Пароль'),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _signUp,
              child: const Text('Зарегистрироваться'),
            ),
          ],
        ),
      ),
    );
  }
}