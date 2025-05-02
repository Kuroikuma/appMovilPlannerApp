Aquí tienes un README.md profesional y adaptado para tu proyecto PlannerApp. Está enfocado en desarrolladores y mantenimiento, destacando arquitectura, tecnologías usadas y procesos clave como la sincronización offline.

✅ README.md
markdown
Copiar
Editar
# 📱 PlannerApp - Aplicación de Control de Asistencia

PlannerApp es una aplicación móvil desarrollada con **Flutter**, diseñada para gestionar el control de asistencia de trabajadores utilizando **reconocimiento facial**, registro de **ingresos/salidas** y sincronización automática de datos, incluso en escenarios offline.

---

## 📂 Estructura del Proyecto

lib/                                                                                                                                                                                                                                                                        
 ├── core/ # Converters, mappers y lógica reutilizable                                                                                                                                                                                                                      
 ├── data/ # Repositorios, acceso a base de datos (local y remoto)
 │ ├── repositories/
 │ ├── local/
 │ └── remote/
 ├── domain/ # Entidades y contratos de repositorio
 ├── presentation/ # UI: Providers, Screens, Widgets
 └── main.dart # Entry point


---

## 🔧 Tecnologías y Paquetes Clave

| Paquete | Función |
|--------|--------|
| `drift`, `sqlite3_flutter_libs` | Base de datos local |
| `dio` | Cliente HTTP |
| `internet_connection_checker` | Detección de conectividad |
| `flutter_riverpod` | Gestión de estado reactivo |
| `uuid`, `intl`, `json_annotation` | Utilidades |
| `camera`, `image_picker`, `permission_handler` | Captura facial y permisos |
| `flutter_native_splash` | Personalización de splash screen |

---

## 🧠 Funcionalidades Principales

- ✅ Registro de asistencia (entrada y salida)
- ✅ Reconocimiento facial con sincronización local/remota
- ✅ Modo Offline: almacenamiento de cambios pendientes
- ✅ Sincronización automática con resolución de conflictos
- ✅ Panel visual de progreso de sincronización

---

## 🔄 Sincronización Offline

La aplicación implementa una **cola inteligente** que permite:

- Registrar datos en local cuando no hay conexión
- Subir automáticamente cambios al recuperar internet
- Resolver conflictos basados en `equipoId + fechaIngreso`, dando prioridad al servidor
- Mostrar progreso visual de sincronización (`SyncQueueState`)

---

## 🧱 Tablas de Base de Datos

- **Trabajadores**
- **RegistrosDiarios** ⭐ (clave para el sistema de asistencia)
- **RegistrosBiometricos**
- **Ubicaciones**, **GruposUbicaciones**
- **Horarios**
- **SyncsEntitys** (cola local de sincronización)

---

## ▶️ Ejecución del Proyecto

```bash
flutter pub get
flutter run
Para generar código con drift:

bash
Copiar
Editar
flutter pub run build_runner build --delete-conflicting-outputs
🚨 Mantenimiento
Ver MANUAL DE MANTENIMIENTO para:

Resolución de errores

Sincronización y control de versiones

Actualización de dependencias

Migraciones de base de datos

👨‍💻 Autores
Proyecto desarrollado por el equipo de PlannerApp

Colaboradores y contribuyentes bienvenidos vía PRs
