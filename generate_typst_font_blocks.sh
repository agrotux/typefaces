#!/bin/bash

# Step 1: Generate font list
echo "Generating font list..."
typst fonts > typst_fonts.txt

FONT_LIST="typst_fonts.txt"
OUTPUT_FILE="typst_font_examples.typ"

# Step 2: Write common setup to output Typst file
echo "Creating Typst file: $OUTPUT_FILE"
cat << 'EOF' > "$OUTPUT_FILE"
//common part
#set page(columns: 1, numbering: "1/1", number-align: right)
#set heading(numbering: "1.1")
#set par(justify: false)

EOF

# Step 3: Shared multilingual paragraph (escaped properly)
PARAGRAPH_TEXT=$(cat << 'EOF'
"Yxskaftbud, ge vår WC-zonmö IQ-hjälp! The quick brown fox jumps over a lazy dog. Vår sære Zulu fra badeøya spilte jo whist och quickstep? Victor jagt zwölf Boxkämpfer quer über den großen Sylter Deich; el veloz murciélago hindú comía feliz cardillo y kiwi.Voyez le bon whisky que je garde près de l'âtre"
== weird glyphs
Blå Örn jublade: 'Väx! Qvick fynd—87 jackor på 5½ dygn!' Ægir & Øyvind sörjde, men Zäta typade ðen fulla listan: {A–Z, a–z, ÅÄÖåäö ÆØæø Þþ Ðð 0–9} + symbols like ~!@\#\$%^&\*()\_+=[]{}|;:'",.<>?/ for max font test. Jumping foxes, lazy dogs, 9 quirky zebras, 12 fjords, bold glyphs & crisp ligatures unify this dazzling mix. Typo #404? Fix it by 3:45 p.m. — or pay \$999.99 in fines (excl. VAT). Kära läsare, glöm ej: 'Skriv rätt – använd alla tecken!' Så jobbar vi med typografi i världsklass. Ümlauts hum, ŋæsthetics shine, en-dashes – em-dashes — ellipses… and ¶ilcrows march! Even ☃, ☯, and ©®™ join in: a festival of forms for every script & screen. Från serif till sans, från pixel till print – typens triumf är komplett.\
== smallcaps if available
#smallcaps()[Thor composted Mjölnir after the soil lost its spark. “No thunder without microbes,” he grunted, mulching Yggdrasil’s roots with goat manure and kelp tea.]\
== Emphasis function
#emph()[Odin traded one eye for wisdom, and the other for a no-till seed drill. “Monocultures are the true Ragnarok,” he warned, petting a nitrogen-fixing goat.]\
== Strong/bold
#strong()[Loki disguised himself as a chicken to infiltrate a carbon-sequestering pasture. “Chaos is fine,” he whispered, “as long as it builds humus.”]\
== Strong emphasis
#emph()[#strong()[Freyja planted clover beneath a blood-orange moon, declaring, “Regenerative agriculture is Midgard’s only chance.” “You want climate salvation?” she smirked.]]
#set align(center)
#set quote(block: true)
#quote()[“Þá kastaðu arðinum, nær jörðina, ok hlýð ormunum.”]
#line(length: 90%)
#set align(left)
EOF
)

# Step 4: Loop through fonts and append test blocks
while IFS= read -r FONT; do
  [[ -z "$FONT" ]] && continue

  cat >> "$OUTPUT_FILE" << EOF
#set text(
  font: "$FONT",
  size: 10pt
)
= $FONT
$PARAGRAPH_TEXT

EOF

done < "$FONT_LIST"

# Step 5: Compile the Typst file
echo "Compiling Typst document..."
typst compile "$OUTPUT_FILE"

echo "Done. Output written to $OUTPUT_FILE and compiled PDF."
