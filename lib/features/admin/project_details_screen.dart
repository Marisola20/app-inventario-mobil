import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/models/project_model.dart';
import '../../data/models/movement_model.dart';
import '../../data/providers/movements_provider.dart';
import '../../data/providers/products_provider.dart';
import 'package:intl/intl.dart';

class ProjectDetailsScreen extends StatefulWidget {
  final ProjectModel project;

  const ProjectDetailsScreen({super.key, required this.project});

  @override
  State<ProjectDetailsScreen> createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MovementsProvider>().fetchMovements();
      context.read<ProductsProvider>().fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.project.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
      ),
      body: Consumer2<MovementsProvider, ProductsProvider>(
        builder: (context, movementsProv, productsProv, child) {
          if (movementsProv.isLoading || productsProv.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // Filtrar solo las salidas (OUT) asociadas a este proyecto
          final projectMovements = movementsProv.movements.where(
            (m) => m.projectId == widget.project.id && m.type == 'OUT'
          ).toList();

          double totalCost = 0.0;
          
          // Agrupar por producto para resumen (Opcional, pero aquí listamos todos los movimientos)
          List<Map<String, dynamic>> detailsList = [];

          for (var mov in projectMovements) {
            final product = productsProv.products.firstWhere(
              (p) => p.id == mov.productId, 
              orElse: () => productsProv.products.first // Fallback (should not happen if db intact)
            );
            
            double cost = product.price * mov.quantity;
            totalCost += cost;

            detailsList.add({
              'movement': mov,
              'product': product,
              'cost': cost,
            });
          }

          return Column(
            children: [
              // Header de Costos Totales
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Presupuesto Consumido',
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '\$${totalCost.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${projectMovements.length} retiros de materiales',
                      style: const TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),
              
              // Lista de materiales usados
              Expanded(
                child: detailsList.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.inventory_2_outlined, size: 80, color: Colors.grey.shade300),
                            const SizedBox(height: 16),
                            Text('No se han asignado materiales a este proyecto', 
                              style: TextStyle(color: Colors.grey.shade600)),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        itemCount: detailsList.length,
                        itemBuilder: (context, index) {
                          final item = detailsList[index];
                          final MovementModel mov = item['movement'];
                          final product = item['product'];
                          final double cost = item['cost'];
                          
                          DateTime parsedDate = DateTime.tryParse(mov.date) ?? DateTime.now();
                          String formattedDate = DateFormat('dd/MM/yyyy').format(parsedDate);

                          return Card(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(color: Colors.grey.shade200),
                            ),
                            child: ListTile(
                              leading: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.red.shade50,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(Icons.arrow_upward, color: Colors.red.shade700),
                              ),
                              title: Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                              subtitle: Text('$formattedDate • ${mov.quantity} ${product.unit} (a \$${product.price})'),
                              trailing: Text(
                                '\$${cost.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
