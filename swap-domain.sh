#!/usr/bin/env bash
#
# swap-domain.sh — byt GitHub Pages-adressen mot din riktiga domän i hela sajten.
#
# Kör EN gång, den dagen du köpt domänen:
#
#     ./swap-domain.sh memoriestophotos.com
#
# Vad den gör:
#   1. Byter  https://ludvigappdeveloper.github.io/memories-site  ->  https://DINDOMAN
#      i alla .html, .txt och .xml (canonical, hreflang, og:image, sitemap, robots, schema).
#   2. Skapar CNAME-filen som GitHub Pages behover for att servera pa din domän.
#   3. Skriver ut en sammanfattning sa du kan granska med `git diff` innan du commitar.
#
# Den ROR ingenting annat. Inga sidor tas bort, inget commitas at dig.
# Vill du angra innan commit: `git checkout -- .`  (bara i denna website-mapp,
# som ar ett eget git-repo skilt fran huvudprojektet).

set -euo pipefail

# --- 1. Las och stada domän-argumentet -------------------------------------
if [ $# -ne 1 ]; then
  echo "Anvandning: ./swap-domain.sh dindoman.com"
  echo "Exempel:    ./swap-domain.sh memoriestophotos.com"
  exit 1
fi

# Ta bort ev. https://, http://, www. och avslutande slash som anvandaren rakat skriva.
DOMAIN="$1"
DOMAIN="${DOMAIN#http://}"
DOMAIN="${DOMAIN#https://}"
DOMAIN="${DOMAIN#www.}"
DOMAIN="${DOMAIN%/}"

# Enkel rimlighetskoll: maste se ut som namn.tld
if ! echo "$DOMAIN" | grep -qE '^[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'; then
  echo "FEL: '$DOMAIN' ser inte ut som en giltig domän (t.ex. memoriestophotos.com)."
  exit 1
fi

OLD_BASE="https://ludvigappdeveloper.github.io/memories-site"
NEW_BASE="https://$DOMAIN"

# --- 2. Sakerhetskoll: star vi i ratt mapp? --------------------------------
if [ ! -f "index.html" ] || [ ! -f "sitemap.xml" ]; then
  echo "FEL: kor skriptet fran website-mappen (dar index.html och sitemap.xml ligger)."
  exit 1
fi

BEFORE=$(grep -rl "$OLD_BASE" --include="*.html" --include="*.txt" --include="*.xml" . 2>/dev/null | wc -l | tr -d ' ')
if [ "$BEFORE" -eq 0 ]; then
  echo "Inget att byta: hittar ingen '$OLD_BASE' i sajten."
  echo "(Har du redan kort skriptet? Da ar bytet gjort.)"
  exit 0
fi

echo "Byter:  $OLD_BASE"
echo "till:   $NEW_BASE"
echo "i $BEFORE filer ..."
echo ""

# --- 3. Gor bytet (BSD/macOS sed, | som avgransare da URL:er har /) ---------
grep -rl "$OLD_BASE" --include="*.html" --include="*.txt" --include="*.xml" . 2>/dev/null \
  | while IFS= read -r f; do
      sed -i '' "s|$OLD_BASE|$NEW_BASE|g" "$f"
    done

# --- 4. Skapa CNAME sa GitHub Pages kanner igen domänen --------------------
echo "$DOMAIN" > CNAME
echo "Skapade CNAME  ->  $DOMAIN"

# --- 5. Sammanfattning ------------------------------------------------------
REMAIN=$(grep -rho "$OLD_BASE" --include="*.html" --include="*.txt" --include="*.xml" . 2>/dev/null | wc -l | tr -d ' ')
echo ""
echo "Klart. Kvarvarande forekomster av gamla adressen: $REMAIN (ska vara 0)."
echo ""
echo "Nasta steg:"
echo "  1. Granska:  git diff --stat   (och garna  git diff  pa nagon fil)"
echo "  2. Commita:  git add -A && git commit -m \"Byt till egen domän: $DOMAIN\""
echo "  3. Pusha:    git push"
echo "  4. I GitHub -> repo Settings -> Pages -> Custom domain: skriv $DOMAIN"
echo "  5. Hos registraren (Cloudflare): peka domänen mot GitHub Pages"
echo "     (A-poster till GitHubs IP:er + CNAME www -> ludvigappdeveloper.github.io)."
