# Typst Font Sample Generator Script


I was fed up with manually checking fonts one by one — switching between tools, trying different characters, and wasting time just to compare typefaces. So I built this script to automate the process and make font testing actually a bit fun.

This project provides a Bash script to automatically generate a beautifully formatted Typst document showcasing all installed fonts. Each font is applied to a multilingual, typographically rich paragraph to test glyph support, ligatures, spacing, and general visual feel.



## What It Does

- Lists all fonts known to Typst.
- Creates a multi-column `.typ` document with a styled paragraph for each font.
- Compiles the Typst file into a PDF using `typst compile`.

---

## How to Use

1. **Make the script executable**  
   ```bash
   chmod +x generate_typst_font_examples.sh
   ```

2. **Run the script**  
   ```bash
   ./generate_typst_font_examples.sh
   ```

3. You’ll get:
   - A font list (`typst_fonts.txt`)
   - A Typst file (`typst_font_examples.typ`)
   - A compiled PDF (`typst_font_examples.pdf`)

---

## How to Customize

### Changing the Dummy Text

Edit the `PARAGRAPH_TEXT` block inside the script. It uses:

```bash
cat << 'EOF'
your dummy text here
EOF
```

This defines the paragraph text inserted for each font. You can replace it with your own multilingual or font stress test sample.

### Changing Page Layout or Styling

At the top of the generated `.typ` file is this common setup:

```typst
#set page(columns: 2, numbering: "1/1", number-align: right)
#set heading(numbering: "1.1")
#set par(justify: true)
```

You can customize:

- `columns: 1` → change number of columns
- `justify: false` → set to `true` to enable paragraph justification
- `numbering: "1.1"` → use `"none"` to disable heading numbers

Edit these values directly in the script where the Typst header block is written.

---

## Tip

Most LLMs are easily capable of sorting typst_fonts.txt into sans serif, serif, mono fonts, handwritten fonts and others. Outcomment the font list creation in the script like so

```bash
# Step 1: Generate font list
# echo "Generating font list..."
# typst fonts > typst_fonts.txt
```

---

## Installing Typst via Cargo/Rust

If you don’t have Rust installed, see here:

https://www.rust-lang.org/tools/install

Run:

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

After installation, restart your terminal or run:

```bash
source "$HOME/.cargo/env"
```

To verify:

```bash
rustc --version
cargo --version
```

---

## Installing Typst via Cargo

With Rust and Cargo installed, you can install (and update) Typst:

```bash
cargo install typst-cli
```

To verify the install:

```bash
typst --version
```

---
