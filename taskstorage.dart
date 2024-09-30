import 'package:shared_preferences/shared_preferences.dart';

class TaskStorage {
  Future<List<Map<String, dynamic>>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? savedTasks = prefs.getStringList('tasks');
    if (savedTasks != null) {
      return savedTasks.map((task) {
        final parts = task.split('|');
        return {
          'title': parts[0],
          'description': parts[1],
          'isCompleted': parts[2] == 'true',
        };
      }).toList();
    }
    return [];
  }

  Future<void> saveTasks(List<Map<String, dynamic>> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> tasksToSave = tasks.map((task) {
      return '${task['title']}|${task['description']}|${task['isCompleted']}';
    }).toList();
    await prefs.setStringList('tasks', tasksToSave);
  }
}
