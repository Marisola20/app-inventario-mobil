import { mockMovements, mockProducts } from "@/data/mockInventory";

const API_URL = process.env.EXPO_PUBLIC_API_URL;

export async function getProducts() {
  if (!API_URL) return mockProducts;

  const response = await fetch(`${API_URL}/products`);
  if (!response.ok) throw new Error("No se pudo obtener productos");
  return response.json();
}

export async function getMovements() {
  if (!API_URL) return mockMovements;

  const response = await fetch(`${API_URL}/movements`);
  if (!response.ok) throw new Error("No se pudo obtener movimientos");
  return response.json();
}
