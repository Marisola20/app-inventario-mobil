import pandas as pd
import math

df = pd.read_excel('bd.xlsx', sheet_name='BASE DE DATOS ALMACEN')

df['PRODUCTO'] = df['PRODUCTO'].fillna('Desconocido')
df['TIPO'] = df['TIPO'].fillna('General')
df['ALMACEN'] = df['ALMACEN'].fillna('Principal')
df['UM'] = df['UM'].fillna('UND')
df['UND'] = pd.to_numeric(df['UND'], errors='coerce').fillna(0).astype(int)
df['CU'] = pd.to_numeric(df['CU'], errors='coerce').fillna(0.0)

categories = df['TIPO'].unique().tolist()
warehouses = df['ALMACEN'].unique().tolist()

dart_code = []
dart_code.append("import 'package:sqflite/sqflite.dart';")
dart_code.append("")
dart_code.append("Future<void> insertSeedData(Database db) async {")
dart_code.append("    // Data from Excel")

for i, cat in enumerate(categories):
    dart_code.append(f"    await db.insert('categories', {{'id': {i+10}, 'name': '{cat}', 'description': 'Migrado de Excel'}});")

for i, wh in enumerate(warehouses):
    dart_code.append(f"    await db.insert('warehouses', {{'id': {i+10}, 'name': '{wh}', 'location': 'Sede Principal'}});")

for index, row in df.iterrows():
    if pd.isna(row['PRODUCTO']) or str(row['PRODUCTO']).strip() == "":
        continue
    
    cat_id = categories.index(row['TIPO']) + 10
    wh_id = warehouses.index(row['ALMACEN']) + 10
    
    code = f"PROD-{index+1:04d}"
    name = str(row['PRODUCTO']).replace("'", "''").replace('\n', ' ').replace('\r', '')
    unit = str(row['UM'])
    stock = int(row['UND'])
    price = float(row['CU'])
    
    dart_code.append(f"    await db.insert('products', {{")
    dart_code.append(f"      'code': '{code}',")
    dart_code.append(f"      'name': '{name}',")
    dart_code.append(f"      'categoryId': {cat_id},")
    dart_code.append(f"      'stock': {stock},")
    dart_code.append(f"      'minStock': 5,")
    dart_code.append(f"      'unit': '{unit}',")
    dart_code.append(f"      'price': {price}")
    dart_code.append(f"    }});")

dart_code.append("}")

with open('lib/core/database/seed_data.dart', 'w', encoding='utf-8') as f:
    f.write("\n".join(dart_code))

print("Seed data generated completely!")
