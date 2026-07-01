import { ScrollView, StyleSheet, Text, View } from "react-native";

import { StatCard } from "@/components/StatCard";
import { mockMovements, mockProducts } from "@/data/mockInventory";
import { colors } from "@/theme/colors";

export default function DashboardScreen() {
  const lowStock = mockProducts.filter((product) => product.stock <= product.minStock).length;
  const totalStock = mockProducts.reduce((sum, product) => sum + product.stock, 0);
  const activeProjects = new Set(mockMovements.map((movement) => movement.project)).size;

  return (
    <ScrollView style={styles.screen} contentContainerStyle={styles.content}>
      <View>
        <Text style={styles.kicker}>Proenergim E.I.R.L.</Text>
        <Text style={styles.title}>Inventario movil</Text>
      </View>

      <View style={styles.grid}>
        <StatCard label="Productos" value={mockProducts.length.toString()} />
        <StatCard label="Stock total" value={totalStock.toString()} />
        <StatCard label="Stock bajo" value={lowStock.toString()} tone="warning" />
        <StatCard label="Proyectos" value={activeProjects.toString()} />
      </View>

      <View style={styles.section}>
        <Text style={styles.sectionTitle}>Movimientos recientes</Text>
        {mockMovements.slice(0, 4).map((movement) => (
          <View key={movement.id} style={styles.movement}>
            <View>
              <Text style={styles.product}>{movement.productName}</Text>
              <Text style={styles.meta}>{movement.project}</Text>
            </View>
            <Text style={movement.type === "entrada" ? styles.in : styles.out}>
              {movement.type === "entrada" ? "+" : "-"}
              {movement.quantity}
            </Text>
          </View>
        ))}
      </View>
    </ScrollView>
  );
}

const styles = StyleSheet.create({
  screen: {
    flex: 1,
    backgroundColor: colors.background
  },
  content: {
    gap: 20,
    padding: 20
  },
  kicker: {
    color: colors.primary,
    fontSize: 13,
    fontWeight: "700",
    textTransform: "uppercase"
  },
  title: {
    color: colors.text,
    fontSize: 28,
    fontWeight: "800",
    marginTop: 4
  },
  grid: {
    flexDirection: "row",
    flexWrap: "wrap",
    gap: 12
  },
  section: {
    gap: 10
  },
  sectionTitle: {
    color: colors.text,
    fontSize: 18,
    fontWeight: "700"
  },
  movement: {
    alignItems: "center",
    backgroundColor: colors.surface,
    borderColor: colors.border,
    borderRadius: 8,
    borderWidth: 1,
    flexDirection: "row",
    justifyContent: "space-between",
    padding: 14
  },
  product: {
    color: colors.text,
    fontSize: 15,
    fontWeight: "700"
  },
  meta: {
    color: colors.muted,
    fontSize: 13,
    marginTop: 3
  },
  in: {
    color: colors.success,
    fontSize: 17,
    fontWeight: "800"
  },
  out: {
    color: colors.danger,
    fontSize: 17,
    fontWeight: "800"
  }
});
