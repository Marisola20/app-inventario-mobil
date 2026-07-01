export type Currency = "PEN" | "USD";

export type Product = {
  id: string;
  name: string;
  category: string;
  warehouse: string;
  barcode: string;
  unit: string;
  stock: number;
  minStock: number;
  currency: Currency;
  unitCost: number;
};

export type Movement = {
  id: string;
  type: "entrada" | "salida";
  productName: string;
  quantity: number;
  warehouse: string;
  project: string;
  date: string;
};
