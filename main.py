# python helper script to solve the kmap
from pathlib import Path
import argparse
import pandas as pd


def make_lowercase_set():
    
    s = set(range(97, 123))
    # Latin-1 lowercase ranges commonly used for letters
    s.update(range(224, 247))
    s.update(range(248, 256))
    return s


def fill_kmap_df(df: pd.DataFrame, lowercase_set: set) -> pd.DataFrame:
    col_labels = list(df.columns)[:16]
    row_labels = list(df.index)[:16]

    out = pd.DataFrame(index=row_labels, columns=col_labels, dtype=int)

    for rlabel in row_labels:
        try:
            high = int(str(rlabel).strip(), 2)
        except Exception:
            raise ValueError(f"Row label not a 4-bit binary string: '{rlabel}'")
        for clabel in col_labels:
            try:
                low = int(str(clabel).strip(), 2)
            except Exception:
                raise ValueError(f"Col label not a 4-bit binary string: '{clabel}'")
            val = (high << 4) | low
            out.at[rlabel, clabel] = 1 if val in lowercase_set else 0

    return out


def main():
    parser = argparse.ArgumentParser(description='Solve K-map for isLowercase using pandas')
    parser.add_argument('--input', '-i', default='kmap.csv')
    parser.add_argument('--output', '-o', default='kmap_isLowercase_pandas.csv')
    args = parser.parse_args()

    inp = Path(args.input)
    outp = Path(args.output)
    if not inp.exists():
        raise SystemExit(f"Input file not found: {inp}")

    # Read with pandas, treat first column as row labels
    df = pd.read_csv(inp, header=0, index_col=0, dtype=str, keep_default_na=False)

    lc = make_lowercase_set()
    out_df = fill_kmap_df(df, lc)

    # Write CSV preserving labels
    out_df.to_csv(outp, index=True)

    ones = int((out_df.values == 1).sum())
    total = out_df.shape[0] * out_df.shape[1]
    print(f"Wrote {outp} — {ones}/{total} cells = {ones/total:.4%} true (isLowercase)")


if __name__ == '__main__':
    main()
