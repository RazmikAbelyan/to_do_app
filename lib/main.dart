import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/core/model/filter.dart';
import 'package:to_do_app/ui/feature/home/bloc/home_bloc.dart';
import 'package:to_do_app/ui/feature/home/view/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TODOApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<HomeBloc>(
        create: (context) => HomeBloc(),
        child: const MyHomePage(title: 'All Tasks'),
      ),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              context.read<HomeBloc>().add(HomeTaskFiltered(filter: value));
            },
            itemBuilder: (BuildContext ctx) {
              return [
                const PopupMenuItem(
                  value: Filter.done,
                  child: Text(
                    "Show only completed",
                  ),
                ),
                const PopupMenuItem(
                  value: Filter.todo,
                  child: Text(
                    "Show only not completed",
                  ),
                ),
                const PopupMenuItem(
                  value: Filter.all,
                  child: Text(
                    "Show all",
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: const HomeScreen(),
    );
  }
}
