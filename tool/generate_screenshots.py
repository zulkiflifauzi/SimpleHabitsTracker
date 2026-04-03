"""
Generates Play Store phone screenshots (1080x1920) for Simple Habits Tracker.
Produces 3 screens: Home/Today, Add Habit, Archive.
"""

from PIL import Image, ImageDraw, ImageFont
import math, os

# ── Constants ─────────────────────────────────────────────────────────────────
W, H       = 1080, 1920
CORAL      = (255, 107, 107)
CORAL_DARK = (220,  72,  72)
CORAL_SOFT = (255, 235, 235)
WHITE      = (255, 255, 255)
OFF_WHITE  = (255, 251, 250)
SURFACE    = (255, 248, 246)
CARD_BG    = (255, 255, 255)
TEXT_DARK  = ( 32,  18,  18)
TEXT_MID   = (100,  70,  70)
TEXT_LIGHT = (160, 130, 130)
DIVIDER    = (240, 225, 225)
NAV_BG     = (255, 252, 251)
CORAL_ALPHA= (255, 107, 107, 40)

STATUS_H   = 60
APPBAR_H   = 120
NAVBAR_H   = 140

OUT_DIR = os.path.join(os.path.dirname(__file__), "..", "store_assets", "screenshots")
os.makedirs(OUT_DIR, exist_ok=True)

# ── Font loader ───────────────────────────────────────────────────────────────
def font(size, bold=False):
    candidates = [
        ("C:/Windows/Fonts/arialbd.ttf" if bold else "C:/Windows/Fonts/arial.ttf"),
        ("C:/Windows/Fonts/calibrib.ttf" if bold else "C:/Windows/Fonts/calibri.ttf"),
    ]
    for p in candidates:
        try: return ImageFont.truetype(p, size)
        except: pass
    return ImageFont.load_default()

# ── Base helpers ──────────────────────────────────────────────────────────────
def new_screen():
    img = Image.new("RGB", (W, H), SURFACE)
    return img, ImageDraw.Draw(img)

def draw_status_bar(draw):
    draw.rectangle([0, 0, W, STATUS_H], fill=WHITE)
    draw.text((60, 16), "9:41", font=font(34, bold=True), fill=TEXT_DARK)
    # battery
    bx, by = W - 100, 18
    draw.rounded_rectangle([bx, by, bx+60, by+26], radius=5, fill=TEXT_DARK)
    draw.rounded_rectangle([bx+2, by+2, bx+46, by+24], radius=4, fill=CORAL)
    draw.rectangle([bx+60, by+8, bx+66, by+18], fill=TEXT_DARK)

