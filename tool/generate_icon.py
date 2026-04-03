"""
Generates the Simple Habits Tracker Play Store icon (512x512 PNG).
Matches the adaptive icon design: coral background, white checkmark + sparkles.
"""

from PIL import Image, ImageDraw, ImageFilter
import math
import os

SIZE = 512
CORAL = (255, 107, 107, 255)       # #FF6B6B
WHITE = (255, 255, 255, 255)
TRANSPARENT = (0, 0, 0, 0)

img = Image.new("RGBA", (SIZE, SIZE), TRANSPARENT)
draw = ImageDraw.Draw(img)

# ── Background (rounded square, ~22% corner radius) ─────────────────────────
radius = int(SIZE * 0.22)
draw.rounded_rectangle([0, 0, SIZE - 1, SIZE - 1], radius=radius, fill=CORAL)

# ── Helper: draw a thick rounded line between two points ────────────────────
def thick_line(draw, x1, y1, x2, y2, width, color):
    """Simulate a round-capped thick line with an ellipse at each end."""
    draw.line([(x1, y1), (x2, y2)], fill=color, width=width, joint="curve")
    r = width // 2
    draw.ellipse([x1 - r, y1 - r, x1 + r, y1 + r], fill=color)
    draw.ellipse([x2 - r, y2 - r, x2 + r, y2 + r], fill=color)

# ── Checkmark ────────────────────────────────────────────────────────────────
# Points scaled from the 108dp vector space to 512px
scale = SIZE / 108

def s(v):
    return int(v * scale)

stroke = int(11 * scale)

# First arm: (28,57) → (46,75)
thick_line(draw, s(28), s(57), s(46), s(75), stroke, WHITE)
# Second arm: (46,75) → (80,35)
thick_line(draw, s(46), s(75), s(80), s(35), stroke, WHITE)

# ── 4-pointed sparkle star (top-right) ───────────────────────────────────────
def draw_4star(draw, cx, cy, r_outer, r_inner, color):
    points = []
    for i in range(8):
        angle = math.radians(i * 45 - 90)
        r = r_outer if i % 2 == 0 else r_inner
        points.append((cx + r * math.cos(angle), cy + r * math.sin(angle)))
    draw.polygon(points, fill=color)

draw_4star(draw, s(82), s(33.5), r_outer=s(8.5), r_inner=s(3), color=WHITE)

# ── Small dot sparkles ────────────────────────────────────────────────────────
def dot(draw, cx, cy, r, color):
    draw.ellipse([cx - r, cy - r, cx + r, cy + r], fill=color)

dot(draw, s(27), s(35), int(2.5 * scale), WHITE)   # upper-left
dot(draw, s(22), s(72), int(1.8 * scale), WHITE)   # lower-left
dot(draw, s(90), s(52), int(1.5 * scale), WHITE)   # far right

# ── Save ─────────────────────────────────────────────────────────────────────
out_dir = os.path.join(os.path.dirname(__file__), "..", "store_assets")
os.makedirs(out_dir, exist_ok=True)
out_path = os.path.join(out_dir, "icon_512.png")

# Convert to RGB for final PNG (Play Store requires no alpha on the icon)
final = Image.new("RGB", (SIZE, SIZE), (255, 107, 107))
final.paste(img, mask=img.split()[3])
final.save(out_path, "PNG")

print(f"Icon saved to: {os.path.abspath(out_path)}")
