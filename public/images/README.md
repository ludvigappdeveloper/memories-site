# Required image assets

Every image on the site is currently a placeholder `<div>` with the exact final
aspect ratio, so pages will not reflow when the real files drop in. To swap one
in: capture/export the shot below, save it here with the exact filename, then
replace the placeholder `<div class="ph …">` with
`<img src="/public/images/<filename>" alt="…">` (each placeholder has the
intended path in an HTML comment right above it, and its `aria-label` is the
ready-made alt text).

iPhone screenshots are captured at 1290 × 2796 (iPhone Pro, 9:19.5).
Wide shots are 2400 × 1350 (16:9).

## Landing page (`/index.html`)

| Filename | Dimensions | What to capture |
|---|---|---|
| `hero-app-import.png` | 1290 × 2796 | The app's selection screen with a real-looking export loaded: memories grouped by month with photo previews, date range visible, "Import N memories" button. This is the first thing every visitor sees — use warm, personal-looking (staged) photos. |
| `cap-dates.png` | 1290 × 2796 | iOS Photos detail view of one imported memory: the original date (e.g. "15 July 2017") and the location map row clearly visible. |
| `cap-overlay.png` | 1290 × 2796 | A finished memory with its caption/drawing baked in — pick one where the caption is charming and legible. Can be the app's result screen or the photo full-screen in Photos. |
| `cap-photos-sorted.png` | 1290 × 2796 | iOS Photos "Years" view after an import: several years (e.g. 2016–2024) populated with restored memories. |
| `before-export-folder.png` | 2400 × 1350 | The raw export as the user meets it: Files app (or Finder) showing `mydata~*.zip` parts and/or extracted files with long randomised names, all dated export-day. Should feel like chaos. |
| `after-photos-library.png` | 2400 × 1350 | The payoff: iOS Photos timeline sorted into real years next to (or including) the map view dotted with restored locations. Should feel like a life. Same memories as the "before" shot if possible. |

## Guide page (`/guide/index.html`)

The guide's step-by-step walkthrough uses the **same six screenshots as the app's
in-app Full guide** (`GuideView.swift` → `GuideDetailView`), so you can reuse the
exact assets. Export them from the app's asset catalog (or re-capture) at phone size.
Legal note for all six: these are Snapchat's own screens — crop to the form/list
content, keep out the Snapchat logo/ghost mark and brand-yellow chrome where you can.

| Filename | Dimensions | What to capture |
|---|---|---|
| `guide-1-settings.jpg` ✅ | 1290 × 2796 | Snapchat Settings scrolled to the **My Data** row. |
| `guide-2-request.jpg` ✅ | 1290 × 2796 | The My Data request form with **Export your Memories** and **Export JSON Files** both switched on, highlighted. |
| `guide-3-daterange.jpg` ✅ | 1290 × 2796 | Date-range picker set to **All Time**, email field confirmed, **Submit** highlighted. |
| `guide-4-inprogress.jpg` ✅ | 1290 × 2796 | The **Your exports** list showing a request marked **In progress**. |
| `guide-5-downloads.jpg` ✅ | 1290 × 2796 | A ready export with several `mydata~….zip` parts to download / save to Files. |
| `guide-6-import.png` | 1290 × 2796 | The app's own import screen: export loaded, memories grouped by month. |

## Also needed (not `<img>` placeholders)

| Asset | Where | Notes |
|---|---|---|
| `app-icon.png` **(you add this)** | Header wordmark logo (all pages) | **Save the real app icon here as `app-icon.png`** (square, e.g. 512×512 or 1024×1024). The header already points at it; until it exists, an SVG recreation (`app-icon.svg`) shows automatically as a fallback via the `<img onerror>`. No markup change needed once you drop the PNG in. |
| Apple App Store badge | Hero + guide CTA (`.appstore-badge`) | Currently a **green custom button** ("Download on the App Store") to match the site's accent. Note: Apple's own guidelines require their official black/white badge for the real store link — swap this for the official localized badge before submitting, and don't recolor that one. |
| Favicon / touch icon | `<head>` of all pages (not yet referenced) | Export from the app icon set (`AppIcon.appiconset`). |
| Social preview (`og-image.png`, 1200 × 630) | `<head>` meta (not yet referenced) | Optional but worth it: hero headline over the after-photos visual. |
