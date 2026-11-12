import 'package:flutter/material.dart';

import 'app.dart';
import 'features/home/data/in_memory_task_repository.dart';

void main() {
  // One repository for the whole app, so tasks survive screen changes.
  runApp(CampusHubApp(repository: InMemoryTaskRepository()));
}
