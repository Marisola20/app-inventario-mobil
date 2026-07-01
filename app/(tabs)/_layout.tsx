import { Ionicons } from "@expo/vector-icons";
import { Tabs } from "expo-router";

import { colors } from "@/theme/colors";

type IconName = keyof typeof Ionicons.glyphMap;

const icons: Record<string, IconName> = {
  dashboard: "grid-outline",
  products: "cube-outline",
  scanner: "scan-outline",
  movements: "swap-horizontal-outline"
};

export default function TabsLayout() {
  return (
    <Tabs
      screenOptions={({ route }) => ({
        headerStyle: { backgroundColor: colors.surface },
        headerTitleStyle: { color: colors.text },
        tabBarActiveTintColor: colors.primary,
        tabBarInactiveTintColor: colors.muted,
        tabBarStyle: { borderTopColor: colors.border },
        tabBarIcon: ({ color, size }) => (
          <Ionicons name={icons[route.name] ?? "ellipse-outline"} size={size} color={color} />
        )
      })}
    >
      <Tabs.Screen name="dashboard" options={{ title: "Inicio" }} />
      <Tabs.Screen name="products" options={{ title: "Productos" }} />
      <Tabs.Screen name="scanner" options={{ title: "Escaner" }} />
      <Tabs.Screen name="movements" options={{ title: "Movimientos" }} />
    </Tabs>
  );
}
