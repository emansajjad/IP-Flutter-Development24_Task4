# Flutter To-Do List App

Welcome to the **To-Do List App** repository! This Flutter app allows users to manage their daily tasks effectively. Tasks can be added, edited, and marked as completed, with data saved locally using `SharedPreferences` for persistence.

## Features

- **Add Tasks**: Create new tasks with a title and description.
- **Edit Tasks**: Modify existing tasks, including the ability to mark them as completed.
- **Task Completion**: Mark tasks as completed by checking the box.
- **Persistent Storage**: Tasks are stored locally using `SharedPreferences`, so they remain even after the app is closed and reopened.
- **Gradient UI**: The app features a modern, gradient-themed UI using teal and pink accents.

- How It Works
Task Management
Tasks are stored as a list of maps in the app's memory and are saved using SharedPreferences. Each task consists of:

Title: A brief description of the task.
Description: A detailed explanation of the task.
Completion Status: A boolean indicating whether the task is completed or not.
Local Storage
The app uses SharedPreferences to store tasks locally on the device. When tasks are added or modified, they are saved in the app's local storage and retrieved when the app is reopened.

Gradient UI
The app's theme utilizes a gradient design with pink and teal accent colors for buttons, the app bar, and other UI elements, offering a visually appealing user interface.
