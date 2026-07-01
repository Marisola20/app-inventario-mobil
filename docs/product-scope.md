# Alcance de la app movil de inventario

Este resumen cruza los documentos de practicas con el Excel `MODELO BASE DE DATOS (1).xlsx`.

## Decision tecnica

La primera version debe ser movil. La plantilla actual usa:

- React Native con Expo.
- TypeScript.
- Expo Router.
- Datos simulados mientras se prepara el backend.
- Cliente API separado en `src/services` para conectar el backend despues.

Esta decision encaja con el requerimiento RNF01: uso desde dispositivos moviles y futura adaptacion web.

## Roles

- Administrador: gestiona usuarios, categorias, productos, almacenes, proyectos, entradas, reportes y notificaciones.
- Trabajador: consulta productos y registra salidas mediante escaneo, asociando el destino o proyecto.

## Modulos funcionales

- Autenticacion por correo y contrasena.
- Usuarios y roles.
- Categorias de productos.
- Productos con codigo de barras y numero de serie opcional.
- Almacenes multiples.
- Stock por almacen.
- Entradas de inventario.
- Salidas por escaneo.
- Proyectos y asignacion de materiales.
- Costo acumulado por proyecto.
- Historial y auditoria de movimientos.
- Alertas de stock bajo.
- Notificaciones por salidas.
- Dashboard administrativo.
- Reportes de inventario, movimientos y proyectos.

## Datos base encontrados en el Excel

La hoja principal `BASE DE DATOS ALMACEN` trae estas columnas:

- ITEM
- ALMACEN
- TIPO
- FECHA COMPRA
- PRODUCTO
- UM
- UND
- MONEDA
- CU
- CP

La hoja `Hoja3` parece ser un resumen/pivote por producto con suma de unidades.

## Modelo de datos minimo

- roles
- users
- warehouses
- categories
- products
- product_stock
- projects
- inventory_movements
- notifications

El detalle completo esta en `docs/database-model.md`.

## Pantallas recomendadas para la plantilla movil

La plantilla actual ya cubre el esqueleto inicial:

- Inicio / dashboard.
- Productos.
- Escaner.
- Movimientos.

Siguientes pantallas sugeridas:

- Login.
- Detalle de producto.
- Registrar entrada.
- Confirmar salida escaneada.
- Proyectos.
- Detalle de proyecto con materiales y costo.
- Alertas.
- Usuarios, solo para administrador.

## Datos pendientes de limpieza

- Codigo de barras real por producto.
- Stock minimo por producto.
- Numero de serie para equipos que lo requieran.
- Moneda y costo en productos incompletos.
- Productos repetidos o genericos.
- Unidad de medida vacia.
- Proyectos reales para asociar salidas.

## Orden recomendado de desarrollo

1. Cerrar plantilla movil con navegacion, dashboard, productos, escaner y movimientos.
2. Agregar login y control visual por rol.
3. Cargar datos reales del Excel como semilla temporal.
4. Definir backend con MySQL.
5. Conectar endpoints de productos, movimientos, almacenes y proyectos.
6. Agregar reportes, notificaciones y auditoria.
