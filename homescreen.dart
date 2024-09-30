import 'package:flutter/material.dart';
import 'package:todo_list_app_new/edittaskscreen.dart';
import 'package:todo_list_app_new/taskscreen.dart';
import 'package:todo_list_app_new/taskstorage.dart'; // Import TaskStorage for local storage

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> tasks = [];
  TaskStorage taskStorage = TaskStorage(); // Instance to handle local storage

  @override
  void initState() {
    super.initState();
    _loadTasks(); // Load tasks when the screen is initialized
  }

  Future<void> _loadTasks() async {
    final loadedTasks = await taskStorage.loadTasks();
    setState(() {
      tasks = loadedTasks;
    });
  }

  Future<void> _saveTasks() async {
    await taskStorage.saveTasks(tasks); // Save tasks to local storage
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.pinkAccent,
                Colors.tealAccent,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Text(
          'To-Do List',
          style: TextStyle(fontSize: 28, color: Colors.white),
        ),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: Checkbox(
                  value: tasks[index]['isCompleted'],
                  activeColor: Colors.teal,
                  onChanged: (bool? value) {
                    setState(() {
                      tasks[index]['isCompleted'] = value!;
                      _saveTasks(); // Save tasks whenever a task is updated
                    });
                  },
                ),
                title: Text(
                  tasks[index]['title'],
                  style: TextStyle(
                    fontSize: 18,
                    decoration: tasks[index]['isCompleted']
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    color: tasks[index]['isCompleted']
                        ? Colors.grey
                        : Colors.black,
                  ),
                ),
                subtitle: Text(tasks[index]['description']),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _confirmDeleteTask(index),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditTaskScreen(
                        task: tasks[index]['title'],
                        description: tasks[index]['description'],
                        isCompleted: tasks[index]['isCompleted'],
                        onSave: (updatedTask, updatedDescription,
                            updatedCompletion) {
                          setState(() {
                            tasks[index]['title'] = updatedTask;
                            tasks[index]['description'] = updatedDescription;
                            tasks[index]['isCompleted'] = updatedCompletion;
                            _saveTasks(); // Save tasks after editing
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: Container(
        width: 60,
        height: 60,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.tealAccent,
              Colors.pinkAccent,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          shape: BoxShape.circle,
        ),
        child: FloatingActionButton(
          onPressed: () async {
            final newTask = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddTaskScreen(),
              ),
            );
            if (newTask != null) {
              setState(() {
                tasks.add(newTask);
                _saveTasks(); // Save new task to local storage
              });
            }
          },
          child: const Icon(Icons.add),
          backgroundColor: Colors.transparent,
        ),
      ),
    );
  }

  void _confirmDeleteTask(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Task'),
        content: const Text('Are you sure you want to delete this task?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                tasks.removeAt(index);
                _saveTasks(); // Save changes after task deletion
              });
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
