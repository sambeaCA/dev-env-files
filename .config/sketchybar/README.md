# SketchyBar Configuration

Custom macOS menu bar replacement using [SketchyBar](https://github.com/FelixKratz/SketchyBar).

---

### Bar Appearance

- Position: top, height 37px with blur
- Color scheme: **Teal** (switchable — Gray, Purple, Red, Blue, Green, Orange, Yellow schemes included in `colors.sh`)
- Font: SF Pro Semibold

### Items

| Position | Items |
|----------|-------|
| Left | Workspace spaces, Front app name |
| Center (right of notch) | Media / Now Playing |
| Right | Calendar, Volume, Battery, CPU |

### Structure

```
sketchybar/
├── sketchybarrc       # Main config — bar appearance & item loading
├── colors.sh          # Color scheme definitions
├── items/             # Item configurations (what to display)
└── plugins/           # Scripts that provide data to items
```
