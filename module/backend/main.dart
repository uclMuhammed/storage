import 'package:backend/backend.dart';
import 'package:backend/const/keys.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final AuthenticationService _authenticationService = AuthenticationService();
  final AuthoritiesService _authoritiesService = AuthoritiesService();
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  Future<void> login() async {
    try {
      await _authenticationService.init();
      //
      final response = await _authenticationService.login(
          companyCode: 68738, email: 'test11@gmail.com', password: 'testpass');
      //
      if (response) {
        if (kDebugMode) print('Login Success');
      } else {
        if (kDebugMode) print('Login Failed');
      }
      //
    } catch (e) {
      if (kDebugMode) print(e);
    }
  }

  Future<void> register() async {
    try {
      await _authenticationService.init();
      //
      final response = await _authenticationService.register(
        companyName: 'Test Company',
        email: 'testFlutter$_counter@gmail.com',
        password: 'testpass',
      );
      //
      if (response) {
        if (kDebugMode) print('Register Success');
      } else {
        if (kDebugMode) print('Register Failed');
      }
      //
    } catch (e) {
      if (kDebugMode) print(e);
    }
  }

  Future<void> logout() async {
    try {
      await _authenticationService.init();
      //
      final response = await _authenticationService.logout();
      //
      if (response) {
        if (kDebugMode) print('Logout Success');
      } else {
        if (kDebugMode) print('Logout Failed');
      }
      //
    } catch (e) {
      if (kDebugMode) print(e);
    }
  }

  Future<void> readToken() async {
    try {
      await _authenticationService.init();
      //
      final token = await _authenticationService.storage?.read(BearerTokenKey);
      //
      if (token != null) {
        if (kDebugMode) print('Token: $token');
      } else {
        if (kDebugMode) print('Token Not Found');
      }
      //
    } catch (e) {
      if (kDebugMode) print(e);
    }
  }

  Future<void> authorGetAll() async {
    try {
      await _authoritiesService.init();
      //
      final response = await _authoritiesService.getAll();
      //
      if (response.isNotEmpty) {
        if (kDebugMode) print('Authorities: $response');
      } else {
        if (kDebugMode) print('Authorities Not Found');
      }
      //
      response.map((e) {
        if (kDebugMode) print('Authorities: $e');
      }).toList();
      //
    } catch (e) {
      if (kDebugMode) print(e);
    }
  }

  Future<void> authorGetById() async {
    try {
      await _authoritiesService.init();
      //
      final response = await _authoritiesService.getById(1);
      //
      print(response);
      //
    } catch (e) {
      if (kDebugMode) print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: login,
            tooltip: 'Login',
            child: const Icon(Icons.login_outlined),
          ),
          FloatingActionButton(
            onPressed: register,
            tooltip: 'Register',
            child: const Icon(Icons.save),
          ),
          FloatingActionButton(
            onPressed: logout,
            tooltip: 'Logout',
            child: const Icon(Icons.logout_outlined),
          ),
          FloatingActionButton(
            onPressed: readToken,
            tooltip: 'Read Token',
            child: const Icon(Icons.read_more_outlined),
          ),
          FloatingActionButton(
            onPressed: authorGetAll,
            tooltip: 'Author GetAll',
            child: const Icon(Icons.get_app_outlined),
          ),
          FloatingActionButton(
            onPressed: authorGetById,
            tooltip: 'Author GetById',
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Author Update',
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
