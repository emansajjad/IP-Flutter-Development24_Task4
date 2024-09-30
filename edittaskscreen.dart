import 'package:flutter/material.dart';

class EditTaskScreen extends StatefulWidget {
  final String task; // Task title to edit
  final String description; // Task description to edit
  final bool isCompleted; // Task completion status
  final Function(String, String, bool) onSave; // Callback for saving task

  EditTaskScreen({
    required this.task,
    required this.description,
    required this.isCompleted,
    required this.onSave,
  });

  @override
  _EditTaskScreenState createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  late TextEditingController _taskController; // Controller for task title input
  late TextEditingController
      _descriptionController; // Controller for task description input
  late bool _isCompleted; // Local state for completion status

  @override
  void initState() {
    super.initState();
    _taskController = TextEditingController(text: widget.task);
    _descriptionController = TextEditingController(text: widget.description);
    _isCompleted = widget.isCompleted;
  }

  @override
  void dispose() {
    _taskController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set the background color to white
      appBar: AppBar(
        title: const Text(
          'Edit Task',
          style: TextStyle(fontSize: 28),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.pinkAccent, Colors.tealAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
                controller: _taskController, // Controller for task title input
                decoration: const InputDecoration(
                  labelText: 'Task Title',
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.tealAccent)),
                )),
            const SizedBox(height: 16),
            TextField(
              controller:
                  _descriptionController, // Controller for task description input
              decoration: const InputDecoration(
                  labelText: 'Task Description',
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.tealAccent))),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Checkbox(
                  value: _isCompleted, // Checkbox for completion status
                  onChanged: (bool? value) {
                    setState(() {
                      _isCompleted = value!; // Update local completion status
                    });
                  },
                ),
                const Text('Mark as Completed'),
              ],
            ),
            const SizedBox(height: 20),
            //  Save Button
            ElevatedButton(
              onPressed: () {
                // Call onSave callback with updated values
                widget.onSave(
                  _taskController.text,
                  _descriptionController.text,
                  _isCompleted,
                );
                Navigator.pop(context); // Return to the previous screen
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Ink(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.pinkAccent, Colors.tealAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  alignment: Alignment.center,
                  child: const Text(
                    'Save Task',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
