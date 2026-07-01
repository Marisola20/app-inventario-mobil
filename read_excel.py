import pandas as pd
import json

df_dict = pd.read_excel('bd.xlsx', sheet_name=None)
for sheet, df in df_dict.items():
    print(f"=== Sheet: {sheet} ===")
    print(df.head().to_string())
    print("\n")
