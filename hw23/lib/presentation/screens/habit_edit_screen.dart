import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/habit.dart';
import '../providers/habit_providers.dart';

class HabitEditScreen extends HookConsumerWidget {
  const HabitEditScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleController = TextEditingController();
    final descController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(title: const Text('Добавить привычку')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Название'),
                validator: (v) => v == null || v.trim().isEmpty ? 'Введите название' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: descController,
                decoration: const InputDecoration(labelText: 'Описание'),
                validator: (v) => v == null || v.trim().isEmpty ? 'Введите описание' : null,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState?.validate() ?? false) {
                    final repo = ref.read(habitRepositoryProvider);
                    await repo.addHabit(
                      Habit(
                        id: const Uuid().v4(),
                        title: titleController.text.trim(),
                        description: descController.text.trim(),
                        completedDates: [],
                      ),
                    );
                    if (context.mounted) context.go('/');
                  }
                },
                child: const Text('Сохранить'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
