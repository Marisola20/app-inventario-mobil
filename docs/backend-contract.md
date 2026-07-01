# Contrato inicial de backend

Base URL esperada:

```text
EXPO_PUBLIC_API_URL=http://localhost:3000/api
```

## Autenticacion

### POST /auth/login

Entrada:

```json
{
  "email": "admin@proenergim.com",
  "password": "********"
}
```

Salida:

```json
{
  "token": "jwt",
  "user": {
    "id": "usr-001",
    "name": "Administrador",
    "role": "admin"
  }
}
```

## Productos

### GET /products

Devuelve productos con stock actual por almacen.

### POST /products

Crea un producto con codigo de barras, categoria, unidad, costo y stock minimo.

## Movimientos

### GET /movements

Devuelve historial de entradas y salidas.

### POST /movements

Registra entrada o salida y actualiza stock.

## Proyectos

### GET /projects

Lista proyectos activos.

### GET /projects/:id/materials

Lista materiales usados por proyecto y costo acumulado.
