# Proenergim Stock - Aplicación de Inventario Móvil

Aplicación corporativa desarrollada en **Flutter** para la gestión de inventario, almacenes, seguimiento de costos por proyecto, generación de reportes y lectura de códigos de barras.

> [!IMPORTANT]
> **DOCUMENTACIÓN OBLIGATORIA (NO OLVIDAR):**  
> Para comprender el estado exacto del proyecto, las contraseñas, los requerimientos y la arquitectura, es **crucial** que leas los siguientes 3 archivos Markdown ubicados en la raíz del proyecto antes de realizar cualquier cambio:
>
> 1. **`FL_act.md`** -> Contiene la Bitácora técnica de cambios, las contraseñas de acceso y el mapeo de toda la estructura de carpetas de Flutter.
> 2. **`RF.md`** -> Contiene la lista estricta de todos los Requerimientos Funcionales, No Funcionales y los Casos de Uso del sistema.
> 3. **`avance.md`** -> Contiene el reporte ejecutivo del progreso, qué se ha terminado y qué falta por programar para conectar con la Nube (Backend).

## Tecnologías Principales
- **Flutter** (Framework UI)
- **SQLite** (Base de datos local ultrarrápida / Offline-first)
- **Provider** (Gestión de estado)
- **GoRouter** (Navegación y ShellRoutes)
- **Mobile Scanner & QR Flutter** (Lectura y Generación de Códigos)
- **PDF & Printing** (Generación nativa de reportes y etiquetas)

## 🛠️ Cómo Iniciar y Compilar el Proyecto
Antes de ejecutar cualquier comando, asegúrate de tener un dispositivo conectado o un emulador de Android/iOS abierto.

1. **Instalar Dependencias:**
```bash
flutter pub get
```
2. **Ejecutar en Modo Desarrollo (Debug):**
```bash
flutter run
```
3. **Generar APK para Producción:**
```bash
flutter build apk
```
*El archivo final se guardará en `build/app/outputs/flutter-apk/app-release.apk`.*

> **Tip de Solución de Errores:** Si al compilar obtienes errores relacionados a "GeneratedPluginRegistrant" (usualmente al cambiar librerías nativas), ejecuta `flutter clean` y vuelve a correr `flutter pub get`.
