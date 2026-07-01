# Modelo de base de datos propuesto

Este modelo viene de los requerimientos del informe y del Excel de inventario.

## Tablas principales

### roles

- id
- name

### users

- id
- role_id
- name
- email
- password_hash
- active
- created_at

### warehouses

- id
- name
- active

### categories

- id
- name
- description

### products

- id
- category_id
- name
- barcode
- serial_number
- unit
- currency
- unit_cost
- min_stock
- active

### product_stock

- id
- product_id
- warehouse_id
- quantity

### projects

- id
- name
- client
- location
- status
- start_date
- end_date

### inventory_movements

- id
- product_id
- warehouse_id
- user_id
- project_id
- type
- quantity
- unit_cost
- total_cost
- destination
- notes
- created_at

### notifications

- id
- user_id
- movement_id
- title
- message
- read_at
- created_at

## Datos que faltan limpiar del Excel

- Codigo de barras por producto.
- Stock minimo.
- Moneda en productos sin costo.
- Costo unitario faltante.
- Productos repetidos con nombres genericos.
- Unidad de medida vacia.
