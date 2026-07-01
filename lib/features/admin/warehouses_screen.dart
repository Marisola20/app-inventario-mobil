import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/providers/warehouses_provider.dart';
import '../../data/models/warehouse_model.dart';

class WarehousesScreen extends StatefulWidget {
  const WarehousesScreen({super.key});

  @override
  State<WarehousesScreen> createState() => _WarehousesScreenState();
}

class _WarehousesScreenState extends State<WarehousesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WarehousesProvider>().fetchWarehouses();
    });
  }

  void _showWarehouseForm([WarehouseModel? warehouse]) {
    final isEditing = warehouse != null;
    final nameController = TextEditingController(text: warehouse?.name ?? '');
    final locationController = TextEditingController(text: warehouse?.location ?? '');
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(isEditing ? 'Editar Almacén' : 'Nuevo Almacén'),
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
                    controller: locationController,
                    decoration: const InputDecoration(labelText: 'Ubicación / Detalles'),
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
                  final newWarehouse = WarehouseModel(
                    id: warehouse?.id,
                    name: nameController.text.trim(),
                    location: locationController.text.trim(),
                    isActive: warehouse?.isActive ?? true,
                  );
                  
                  if (isEditing) {
                    context.read<WarehousesProvider>().updateWarehouse(newWarehouse);
                  } else {
                    context.read<WarehousesProvider>().addWarehouse(newWarehouse);
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
        title: const Text('Gestión de Almacenes'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showWarehouseForm(),
        child: const Icon(Icons.add),
      ),
      body: Consumer<WarehousesProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.warehouses.isEmpty) {
            return const Center(child: Text('No hay almacenes registrados.'));
          }

          return ListView.builder(
            itemCount: provider.warehouses.length,
            itemBuilder: (context, index) {
              final wh = provider.warehouses[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: wh.isActive ? Colors.orange.shade100 : Colors.red.shade100,
                  child: Icon(
                    Icons.warehouse,
                    color: wh.isActive ? Colors.orange.shade900 : Colors.red.shade900,
                  ),
                ),
                title: Text(wh.name),
                subtitle: Text(wh.location ?? 'Sin ubicación'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () => _showWarehouseForm(wh),
                    ),
                    Switch(
                      value: wh.isActive,
                      onChanged: (val) {
                        provider.toggleWarehouseStatus(wh.id!, !val);
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
