# aida-price-checker

This docker images mainly uses curl and jq to connect to the aida and telegram API

```yaml
services:
  aida-price-checker:
    container_name: aida-price-checker
    image: zoeyvid/aida-price-checker
    restart: always
    network_mode: bridge
    environment:
      - "TZ=Europe/Berlin"                                   # Zeitzone
      - "CI=7d"                                              # interval to sent prices
      - "AIDs=SO12240702"                                    # ID(s) der AIDA-Reise (bei mehreren durch Leerzeichen trennen)
      - "AAK=1QfHZ3LvMQ7cDSL9YFUbOsKzShRPBQDg6re5zeJG"       # x-api-key (kann im Netzwerk-Tab von F12 gefunden werden), ungültiges Beispiel
      - "AA=2"                                               # Anzahl Erwachsene
      - "AJ=1"                                               # Anzahl Jugendliche
      - "AC=0"                                               # Anzahl Kinder
      - "CUA=Firefox"                                        # User-Agent für cURL
      - "ACIDs=BV BB BA"                                     # Kabinen IDs ohne All inclusive
      - "ACAIIDs=MV MB MA"                                   # Kabinen IDs mit All inclusive
      - "TBT=3567368463:JUG3OCkc35zduH3759lqeJ6KN6R6UFhdie5" # Telegram Bot-Token, ungültiges Beispiel
      - "TCIDs=678428904"                                    # Chat-ID(s) des/der Telegram-Kontos/Konten (bei mehreren durch Leerzeichen trennen)
```
