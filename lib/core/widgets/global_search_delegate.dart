import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/providers/products_provider.dart';
import '../../data/providers/projects_provider.dart';
import 'package:go_router/go_router.dart';

class GlobalSearchDelegate extends SearchDelegate<String> {
  @override
  String get searchFieldLabel => 'Buscar producto, SKU o proyecto...';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
        ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, ''),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults(context);
  }

  Widget _buildSearchResults(BuildContext context) {
    final productsProvider = context.watch<ProductsProvider>();
    final projectsProvider = context.watch<ProjectsProvider>();

    if (query.isEmpty) {
      return const Center(child: Text('Escribe para buscar...'));
    }

    final String lowerQuery = query.toLowerCase();

    final filteredProducts = productsProvider.products.where((p) {
      return p.name.toLowerCase().contains(lowerQuery) || p.code.toLowerCase().contains(lowerQuery);
    }).toList();

    final filteredProjects = projectsProvider.projects.where((p) {
      return p.name.toLowerCase().contains(lowerQuery);
    }).toList();

    if (filteredProducts.isEmpty && filteredProjects.isEmpty) {
      return const Center(child: Text('No se encontraron resultados.'));
    }

    return ListView(
      children: [
        if (filteredProducts.isNotEmpty)
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Productos', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
          ),
        ...filteredProducts.map((p) => ListTile(
              leading: const Icon(Icons.inventory_2, color: Colors.blue),
              title: Text(p.name, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('SKU: ${p.code} • Stock: ${p.stock}'),
              onTap: () {
                close(context, '');
                context.push('/products');
              },
            )),
        if (filteredProjects.isNotEmpty)
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Proyectos', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
          ),
        ...filteredProjects.map((p) => ListTile(
              leading: const Icon(Icons.business_center, color: Colors.orange),
              title: Text(p.name, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Estado: ${p.status}'),
              onTap: () {
                close(context, '');
                context.push('/projects');
              },
            )),
      ],
    );
  }
}
