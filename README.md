# Inventario Proenergim Mobile

Plantilla frontend para la app movil de inventario de Proenergim E.I.R.L.

## Estado actual

Repositorio base para iniciar el desarrollo movil. Ya incluye una primera estructura de pantallas, datos simulados y documentacion tecnica para conectar un backend despues.

## Tecnologia elegida

- React Native con Expo.
- TypeScript.
- Expo Router para navegacion.
- Estructura preparada para conectar un backend despues.

Elegimos Expo porque la documentacion oficial de React Native recomienda iniciar apps nuevas con un framework, y Expo reduce configuracion para camara, rutas, pruebas en celular y builds.

Para este proyecto conviene React Native antes que web porque el requerimiento principal es registrar salidas en campo desde celular usando camara/codigo de barras. La web puede venir despues para administracion o reportes.

## Primeras pantallas

- Dashboard.
- Productos.
- Escaner.
- Movimientos.

## Alcance definido desde tus documentos

- Inicio de sesion.
- Roles de Administrador y Trabajador.
- Gestion de productos, categorias, almacenes y proyectos.
- Stock por almacen.
- Entradas y salidas de inventario.
- Salidas mediante escaneo de codigo de barras.
- Historial/auditoria de movimientos.
- Alertas de stock bajo.
- Costo de materiales por proyecto.
- Reportes y notificaciones para administracion.

## Cuando quieras correrla

```bash
pnpm install
pnpm start
```

Luego escaneas el QR con Expo Go o abres el emulador Android.

## Backend futuro

La carpeta `src/services` ya separa la comunicacion con API. Cuando tengamos backend, cambiamos los datos simulados por llamadas reales sin rehacer las pantallas.

Documentos utiles:

- `docs/product-scope.md`
- `docs/database-model.md`
- `docs/backend-contract.md`
