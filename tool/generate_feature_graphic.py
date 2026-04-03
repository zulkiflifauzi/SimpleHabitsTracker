"""
Generates the Simple Habits Tracker Play Store feature graphic (1024x500 PNG).
Design: coral gradient background, app icon left, app name + tagline right.
"""

from PIL import Image, ImageDraw, ImageFont
import math
import os

W, H = 1024, 500
CORAL      = (255, 107, 107)
CORAL_DARK = (220,  72,  72)
WHITE      = (255, 255, 255, 255)

# ── Canvas ───────────────────────────────────────────────────────────────────
img = Image.new("RGB", (W, H), CORAL)
draw = ImageDraw.Draw(img)

# Diagonal gradient overlay (dark coral → coral) via horizontal bands
for x in range(W):
    t = x / W
    r = int(CORAL_DARK[0] + (CORAL[0] - CORAL_DARK[0]) * t)
    g = int(CORAL_DARK[1] + (CORAL[1] - CORAL_DARK[1]) * t)
    b = int(CORAL_DARK[2] + (CORAL[2] - CORAL_DARK[2]) * t)
    draw.line([(x, 0), (x, H)], fill=(r, g, b))

# ── Decorative circles (background) ─────────────────────────────────────────
circle_draw = ImageDraw.Draw(img)
def soft_circle(cx, cy, r, alpha=30):
    overlay = Image.new("RGBA", (W, H), (0, 0, 0, 0))
    od = ImageDraw.Draw(overlay)
    od.ellipse([cx - r, cy - r, cx + r, cy + r], fill=(255, 255, 255, alpha))
    img.paste(Image.alpha_composite(img.convert("RGBA"), overlay).convert("RGB"))

soft_circle(820, -60, 260, 25)
soft_circle(900, 420, 180, 20)
soft_circle(60,  460, 140, 18)

# ── Draw mini icon (left side) ───────────────────────────────────────────────
ICON_SIZE = 200
icon_x = 100   # center x of icon
icon_y = H // 2  # center y

icon_img = Image.new("RGBA", (ICON_SIZE, ICON_SIZE), (0, 0, 0, 0))
icon_draw = ImageDraw.Draw(icon_img)

# White rounded square background for the icon
icon_draw.rounded_rectangle(
    [0, 0, ICON_SIZE - 1, ICON_SIZE - 1],
    radius=int(ICON_SIZE * 0.22),
    fill=(255, 255, 255, 255)
)

# Coral checkmark on white background
scale = ICON_SIZE / 108
stroke = max(int(11 * scale), 8)
ICON_CORAL = (255, 107, 107, 255)

def thick_line_icon(d, x1, y1, x2, y2, w, color):
    d.line([(x1, y1), (x2, y2)], fill=color, width=w, joint="curve")
    r = w // 2
    d.ellipse([x1-r, y1-r, x1+r, y1+r], fill=color)
    d.ellipse([x2-r, y2-r, x2+r, y2+r], fill=color)

def sc(v): return int(v * scale)

thick_line_icon(icon_draw, sc(28), sc(57), sc(46), sc(75), stroke, ICON_CORAL)
thick_line_icon(icon_draw, sc(46), sc(75), sc(80), sc(35), stroke, ICON_CORAL)

# Sparkle star
def draw_4star(d, cx, cy, r_outer, r_inner, color):
    points = []
    for i in range(8):
        angle = math.radians(i * 45 - 90)
        r = r_outer if i % 2 == 0 else r_inner
        points.append((cx + r * math.cos(angle), cy + r * math.sin(angle)))
    d.polygon(points, fill=color)

draw_4star(icon_draw, sc(82), sc(33.5), r_outer=sc(8.5), r_inner=sc(3), color=ICON_CORAL)

# Paste icon onto main canvas
icon_pos = (icon_x - ICON_SIZE // 2, icon_y - ICON_SIZE // 2)
img.paste(icon_img.convert("RGB"), icon_pos, mask=icon_img.split()[3])

# ── Text ─────────────────────────────────────────────────────────────────────
draw = ImageDraw.Draw(img)

# Try to load a system font, fall back to default
def load_font(size, bold=False):
    candidates = [
        "C:/Windows/Fonts/arialbd.ttf" if bold else "C:/Windows/Fonts/arial.ttf",
        "C:/Windows/Fonts/Arial Bold.ttf" if bold else "C:/Windows/Fonts/Arial.ttf",
        "/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf" if bold else "/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf",
    ]
    for path in candidates:
        try:
            return ImageFont.truetype(path, size)
        except Exception:
            continue
    return ImageFont.load_default()

text_x = 340   # start of text column

# App name
font_title = load_font(62, bold=True)
draw.text((text_x, 140), "Simple Habits", font=font_title, fill=(255, 255, 255))
draw.text((text_x, 210), "Tracker", font=font_title, fill=(255, 255, 255))

# Tagline
font_tag = load_font(28, bold=False)
draw.text((text_x, 300), "Build better habits, one day at a time.", font=font_tag, fill=(255, 235, 235))

# Subtle "fully offline & private" note
font_note = load_font(22, bold=False)
draw.text((text_x, 348), "✓ Fully offline   ✓ No account needed   ✓ Private", font=font_note, fill=(255, 210, 210))

# ── Save ─────────────────────────────────────────────────────────────────────
out_dir = os.path.join(os.path.dirname(__file__), "..", "store_assets")
os.makedirs(out_dir, exist_ok=True)
out_path = os.path.join(out_dir, "feature_graphic_1024x500.png")
img.save(out_path, "PNG")
print(f"Feature graphic saved to: {os.path.abspath(out_path)}")
