# PocketSana-Website (GitHub Pages)

Dieser Ordner ist die fertige Website. Er enthält nur öffentliche Texte, keinen App-Code.

## Einmalig einrichten

1. Auf github.com anmelden und ein **neues Repository** anlegen, Name z. B. `pocketsana`,
   Sichtbarkeit **Public**, ohne README.
2. Im leeren Repository auf **«uploading an existing file»** klicken und den **Inhalt** dieses
   Ordners hineinziehen (die Ordner `_layouts` und `assets` mitsamt Inhalt und alle `.md`- und
   `.yml`-Dateien). `LIESMICH.md` und `aktualisieren.pl` dürfen mit, sie werden nicht
   veröffentlicht. Dann **Commit changes**.
3. **Settings → Pages**: bei «Source» **Deploy from a branch** wählen, Branch **main**, Ordner
   **/ (root)**, **Save**. Nach 1–2 Minuten ist die Seite erreichbar unter
   `https://BENUTZERNAME.github.io/pocketsana/`.
4. Unter **Settings → Pages** den Haken **Enforce HTTPS** setzen (falls nicht schon aktiv).

Die Adressen für die App und die Play Console sind dann:

- Datenschutzerklärung: `https://BENUTZERNAME.github.io/pocketsana/datenschutz`
- Nutzungsbedingungen: `https://BENUTZERNAME.github.io/pocketsana/nutzungsbedingungen`
- Impressum: `https://BENUTZERNAME.github.io/pocketsana/impressum`

## Nach einer Änderung der Rechtstexte

`perl aktualisieren.pl` übernimmt Datenschutzerklärung und Nutzungsbedingungen aus
`meine-akte/legal/`. Danach die beiden Dateien `datenschutz.md` und `nutzungsbedingungen.md`
im Repository ersetzen (hochladen, Commit).
