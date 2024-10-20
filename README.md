# Prueba tecnica de Optimal Tech App

Esta App es un sistema de gestion de creacion, lectura, edición y elimnación de libros 

## Inicialización del Proyecto

Para inicializar el proyecto, sigue los siguientes pasos:

1. **Navegar al directorio del proyecto:**
    ```bash
    cd prueba_tecnica_optimal_tech_app
    ```

2. **Instalar las dependencias:**
    ```bash
    flutter pub get
    ```

3. **Ejecutar la aplicación:**
    ```bash
    flutter run
    ```

Asegúrate de tener Flutter instalado y configurado en tu máquina antes de ejecutar estos comandos.

## Proceso de compilación

Para compilar la aplicación y generar el archivo `.apk`, sigue estos pasos:

1. **Abrir la terminal**: Navega al directorio de tu proyecto Flutter.

2. **Ejecuta el comando de compilación**:
    ```sh
    flutter build apk
    ```
    Este comando compila tu proyecto Flutter en un paquete de Android (`.apk`).

3. **Ubica el archivo `.apk`**:
    Después de que el proceso de compilación se complete, puedes encontrar el archivo `.apk` generado en el siguiente directorio:
    ```
    build/app/outputs/flutter-apk/app-release.apk
    ```

### Notas adicionales:
- Asegúrate de tener instaladas las herramientas necesarias del SDK de Android.
- También puedes compilar una versión de depuración del archivo `.apk` utilizando:
  ```sh
  flutter build apk --debug
  ```
