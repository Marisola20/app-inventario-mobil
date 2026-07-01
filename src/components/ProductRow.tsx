import { StyleSheet, Text, View } from "react-native";

import { Product } from "@/types/inventory";
import { colors } from "@/theme/colors";

type ProductRowProps = {
  product: Product;
};

export function ProductRow({ product }: ProductRowProps) {
  const isLow = product.stock <= product.minStock;

  return (
    <View style={styles.card}>
      <View style={styles.header}>
        <Text style={styles.name}>{product.name}</Text>
        <Text style={isLow ? styles.low : styles.stock}>{product.stock} {product.unit}</Text>
      </View>
      <Text style={styles.meta}>{product.category} - {product.warehouse}</Text>
      <Text style={styles.code}>Codigo: {product.barcode}</Text>
    </View>
  );
}

const styles = StyleSheet.create({
  card: {
    backgroundColor: colors.surface,
    borderColor: colors.border,
    borderRadius: 8,
    borderWidth: 1,
    gap: 5,
    padding: 14
  },
  header: {
    alignItems: "flex-start",
    flexDirection: "row",
    gap: 10,
    justifyContent: "space-between"
  },
  name: {
    color: colors.text,
    flex: 1,
    fontSize: 15,
    fontWeight: "800"
  },
  stock: {
    color: colors.success,
    fontSize: 14,
    fontWeight: "800"
  },
  low: {
    color: colors.danger,
    fontSize: 14,
    fontWeight: "800"
  },
  meta: {
    color: colors.muted,
    fontSize: 13
  },
  code: {
    color: colors.text,
    fontSize: 12,
    fontWeight: "700"
  }
});
