import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/database/database_helper.dart';
import 'features/auth/auth_provider.dart';
import 'core/router/app_router.dart';
import 'data/providers/users_provider.dart';
import 'data/providers/categories_provider.dart';
import 'data/providers/warehouses_provider.dart';
import 'data/providers/projects_provider.dart';
import 'data/providers/products_provider.dart';
import 'data/providers/movements_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inicializar base de datos
  await DatabaseHelper().database;
  
  runApp(const ProenergimApp());
}

class ProenergimApp extends StatelessWidget {
  const ProenergimApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()..checkAuthStatus()),
        ChangeNotifierProvider(create: (_) => UsersProvider()),
        ChangeNotifierProvider(create: (_) => CategoriesProvider()),
        ChangeNotifierProvider(create: (_) => WarehousesProvider()),
        ChangeNotifierProvider(create: (_) => ProjectsProvider()),
        ChangeNotifierProvider(create: (_) => ProductsProvider()),
        ChangeNotifierProxyProvider<ProductsProvider, MovementsProvider>(
          create: (context) => MovementsProvider(context.read<ProductsProvider>()),
          update: (context, productsProvider, previousMovementsProvider) =>
              previousMovementsProvider ?? MovementsProvider(productsProvider),
        ),
      ],
      child: Builder(
        builder: (context) {
          final router = AppRouter.getRouter(context);
          
          return MaterialApp.router(
            title: 'Proenergim stock',
            theme: ThemeData(
              brightness: Brightness.light,
              primaryColor: const Color(0xFF0284C7),
              scaffoldBackgroundColor: const Color(0xFFF8FAFC),
              appBarTheme: const AppBarTheme(
                backgroundColor: Color(0xFF0284C7),
                foregroundColor: Colors.white,
                elevation: 0,
                centerTitle: true,
              ),
              colorScheme: const ColorScheme.light(
                primary: Color(0xFF0284C7),
                secondary: Color(0xFF059669),
                surface: Colors.white,
                background: Color(0xFFF8FAFC),
              ),
              cardTheme: const CardThemeData(
                color: Colors.white,
                elevation: 2,
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0284C7),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
              inputDecorationTheme: const InputDecorationTheme(
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              ),
            ),
            routerConfig: AppRouter.getRouter(context),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