def draw_navbar(draw, selected=1):
    y = H - NAVBAR_H
    draw.rectangle([0, y, W, H], fill=NAV_BG)
    draw.line([(0, y), (W, y)], fill=DIVIDER, width=2)
    labels = ["Archive", "Today", "Stats"]
    icons  = ["🔖", "✅", "📊"]
    for i, (label, icon) in enumerate(zip(labels, icons)):
        cx = W // 6 + i * (W // 3)
        color = CORAL if i == selected else TEXT_LIGHT
        draw.text((cx - 24, y + 18), icon, font=font(44), fill=color)
        tw = draw.textlength(label, font=font(28, bold=(i==selected)))
        draw.text((cx - tw//2, y + 72), label, font=font(28, bold=(i==selected)), fill=color)

def draw_appbar(draw, title, subtitle=None):
    draw.rectangle([0, STATUS_H, W, STATUS_H + APPBAR_H], fill=WHITE)
    draw.text((60, STATUS_H + 18), title, font=font(46, bold=True), fill=TEXT_DARK)
    if subtitle:
        draw.text((60, STATUS_H + 72), subtitle, font=font(30), fill=TEXT_LIGHT)
    # settings icon (tune)
    ix, iy = W - 90, STATUS_H + 34
    for offset in [-14, 0, 14]:
        draw.line([(ix - 20, iy + offset), (ix + 20, iy + offset)], fill=TEXT_MID, width=4)
    draw.ellipse([ix - 6, iy - 14 - 6, ix + 6, iy - 14 + 6], fill=WHITE, outline=TEXT_MID, width=4)
    draw.ellipse([ix - 6, iy + 0  - 6, ix + 6, iy + 0  + 6], fill=WHITE, outline=TEXT_MID, width=4)
    draw.ellipse([ix - 6, iy + 14 - 6, ix + 6, iy + 14 + 6], fill=WHITE, outline=TEXT_MID, width=4)

def draw_card(draw, x, y, w, h, radius=24):
    draw.rounded_rectangle([x, y, x+w, y+h], radius=radius, fill=CARD_BG)
    # subtle shadow line
    draw.rounded_rectangle([x, y+h-2, x+w, y+h+4], radius=4, fill=DIVIDER)

def draw_check(draw, cx, cy, r, checked=False, color=CORAL):
    if checked:
        draw.ellipse([cx-r, cy-r, cx+r, cy+r], fill=color)
        # white checkmark
        draw.line([(cx-r*0.4, cy), (cx-r*0.1, cy+r*0.35)], fill=WHITE, width=max(int(r*0.2),4))
        draw.line([(cx-r*0.1, cy+r*0.35), (cx+r*0.45, cy-r*0.3)], fill=WHITE, width=max(int(r*0.2),4))
    else:
        draw.ellipse([cx-r, cy-r, cx+r, cy+r], outline=DIVIDER, width=4)

def draw_streak(draw, x, y, count):
    draw.text((x, y), f"🔥 {count} day streak", font=font(26), fill=TEXT_LIGHT)

def draw_section_label(draw, x, y, label):
    draw.text((x, y), label.upper(), font=font(26, bold=True), fill=CORAL)

# ── Screenshot 1: Home / Today ────────────────────────────────────────────────
def make_home():
    img, draw = new_screen()
    draw.rectangle([0, 0, W, H], fill=OFF_WHITE)
    draw_status_bar(draw)
    draw_appbar(draw, "Today", "Thursday, 3 April")

    content_y = STATUS_H + APPBAR_H + 20

    # Section: Health
    draw_section_label(draw, 60, content_y, "Health")
    content_y += 50

    habits = [
        ("Run 30 minutes",      True,  "🏃", "12 day streak", "Goal-bound · 18 days left", CORAL),
        ("Drink 8 glasses",     True,  "💧", "5 day streak",  "Ongoing",                   (100, 180, 255)),
        ("Sleep by 11pm",       False, "😴", "3 day streak",  "Ongoing",                   (150, 130, 255)),
    ]

    for name, checked, emoji, streak, meta, color in habits:
        draw_card(draw, 40, content_y, W - 80, 150)
        # accent bar
        draw.rounded_rectangle([40, content_y, 52, content_y + 150], radius=6, fill=color)
        # emoji
        draw.text((80, content_y + 44), emoji, font=font(52), fill=TEXT_DARK)
        # name
        draw.text((158, content_y + 24), name, font=font(38, bold=True), fill=TEXT_DARK)
        # meta
        draw.text((158, content_y + 76), streak + "  ·  " + meta, font=font(26), fill=TEXT_LIGHT)
        # checkbox
        draw_check(draw, W - 100, content_y + 75, 36, checked=checked, color=color)
        content_y += 170

    # Section: Learning
    content_y += 10
    draw_section_label(draw, 60, content_y, "Learning")
    content_y += 50

    habits2 = [
        ("Read 20 pages",      False, "📚", "0 day streak",  "Goal-bound · 45 days left",  (255, 180, 80)),
        ("Practice Spanish",   True,  "🌎", "7 day streak",  "Ongoing",                    (80, 200, 150)),
    ]

    for name, checked, emoji, streak, meta, color in habits2:
        draw_card(draw, 40, content_y, W - 80, 150)
        draw.rounded_rectangle([40, content_y, 52, content_y + 150], radius=6, fill=color)
        draw.text((80, content_y + 44), emoji, font=font(52), fill=TEXT_DARK)
        draw.text((158, content_y + 24), name, font=font(38, bold=True), fill=TEXT_DARK)
        draw.text((158, content_y + 76), streak + "  ·  " + meta, font=font(26), fill=TEXT_LIGHT)
        draw_check(draw, W - 100, content_y + 75, 36, checked=checked, color=color)
        content_y += 170

    # FAB
    fab_cx, fab_cy = W - 110, H - NAVBAR_H - 100
    draw.ellipse([fab_cx - 70, fab_cy - 70, fab_cx + 70, fab_cy + 70], fill=CORAL)
    draw.line([(fab_cx - 28, fab_cy), (fab_cx + 28, fab_cy)], fill=WHITE, width=6)
    draw.line([(fab_cx, fab_cy - 28), (fab_cx, fab_cy + 28)], fill=WHITE, width=6)

    draw_navbar(draw, selected=1)
    img.save(os.path.join(OUT_DIR, "01_home.png"))
    print("Saved: 01_home.png")

# ── Screenshot 2: Add Habit sheet ─────────────────────────────────────────────
def make_add_habit():
    img, draw = new_screen()
    draw.rectangle([0, 0, W, H], fill=OFF_WHITE)
    draw_status_bar(draw)
    draw_appbar(draw, "Today", "Thursday, 3 April")

    # Dimmed backdrop
    overlay = Image.new("RGBA", (W, H), (0, 0, 0, 120))
    img = img.convert("RGBA")
    img = Image.alpha_composite(img, overlay)
    img = img.convert("RGB")
    draw = ImageDraw.Draw(img)

    # Bottom sheet
    sheet_y = 380
    draw.rounded_rectangle([0, sheet_y, W, H], radius=40, fill=WHITE)

    # Drag handle
    draw.rounded_rectangle([W//2 - 60, sheet_y + 20, W//2 + 60, sheet_y + 32], radius=6, fill=DIVIDER)

    # Title
    draw.text((60, sheet_y + 60), "New Habit", font=font(52, bold=True), fill=TEXT_DARK)

    y = sheet_y + 160

    # Habit name field
    draw.text((60, y), "Habit name", font=font(28, bold=True), fill=TEXT_MID)
    y += 44
    draw.rounded_rectangle([60, y, W - 60, y + 90], radius=16, outline=CORAL, width=3, fill=SURFACE)
    draw.text((84, y + 22), "e.g. Run 30 minutes", font=font(34), fill=TEXT_LIGHT)
    y += 110

    # Category
    draw.text((60, y), "Category", font=font(28, bold=True), fill=TEXT_MID)
    y += 44
    cats = [("Health", CORAL, True), ("Work", (100,180,255), False), ("Personal", (150,130,255), False), ("Learning", (255,180,80), False)]
    cx = 60
    for label, color, sel in cats:
        tw = draw.textlength(label, font=font(30, bold=sel))
        bw = tw + 40
        bg = color if sel else SURFACE
        fc = WHITE if sel else TEXT_MID
        draw.rounded_rectangle([cx, y, cx + bw, y + 60], radius=30, fill=bg)
        if not sel:
            draw.rounded_rectangle([cx, y, cx + bw, y + 60], radius=30, outline=DIVIDER, width=2)
        draw.text((cx + 20, y + 14), label, font=font(30, bold=sel), fill=fc)
        cx += bw + 16
    y += 80

    # How do you track it?
    draw.text((60, y), "How do you track it?", font=font(28, bold=True), fill=TEXT_MID)
    y += 44
    options = [("✓  Done / Not done", True), ("123  Count", False), ("⏱  Duration", False)]
    for label, sel in options:
        color = CORAL if sel else TEXT_MID
        bg = CORAL_SOFT if sel else SURFACE
        draw.rounded_rectangle([60, y, W - 60, y + 76], radius=16, fill=bg)
        if sel:
            draw.rounded_rectangle([60, y, W - 60, y + 76], radius=16, outline=CORAL, width=2)
        draw.text((100, y + 18), label, font=font(34, bold=sel), fill=color)
        y += 96

    # Save button
    y += 10
    draw.rounded_rectangle([60, y, W - 60, y + 100], radius=20, fill=CORAL)
    tw = draw.textlength("Save", font=font(40, bold=True))
    draw.text((W//2 - tw//2, y + 28), "Save", font=font(40, bold=True), fill=WHITE)

    img.save(os.path.join(OUT_DIR, "02_add_habit.png"))
    print("Saved: 02_add_habit.png")

# ── Screenshot 3: Archive ─────────────────────────────────────────────────────
def make_archive():
    img, draw = new_screen()
    draw.rectangle([0, 0, W, H], fill=OFF_WHITE)
    draw_status_bar(draw)

    # Appbar
    draw.rectangle([0, STATUS_H, W, STATUS_H + APPBAR_H], fill=WHITE)
    draw.text((60, STATUS_H + 36), "Archive", font=font(46, bold=True), fill=TEXT_DARK)

    content_y = STATUS_H + APPBAR_H + 30

    draw_section_label(draw, 60, content_y, "Completed")
    content_y += 50

    archived = [
        ("No Sugar for 30 Days",     "🍬", "Completed Apr 1, 2026",   "30 day streak",  (80, 200, 150)),
        ("Morning Journaling",        "📓", "Completed Mar 15, 2026",  "21 day streak",  (255, 180, 80)),
        ("Learn Flutter Basics",      "📱", "Completed Feb 28, 2026",  "60 day streak",  (100, 180, 255)),
        ("Meditate 10 min daily",     "🧘", "Completed Jan 20, 2026",  "45 day streak",  (150, 130, 255)),
    ]

    for name, emoji, date, streak, color in archived:
        draw_card(draw, 40, content_y, W - 80, 160)
        draw.rounded_rectangle([40, content_y, 52, content_y + 160], radius=6, fill=color)
        # trophy badge
        draw.ellipse([W - 150, content_y + 40, W - 80, content_y + 110], fill=CORAL_SOFT)
        draw.text((W - 138, content_y + 48), "🏆", font=font(42), fill=CORAL)
        # emoji + text
        draw.text((80, content_y + 50), emoji, font=font(48), fill=TEXT_DARK)
        draw.text((155, content_y + 18), name, font=font(36, bold=True), fill=TEXT_DARK)
        draw.text((155, content_y + 68), streak, font=font(28), fill=color)
        draw.text((155, content_y + 108), date, font=font(26), fill=TEXT_LIGHT)
        content_y += 180

    draw_navbar(draw, selected=0)
    img.save(os.path.join(OUT_DIR, "03_archive.png"))
    print("Saved: 03_archive.png")

# ── Run all ───────────────────────────────────────────────────────────────────
make_home()
make_add_habit()
make_archive()
print(f"\nAll screenshots saved to: {os.path.abspath(OUT_DIR)}")
