import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_list_app/data/models/todo.dart';
import 'package:todo_list_app/presentation/todo_bloc/todo_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  addTodo(Todo todo) {
    context.read<TodoBloc>().add(AddTodoEvent(todo));
  }

  removeTodo(Todo todo) {
    context.read<TodoBloc>().add(RemoveTodoEvent(todo));
  }

  alterTodo(int index, bool isDone) {
    context.read<TodoBloc>().add(AlterTodoEvent(index, isDone));
  }

  changeFilter(TodoFilter filter) {
    context.read<TodoBloc>().add(ChangeFilterEvent(filter));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface.withOpacity(0.3),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
        title: const Text(
          'Todo List',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FilterChip(
                    label: const Text('All'),
                    selected:
                        context.read<TodoBloc>().state.filter == TodoFilter.all,
                    onSelected: (bool selected) {
                      changeFilter(TodoFilter.all);
                    },
                  ),
                  const SizedBox(width: 8),
                  FilterChip(
                    label: const Text('Completed'),
                    selected: context.read<TodoBloc>().state.filter ==
                        TodoFilter.completed,
                    onSelected: (bool selected) {
                      changeFilter(TodoFilter.completed);
                    },
                  ),
                  const SizedBox(width: 8),
                  FilterChip(
                    label: const Text('Pending'),
                    selected: context.read<TodoBloc>().state.filter ==
                        TodoFilter.pending,
                    onSelected: (bool selected) {
                      changeFilter(TodoFilter.pending);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: BlocBuilder<TodoBloc, TodoState>(
                  builder: (context, state) {
                    List<Todo> filteredTodos;
                    switch (state.filter) {
                      case TodoFilter.completed:
                        filteredTodos =
                            state.todos.where((todo) => todo.isDone).toList();
                        break;
                      case TodoFilter.pending:
                        filteredTodos =
                            state.todos.where((todo) => !todo.isDone).toList();
                        break;
                      case TodoFilter.all:
                      default:
                        filteredTodos = state.todos;
                    }

                    if (state.status == TodoStatus.success) {
                      return ListView.builder(
                        padding: const EdgeInsets.only(bottom: 80),
                        physics: const BouncingScrollPhysics(),
                        itemCount: filteredTodos.length,
                        itemBuilder: (context, int i) {
                          return Card(
                            color: Theme.of(context).colorScheme.primary,
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Slidable(
                              key: const ValueKey(0),
                              startActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (_) {
                                      removeTodo(filteredTodos[i]);
                                    },
                                    backgroundColor: const Color(0xFFFE4A49),
                                    foregroundColor: Colors.white,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    icon: Icons.delete,
                                    label: 'Delete',
                                  ),
                                ],
                              ),
                              child: ListTile(
                                title: Text(
                                  filteredTodos[i].title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.white,
                                    decoration: filteredTodos[i].isDone
                                        ? TextDecoration.lineThrough
                                        : null,
                                  ),
                                ),
                                subtitle: Text(
                                  filteredTodos[i].subtitle,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                trailing: Checkbox(
                                  value: filteredTodos[i].isDone,
                                  activeColor:
                                      Theme.of(context).colorScheme.secondary,
                                  onChanged: (value) {
                                    alterTodo(
                                        state.todos.indexOf(filteredTodos[i]),
                                        value!);
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else if (state.status == TodoStatus.initial) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                TextEditingController controller1 = TextEditingController();
                TextEditingController controller2 = TextEditingController();

                return AlertDialog(
                  title: const Text('Add a Task'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: controller1,
                        cursorColor: Theme.of(context).colorScheme.secondary,
                        autofocus: true,
                        decoration: InputDecoration(
                          hintText: 'Task Title...',
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: controller2,
                        cursorColor: Theme.of(context).colorScheme.secondary,
                        decoration: InputDecoration(
                          hintText: 'Task Description...',
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        if (controller1.text.isEmpty) {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text('Title is mandatory'),
                              backgroundColor:
                                  Theme.of(context).colorScheme.error,
                            ),
                          );
                        } else {
                          addTodo(Todo(
                            title: controller1.text,
                            subtitle: controller2.text,
                          ));
                          controller1.text = '';
                          controller2.text = '';
                          Navigator.pop(context);
                        }
                      },
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        foregroundColor:
                            Theme.of(context).colorScheme.secondary,
                      ),
                      child: const Text("Add"),
                    )
                  ],
                );
              });
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(
          CupertinoIcons.add,
          color: Colors.black,
        ),
      ),
    );
  }
}
