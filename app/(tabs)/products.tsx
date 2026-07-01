import { FlatList, StyleSheet, Text, TextInput, View } from "react-native";
import { useMemo, useState } from "react";

import { ProductRow } from "@/components/ProductRow";
import { mockProducts } from "@/data/mockInventory";
import { colors } from "@/theme/colors";

export default function ProductsScreen() {
  const [query, setQuery] = useState("");

  const products = useMemo(() => {
    const value = query.trim().toLowerCase();
    if (!value) return mockProducts;
    return mockProducts.filter((product) =>
      [product.name, product.category, product.warehouse, product.barcode].some((field) =>
        field.toLowerCase().includes(value)
      )
    );
  }, [query]);

  return (
    <View style={styles.screen}>
      <TextInput
        placeholder="Buscar producto, almacen o codigo"
        placeholderTextColor={colors.muted}
        value={query}
        onChangeText={setQuery}
        style={styles.search}
      />
      <FlatList
        data={products}
        keyExtractor={(item) => item.id}
        renderItem={({ item }) => <ProductRow product={item} />}
        contentContainerStyle={styles.list}
        ListEmptyComponent={<Text style={styles.empty}>No se encontraron productos.</Text>}
      />
    </View>
  );
}

const styles = StyleSheet.create({
  screen: {
    flex: 1,
    backgroundColor: colors.background,
    padding: 16
  },
  search: {
    backgroundColor: colors.surface,
    borderColor: colors.border,
    borderRadius: 8,
    borderWidth: 1,
    color: colors.text,
    fontSize: 15,
    marginBottom: 12,
    paddingHorizontal: 14,
    paddingVertical: 12
  },
  list: {
    gap: 10,
    paddingBottom: 24
  },
  empty: {
    color: colors.muted,
    marginTop: 24,
    textAlign: "center"
  }
});
