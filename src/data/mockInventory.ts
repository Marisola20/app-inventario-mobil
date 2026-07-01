import { Movement, Product } from "@/types/inventory";

export const mockProducts: Product[] = [
  {
    id: "prod-001",
    name: "Inversor de frecuencia solar hibrido 2.2 KW",
    category: "Equipo",
    warehouse: "Importados",
    barcode: "PRO-000001",
    unit: "UND",
    stock: 92,
    minStock: 10,
    currency: "USD",
    unitCost: 60
  },
  {
    id: "prod-002",
    name: "Casco jockey Steelpro azul",
    category: "EPP",
    warehouse: "Las Mercedes",
    barcode: "PRO-000002",
    unit: "UND",
    stock: 20,
    minStock: 8,
    currency: "PEN",
    unitCost: 15.5
  },
  {
    id: "prod-003",
    name: "Escalera multiuso de 24 pasos",
    category: "Ferreteria",
    warehouse: "Las Mercedes",
    barcode: "PRO-000003",
    unit: "UND",
    stock: 1,
    minStock: 2,
    currency: "PEN",
    unitCost: 820
  },
  {
    id: "prod-004",
    name: "Conector MC4 de 6 MM 1000 V CC",
    category: "Equipo",
    warehouse: "Importados",
    barcode: "PRO-000004",
    unit: "UND",
    stock: 1000,
    minStock: 100,
    currency: "USD",
    unitCost: 0.5
  }
];

export const mockMovements: Movement[] = [
  {
    id: "mov-001",
    type: "salida",
    productName: "Escalera multiuso de 24 pasos",
    quantity: 1,
    warehouse: "Las Mercedes",
    project: "Instalacion paneles Santa Anita",
    date: "2026-06-30 09:15"
  },
  {
    id: "mov-002",
    type: "entrada",
    productName: "Conector MC4 de 6 MM 1000 V CC",
    quantity: 200,
    warehouse: "Importados",
    project: "Reposicion almacen",
    date: "2026-06-29 16:40"
  },
  {
    id: "mov-003",
    type: "salida",
    productName: "Casco jockey Steelpro azul",
    quantity: 4,
    warehouse: "Las Mercedes",
    project: "Mantenimiento bombeo solar",
    date: "2026-06-29 10:05"
  }
];
