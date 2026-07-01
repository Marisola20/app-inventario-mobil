import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/providers/categories_provider.dart';
import '../../data/models/category_model.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CategoriesProvider>().fetchCategories();
    });
  }

  void _showCategoryForm([CategoryModel? category]) {
    final isEditing = category != null;
    final nameController = TextEditingController(text: category?.name ?? '');
    final descController = TextEditingController(text: category?.description ?? '');
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(isEditing ? 'Editar Categoría' : 'Nueva Categoría'),
          content: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Nombre'),
                    validator: (v) => v!.isEmpty ? 'Requerido' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: descController,
                    decoration: const InputDecoration(labelText: 'Descripción'),
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  final newCategory = CategoryModel(
                    id: category?.id,
                    name: nameController.text.trim(),
                    description: descController.text.trim(),
                    isActive: category?.isActive ?? true,
                  );
                  
                  if (isEditing) {
                    context.read<CategoriesProvider>().updateCategory(newCategory);
                  } else {
                    context.read<CategoriesProvider>().addCategory(newCategory);
                  }
                  Navigator.pop(context);
                }
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión de Categorías'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCategoryForm(),
        child: const Icon(Icons.add),
      ),
      body: Consumer<CategoriesProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.categories.isEmpty) {
            return const Center(child: Text('No hay categorías registradas.'));
          }

          return ListView.builder(
            itemCount: provider.categories.length,
            itemBuilder: (context, index) {
              final cat = provider.categories[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: cat.isActive ? Colors.green.shade100 : Colors.red.shade100,
                  child: Icon(
                    Icons.category,
                    color: cat.isActive ? Colors.green.shade900 : Colors.red.shade900,
                  ),
                ),
                title: Text(cat.name),
                subtitle: Text(cat.description ?? ''),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () => _showCategoryForm(cat),
                    ),
                    Switch(
                      value: cat.isActive,
                      onChanged: (val) {
                        provider.toggleCategoryStatus(cat.id!, !val);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
