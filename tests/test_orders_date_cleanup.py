import pandas as pd
from pathlib import Path
import sys

sys.path.append(str(Path(__file__).resolve().parents[1] / "E-Commerce Order Analytics System" / "scripts"))

import clean_data


def test_missing_order_dates_are_replaced_with_default_date():
    sample = pd.DataFrame(
        {
            "customer_id": [1, 2],
            "order_date": ["2024-01-01", None],
            "order_status": ["Completed", "Pending"],
            "payment_method": ["Card", "Cash"],
        }
    )

    clean_data.orders = sample.copy()
    clean_data.clean_orders()

    assert pd.isna(clean_data.orders.loc[1, "order_date"]) is False
    assert clean_data.orders.loc[1, "order_date"] == pd.Timestamp("1970-01-01")
