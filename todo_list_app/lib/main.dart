import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_list_app/presentation/screens/to_do_screen.dart';
import 'package:todo_list_app/presentation/todo_bloc/todo_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TodoBloc>(
          create: (context) => TodoBloc()..add(TodoStarted()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Todo List App',
        theme: ThemeData(
          colorScheme: const ColorScheme.light(
            primary: Colors.deepPurpleAccent,
            secondary: Colors.lightGreen,
            onSecondary: Colors.white,
          ),
        ),
        home: const TodoScreen(),
      ),
    );
  }
}
