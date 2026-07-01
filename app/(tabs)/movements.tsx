import { FlatList, StyleSheet, Text, View } from "react-native";

import { mockMovements } from "@/data/mockInventory";
import { colors } from "@/theme/colors";

export default function MovementsScreen() {
  return (
    <FlatList
      style={styles.screen}
      contentContainerStyle={styles.list}
      data={mockMovements}
      keyExtractor={(item) => item.id}
      renderItem={({ item }) => (
        <View style={styles.card}>
          <View style={styles.header}>
            <Text style={styles.product}>{item.productName}</Text>
            <Text style={item.type === "entrada" ? styles.in : styles.out}>
              {item.type === "entrada" ? "Entrada" : "Salida"}
            </Text>
          </View>
          <Text style={styles.meta}>Cantidad: {item.quantity}</Text>
          <Text style={styles.meta}>Almacen: {item.warehouse}</Text>
          <Text style={styles.meta}>Proyecto: {item.project}</Text>
          <Text style={styles.date}>{item.date}</Text>
        </View>
      )}
    />
  );
}

const styles = StyleSheet.create({
  screen: {
    flex: 1,
    backgroundColor: colors.background
  },
  list: {
    gap: 10,
    padding: 16
  },
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
  product: {
    color: colors.text,
    flex: 1,
    fontSize: 15,
    fontWeight: "800"
  },
  meta: {
    color: colors.muted,
    fontSize: 13
  },
  date: {
    color: colors.text,
    fontSize: 12,
    fontWeight: "700",
    marginTop: 4
  },
  in: {
    color: colors.success,
    fontSize: 13,
    fontWeight: "800"
  },
  out: {
    color: colors.danger,
    fontSize: 13,
    fontWeight: "800"
  }
});
