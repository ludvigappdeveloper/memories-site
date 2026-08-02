# Från noll till live domän, steg för steg

Sajten ligger redan på GitHub Pages (`ludvigappdeveloper.github.io/memories-site`).
Det enda som återstår är att köpa en domän och peka den hit. Räkna med ~30 min
jobb + lite väntetid på att internet hänger med.

Exemplet nedan använder **memoriestophotos.com**. Byt ut mot din domän överallt.

---

## Del 1 — Köp domänen (Cloudflare)

1. Gå till **dash.cloudflare.com** och skapa ett gratis konto (om du inte har ett).
2. Klicka **Domain Registration → Register Domains** i vänstermenyn.
3. Sök på **memoriestophotos.com**, lägg i varukorgen, betala (~10 USD/år).
   - WHOIS-integritet ingår gratis, du behöver inte kryssa i något extra.
   - När köpet är klart läggs domänen automatiskt in i ditt Cloudflare-konto.
   - Om just den är tagen: `backtophotos.com`, `getmemoriesback.com` eller
     `exportmymemories.com` var lediga senast jag kollade.

Nu **äger** du namnet och Cloudflare sköter DNS åt dig. Klart med köpet.

---

## Del 2 — Byt adressen i koden (på datorn)

Öppna Terminal och kör, från `website`-mappen:

    cd "/Users/ludvigstahlberg/Desktop/Memory Sorter/website"
    ./swap-domain.sh memoriestophotos.com

Det byter GitHub-adressen mot din domän i alla 43 filer och skapar en `CNAME`-fil.

Granska och pusha sedan:

    git diff --stat
    git add -A
    git commit -m "Byt till egen domän: memoriestophotos.com"
    git push

(Sajten uppdateras på GitHub, men syns ännu bara på den gamla adressen tills DNS
är satt i Del 4.)

---

## Del 3 — Säg till GitHub vilken domän det är

1. Gå till **github.com/ludvigappdeveloper/memories-site**
2. **Settings** (kugghjulet högst upp i repot) → **Pages** (i vänstermenyn).
3. Under **Custom domain**: skriv `memoriestophotos.com` → **Save**.
   - GitHub börjar nu leta efter domänen. Det står "DNS check in progress",
     det är väntat tills Del 4 är klar.

---

## Del 4 — Peka domänen mot GitHub (Cloudflare DNS)

Tillbaka i Cloudflare: välj din domän → **DNS → Records → Add record**.
Lägg in **exakt** dessa (klicka Add record en gång per rad):

**Fyra A-poster** (apex-domänen → GitHubs servrar). För alla fyra:
Type = `A`, Name = `@`, och en IPv4 var:

    185.199.108.153
    185.199.109.153
    185.199.110.153
    185.199.111.153

**En CNAME-post** (www → GitHub):

    Type = CNAME,  Name = www,  Target = ludvigappdeveloper.github.io

**VIKTIGT — sätt varje post till "DNS only":** klicka det oranga molnet i
Proxy-kolumnen så det blir **grått** ("DNS only"). Annars kan GitHubs HTTPS-cert
strula. (Du kan slå på proxy senare om du vill, men börja grått.)

---

## Del 5 — Vänta, slå på HTTPS, klart

1. Vänta 5–30 min (ibland upp till någon timme). Cloudflare-DNS brukar vara snabbt.
2. Gå tillbaka till **GitHub → Settings → Pages**. När den gröna bocken
   "DNS check successful" dyker upp, kryssa i **Enforce HTTPS**.
   - Rutan kan vara gråad en stund medan GitHub skapar certifikatet, vänta bara
     och ladda om sidan efter ~15–30 min.
3. Öppna **https://memoriestophotos.com** i webbläsaren. Sajten ska ligga där,
   med hänglås, utan `github.io` eller extra ord i adressen.

Testa även `https://memoriestophotos.com/de/` (tyska) och `/fr/`, `/es/`.

---

## Klart. Vad har hänt?

- **Cloudflare** = din adress (domänen) + DNS som pekar hem till GitHub.
- **GitHub** = huset där sajten faktiskt bor. Du fortsätter `git push` som vanligt,
  inget deploy-flöde ändras.
- Besökaren ser bara `memoriestophotos.com`, en helt riktig sida.

## Efteråt (inte bråttom)

- Uppdatera App Store Connect-länken när appen fått sitt id (byt `idXXXXXXXXXX`).
- Lägg in en riktig delningsbild (og-image 1200×630).
- Byt den gröna CTA-knappen mot Apples officiella App Store-badge.

## Om något krånglar

- **"DNS check unsuccessful" i timmar:** dubbelkolla att A-posterna har Name `@`
  och att molnet är **grått** (DNS only), inte orange.
- **Hänglåset saknas / "not secure":** certifikatet är inte klart än, vänta och
  slå på Enforce HTTPS när rutan går att kryssa.
- **Sajten visar 404:** kontrollera att `CNAME`-filen pushades (den ska innehålla
  bara `memoriestophotos.com`) och att Custom domain är satt i GitHub Pages.
