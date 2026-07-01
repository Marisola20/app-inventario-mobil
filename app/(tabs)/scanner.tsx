import { Ionicons } from "@expo/vector-icons";
import { Pressable, StyleSheet, Text, View } from "react-native";

import { colors } from "@/theme/colors";

export default function ScannerScreen() {
  return (
    <View style={styles.screen}>
      <View style={styles.scanBox}>
        <Ionicons name="scan-outline" size={72} color={colors.primary} />
        <Text style={styles.title}>Escaneo de productos</Text>
        <Text style={styles.body}>
          Esta pantalla queda preparada para activar la camara y leer codigos de barras o QR.
        </Text>
      </View>

      <Pressable style={styles.button}>
        <Ionicons name="camera-outline" size={20} color="#FFFFFF" />
        <Text style={styles.buttonText}>Activar camara</Text>
      </Pressable>
    </View>
  );
}

const styles = StyleSheet.create({
  screen: {
    alignItems: "center",
    backgroundColor: colors.background,
    flex: 1,
    justifyContent: "center",
    padding: 20
  },
  scanBox: {
    alignItems: "center",
    borderColor: colors.primary,
    borderRadius: 8,
    borderStyle: "dashed",
    borderWidth: 2,
    gap: 12,
    padding: 28,
    width: "100%"
  },
  title: {
    color: colors.text,
    fontSize: 22,
    fontWeight: "800",
    textAlign: "center"
  },
  body: {
    color: colors.muted,
    fontSize: 15,
    lineHeight: 22,
    textAlign: "center"
  },
  button: {
    alignItems: "center",
    backgroundColor: colors.primary,
    borderRadius: 8,
    flexDirection: "row",
    gap: 8,
    marginTop: 22,
    paddingHorizontal: 18,
    paddingVertical: 14
  },
  buttonText: {
    color: "#FFFFFF",
    fontSize: 15,
    fontWeight: "700"
  }
});
