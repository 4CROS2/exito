# Prueba Técnica Grupo Éxito

## Descripción

Este proyecto es una aplicación Flutter desarrollada como prueba técnica para la empresa Grupo Éxito. La app consume productos desde la API pública https://fakestoreapi.com y utiliza buenas prácticas de arquitectura, gestión de estado y modularización.

## Dependencias principales

- **provider**: Gestión de estado.
- **go_router**: Navegación.
- **get_it**: Inyección de dependencias.
- **http**: Consumo de APIs REST.
- **shared_preferences**: Almacenamiento local.
- **custom_rating_bar**: Componente de rating.
- **Paquete privado `shared`**: Utilidades y widgets compartidos, ubicado en `./packages/shared`.

## API utilizada

La app consume datos de la API pública:
```
https://fakestoreapi.com
```


## Instalación de dependencias

En la raíz del proyecto:
```
flutter pub get
```
Para el paquete privado:
```
cd packages/shared
flutter pub get
cd ../..
```

## Configuración y ejecución

Para iniciar la app, debes definir la URL de la API usando un flag de entorno. Esto permite cambiar el endpoint sin modificar el código fuente, facilitando pruebas y despliegues.

Ejecuta:
```
flutter run --dart-define=API_URL=https://fakestoreapi.com
```


### Flags adicionales para pruebas

- `--dart-define=CUSTOM_TIME=11`: Simula que la hora actual es 11 AM (puedes cambiar el valor por cualquier hora), útil para pruebas de lógica basada en la hora.

Ejemplo:
```
flutter run --dart-define=API_URL=https://fakestoreapi.com --dart-define=FORCE_SWITCH_VISIBLE=true --dart-define=CUSTOM_TIME=11
```

> **¿Por qué usar `--dart-define`?**
>
> Permite configurar la app sin modificar el código fuente, facilitando pruebas y el manejo de diferentes entornos.

## Generar APK (Build)

Para generar el APK de la aplicación ejecuta:
```
flutter build apk --dart-define=API_URL=https://fakestoreapi.com
```
Puedes agregar los flags adicionales si necesitas probar comportamientos específicos:
```
flutter build apk --dart-define=API_URL=https://fakestoreapi.com --dart-define=FORCE_SWITCH_VISIBLE=true --dart-define=CUSTOM_TIME=11
```

## Estructura del proyecto

- `lib/` - Código fuente principal
- `packages/shared/` - Paquete privado compartido
- `assets/` - Recursos estáticos
- `test/` - Pruebas

---

