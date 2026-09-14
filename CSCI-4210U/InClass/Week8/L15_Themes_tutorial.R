# =============================================================================
# L15: ggplot2 Themes
# =============================================================================
# In this session we explore how to control the NON-DATA appearance of plots.
# Everything that isn't your data (backgrounds, gridlines, axis labels, fonts,
# legend boxes, etc.) is controlled by ggplot2's "theme" system.
#
# By the end of this session you should be able to:
#   - Explain what a theme is and what it controls
#   - Apply built-in complete themes (theme_bw, theme_minimal, etc.)
#   - Customise individual theme elements using theme()
#   - Use the four element setter functions: element_text(), element_rect(),
#     element_line(), and element_blank()
#   - Customise axis, title, legend, panel, and facet elements
# =============================================================================

library(ggplot2)   # Load ggplot2 — all theme functions live here


# =============================================================================
# PART 1: What is a theme?
# =============================================================================
# A theme controls all the VISUAL elements of a plot that are NOT related to
# your data. Think of the data as the "content" and the theme as the "style".
#
# Examples of what a theme controls:
#   - Background colour of the plot panel
#   - Colour, size, and style of gridlines
#   - Font, size, and colour of axis labels and tick labels
#   - Appearance of the legend box and legend text
#   - Title, subtitle, and caption formatting
#
# Themes do NOT affect:
#   - Which geom is drawn (geom_point, geom_bar, etc.)
#   - Data mappings (aes())
#   - Scales and colour palettes used for DATA

# ── Sample data used throughout this session ──────────────────────────────────
# We use the built-in "mpg" dataset from ggplot2.
# It contains fuel economy data for 234 cars across 38 models (1999–2008).
# Key columns we'll use:
#   displ  — engine displacement in litres (continuous, x-axis)
#   hwy    — highway miles per gallon (continuous, y-axis)
#   class  — type of car: "compact", "suv", "pickup", etc. (7 categories, colour)
#   drv    — drive type: "f" (front), "r" (rear), "4" (4-wheel) (used in challenges)
#   year   — model year: 1999 or 2008 (used for faceting)

# Peek at the data:
head(mpg)           # First 6 rows
str(mpg)            # Column types
levels(factor(mpg$class))  # The 7 car classes

# Build a base scatter plot — we'll reuse "base" throughout the session
# displ (x) vs hwy (y), coloured by car class
base <- ggplot(mpg, aes(x = displ, y = hwy, colour = class)) +
  geom_point(size = 2) +                          # Slightly larger points
  labs(x = "Engine Displacement (L)",             # Meaningful x label
       y = "Highway MPG",                         # Meaningful y label
       colour = "Car Class")                      # Legend title

# Draw the plot with default theme (theme_grey)
base


# =============================================================================
# PART 2: Theme inheritance
# =============================================================================
# ggplot2 themes are HIERARCHICAL — settings inherit downward.
#
# For example:
#   - Setting "text" affects ALL text elements in the plot
#   - Setting "axis.text" overrides "text" for axis labels only
#   - Setting "axis.text.x" overrides "axis.text" for x-axis labels only
#
# This means you can make broad changes at the top level and fine-tune below.
#
# Hierarchy example:
#   text  →  axis.text  →  axis.text.x
#                        →  axis.text.y
#         →  legend.text
#         →  plot.title
#         ...and so on

# Changing "text" affects everything at once:
base + theme(text = element_text(colour = "blue"))
# Notice: axes, legend, title — all text goes blue

# Changing "axis.text" only affects tick labels (not the title):
base + theme(axis.text = element_text(colour = "red"))


# =============================================================================
# PART 3: Built-in complete themes
# =============================================================================
# ggplot2 ships with several ready-made "complete" themes. A complete theme
# sets ALL theme elements at once — it's the fastest way to change the
# overall look of a plot.

# ── theme_grey() ── (DEFAULT)
# Grey background with white gridlines. ggplot2's default since it makes
# the data stand out against a neutral background.
base + theme_grey()

# ── theme_bw() ──
# White background with grey gridlines. Clean look for publications.
base + theme_bw()

# ── theme_linedraw() ──
# White background with thin black lines for gridlines. High contrast.
base + theme_linedraw()

# ── theme_light() ──
# White background, light grey lines and axes. Focuses attention on data.
base + theme_light()

# ── theme_dark() ──
# Dark background. Useful for dashboards or screens with dark mode.
base + theme_dark()

# ── theme_minimal() ──
# No background, minimal gridlines. Very clean and modern look.
base + theme_minimal()

# ── theme_classic() ──
# Classic ggplot look: white background, no gridlines, axis lines visible.
# Great for scientific papers that avoid gridlines.
base + theme_classic()

# ── theme_void() ──
# COMPLETELY empty: no axes, no gridlines, no background. Useful for maps,
# network graphs, or when you want a completely blank canvas.
base + theme_void()

# ── theme_test() ──
# A testing theme to help see element boundaries (mainly for developers).
base + theme_test()

# TIP: All complete themes accept a "base_size" argument to scale text globally.
base + theme_bw(base_size = 20)     # All text 20% bigger (relative to default)
base + theme_minimal(base_size = 8) # Smaller, tighter text


# =============================================================================
# PART 4: Modifying individual elements with theme()
# =============================================================================
# Beyond complete themes, you can fine-tune ANY individual element using theme().
# Each element is set with one of four "setter" functions:
#
#   element_text()    — controls text elements (labels, titles, etc.)
#   element_rect()    — controls rectangle elements (backgrounds, borders)
#   element_line()    — controls line elements (gridlines, axis lines, ticks)
#   element_blank()   — removes an element entirely (sets it to nothing)
#
# General pattern:
#   base + theme(element.name = element_setter(arguments))

# ── 4a: element_text() ────────────────────────────────────────────────────────
# Used for: axis labels, tick labels, plot title, subtitle, caption,
#           legend title, legend text, strip text (in facets)
#
# Key arguments:
#   colour    — text colour (e.g. "blue", "#FF5733")
#   size      — font size in points
#   face      — "plain", "bold", "italic", "bold.italic"
#   family    — font family (e.g. "serif", "sans", "mono")
#   hjust     — horizontal justification (0 = left, 0.5 = centre, 1 = right)
#   vjust     — vertical justification (0 = bottom, 0.5 = middle, 1 = top)
#   angle     — rotation in degrees (e.g. 90 for vertical text)
#   lineheight — spacing between wrapped text lines
#   margin    — add space around the text using margin()
#   debug     — TRUE to draw a box showing text boundaries (useful for debugging)

# Example: style the plot title
base + theme(
  plot.title = element_text(
    colour = "red",           # Red title text
    size   = 20,              # 20pt font
    face   = "bold",          # Bold weight
    hjust  = 0.5             # Centre-align the title  # 0: left, 1: right
  )
) + ggtitle("My Custom Title")

# Example: rotate and colour x-axis tick labels
base + theme(
  axis.text.x = element_text(
    angle  = 45,              # Rotate labels 45 degrees - clockwise, negative value: counter clockwise 
    hjust  = 1,               # Right-align so they don't overlap ticks
    colour = "steelblue",     # Blue colour
    size   = 12               # Slightly larger
  )
)

# ── rel(): relative sizing ────────────────────────────────────────────────────
# rel() lets you specify size RELATIVE to the base font size.
# This is better than hardcoding pixel sizes because it scales with base_size.

base + theme(
  axis.text  = element_text(size = rel(0.8)),   # 80% of base size
  plot.title = element_text(size = rel(1.5))    # 150% of base size
) + ggtitle("Relatively sized title")


# ── 4b: element_rect() ────────────────────────────────────────────────────────
# Used for: plot background, panel background, legend background, strip backgrounds
#
# Key arguments:
#   fill      — fill/interior colour
#   colour    — border/outline colour
#   size      — border line width
#   linetype  — border line type (1 = solid, 2 = dashed, etc.)

# Example: give the legend a yellow background with a grey border
base + theme(
  legend.background = element_rect(
    fill    = "lightyellow",  # Yellow fill inside the legend box
    colour  = "grey50",       # Medium grey border
    size    = 1               # Border width
  )
)

# Example: change the plot background (the area outside the panel)
base + theme(
  plot.background = element_rect(
    fill   = "lightblue",     # Light blue outside the panel
    colour = "navy"           # Dark navy border around the whole plot
  )
)


# ── 4c: element_line() ────────────────────────────────────────────────────────
# Used for: axis lines, axis ticks, gridlines
#
# Key arguments:
#   colour    — line colour
#   size      — line thickness
#   linetype  — 1=solid, 2=dashed, 3=dotted, 4=dotdash, 5=longdash, 6=twodash

# Example: change major gridline appearance
base + theme(
  panel.grid.major = element_line(
    colour    = "blue",       # Blue major gridlines
    linewidth = 1.5           # Thicker lines
  ),
  panel.grid.minor = element_line(
    colour = "red"            # Red minor gridlines
  )
)


# ── 4d: element_blank() ───────────────────────────────────────────────────────
# Used to REMOVE an element entirely. It takes no arguments.

# Remove the major gridlines entirely:
base + theme(panel.grid.major = element_blank())

# Remove ALL gridlines:
base + theme(
  panel.grid.major = element_blank(),
  panel.grid.minor = element_blank()
)

# Remove the legend entirely:
base + theme(legend.position = "none") #bad practice 


# =============================================================================
# PART 5: Axis elements
# =============================================================================
# The axis-related elements you can customise inside theme():
#
#   axis.title        — both axis titles (uses element_text)
#   axis.title.x      — x-axis title only
#   axis.title.y      — y-axis title only
#   axis.text         — both sets of tick labels
#   axis.text.x       — x-axis tick labels
#   axis.text.y       — y-axis tick labels
#   axis.ticks        — the small tick marks (uses element_line)
#   axis.ticks.length — length of ticks (uses unit())
#   axis.line         — axis lines (uses element_line)
#   axis.line.x       — x-axis line only
#   axis.line.y       — y-axis line only

# Our "base" already has meaningful axis labels from labs() above.
# We can override them or style them with theme():

# Style both axis titles the same way:
base + theme(
  axis.title = element_text(size = 16, colour = "darkgreen", face = "bold")
)

# Style each axis title independently:
base + theme(
  axis.title.x = element_text(size = 14, colour = "darkorange"),  # X title orange
  axis.title.y = element_text(size = 14, colour = "steelblue")    # Y title blue
)

# Remove axis titles (theme controls formatting — use labs(x=NULL) to clear text):
base + theme(
  axis.title = element_blank()   # No axis titles at all
)

# Style the tick labels (numbers along each axis):
base + theme(
  axis.text.x = element_text(size = 15, face = "bold", colour = "firebrick"),
  axis.text.y = element_text(size = 15, face = "bold", colour = "cornflowerblue")
)

# Style the tick marks themselves:
base + theme(
  axis.ticks = element_line(colour = "red", linewidth = 2)   # Thick red ticks
)

# Add visible axis lines (useful with theme_classic style):
base + theme(
  panel.background = element_blank(),              # Remove grey panel background
  panel.grid.major = element_blank(),              # Remove major gridlines
  panel.grid.minor = element_blank(),              # Remove minor gridlines
  axis.line        = element_line(colour = "black") # Add solid black axis lines
)


# =============================================================================
# PART 6: Plot title/subtitle/caption/tag elements
# =============================================================================
# These elements control the text AROUND the plot itself:
#
#   plot.title    — main title (added with ggtitle() or labs(title = ...))
#   plot.subtitle — subtitle below the title
#   plot.caption  — caption below the plot (often used for data sources)
#   plot.tag      — a label for multi-panel figures (e.g. "A", "B")

base + labs(
  title    = "My Plot Title",
  subtitle = "A subtitle with extra info",
  caption  = "Source: My data, 2026",
  tag      = "A"                          # Panel label (e.g. for multi-panel figs)
) + theme(
  plot.title    = element_text(size = 20, face = "italic", vjust = 0), #try -10,10
  # vjust moves title vertically — negative values push it down into the plot
  plot.subtitle = element_text(size = 14, colour = "grey40"),
  plot.caption  = element_text(size = 10, hjust = 0),   # Left-align caption
  plot.tag      = element_text(face = "bold", size = 14)
)


# =============================================================================
# CODING CHALLENGE 1
# =============================================================================
# Goal: Recreate a plot with these specific theme settings:
#   - Blue major gridlines, 1.5 linewidth
#   - Red minor gridlines
#   - x-axis text: size 15, bold, firebrick colour
#   - y-axis text: size 15, bold, cornflowerblue colour
#   - Italic plot title, size 20, vjust = -10
#
# Try it yourself first! Solution is at the end of the file.

# YOUR CODE HERE:
# base + theme(...)

base + labs(
  title = "I'm a title."
) + theme(
  panel.grid.major = element_line(
    colour = "blue",
    linewidth = 1.5
  ),
  panel.grid.minor = element_line(
    colour = "red"
  ),
  axis.text.x = element_text(size = 15, face = "bold", colour = "firebrick"),
  axis.text.y = element_text(size = 15, face = "bold", colour = "cornflowerblue"),
  plot.title = element_text(size = 20, face = "italic", vjust = -10)
)


# =============================================================================
# PART 7: Legend elements (styling)
# =============================================================================
# Legend-related theme elements:
#
#   legend.background    — the box behind the legend (element_rect)
#   legend.key           — box behind each legend key/symbol (element_rect)
#   legend.key.size      — size of each key (unit())
#   legend.key.height    — height of each key (unit())
#   legend.key.width     — width of each key (unit())
#   legend.margin        — space between legend and plot (unit())
#   legend.text          — label text next to each key (element_text)
#   legend.text.align    — 0 = right-align, 1 = left-align
#   legend.title         — legend title text (element_text)
#   legend.title.align   — 0 = right-align, 1 = left-align

# "base" already maps colour = class, so the legend is already there.
# Style the legend background (the overall box around the legend):
base + theme(
  legend.background = element_rect(
    fill   = "lemonchiffon",   # Light yellow background
    colour = "grey50",         # Grey border around the legend
    size   = 1                 # Border width
  )
)

# Style the key boxes (the small boxes next to each label):
base + theme(
  legend.key        = element_rect(color = "grey50"),    # Grey border on each key
  legend.key.width  = unit(0.9, "cm"),                   # Make keys wider
  legend.key.height = unit(0.75, "cm")                   # Make keys taller
)

# Style legend text and title:
base + theme(
  legend.text  = element_text(size = 15, face = "italic"),                    # Larger label text
  legend.title = element_text(size = 15, face = "bold")      # Bold, larger title
)

base + theme(
  legend.text  = element_text(size = 15),                    # Larger label text
  legend.title = element_text(size = 15, face = "bold.italic")      # Bold, larger title
)


# =============================================================================
# PART 8: Legend position and layout
# =============================================================================
# Four theme properties control WHERE the legend sits relative to the plot:
#
#   legend.position      — where the legend goes in/around the plot
#   legend.justification — which part of the legend box aligns to the position
#   legend.direction     — "horizontal" or "vertical" layout of keys
#   legend.box           — arrangement of MULTIPLE legends 

# ── legend.position ────────────────────────────────────────────────────────────
# String options: "right" (default), "left", "top", "bottom", "none"

base + theme(legend.position = "right")    # DEFAULT — legend to the right
base + theme(legend.position = "bottom")   # Move legend below the plot
base + theme(legend.position = "left")     # Move legend to the left
base + theme(legend.position = "top")      # Move legend above the plot
base + theme(legend.position = "none")     # REMOVE the legend entirely

# Numeric coordinate pair: c(x, y) where (0,0) is bottom-left, (1,1) is top-right
# This places the legend INSIDE the plot panel.
base + theme(legend.position = c(0, 0))    # Bottom-left corner of the panel
base + theme(legend.position = c(1, 0))    # Bottom-right corner of the panel
base + theme(legend.position = c(0, 1))    # Top-left corner of the panel
base + theme(legend.position = c(0.2, 0.9)) # 20% from left, 90% from bottom

# ── legend.justification ──────────────────────────────────────────────────────
# Controls WHICH PART of the legend box aligns to the position coordinate.
# Default: c(0.5, 0.5) — legend is centred on the position point.
# c(0, 0) — bottom-left corner of legend at the position point
# c(1, 1) — top-right corner of legend at the position point

# Place the position at plot centre, align legend's bottom-left to that point:
base + theme(
  legend.justification = c(0, 0),           # Bottom-left corner of legend
  legend.position      = c(0.5, 0.5)        # In the middle of the plot
)

# Place the position at plot centre, align legend's bottom-right there:
base + theme(
  legend.justification = c(1, 0),           # Bottom-right corner of legend
  legend.position      = c(0.5, 0.5)
)

# Corner example — anchor the legend's top-right corner to the bottom-left of the plot:
base + theme(
  legend.justification = c(1, 0),
  legend.position      = c(0, 0)
)

# ── legend.direction ──────────────────────────────────────────────────────────
# Controls whether keys are arranged in a column or a row.
# Default: vertical for left/right, horizontal for top/bottom.

base + theme(legend.direction = "horizontal")  # Keys side by side

base + theme(legend.direction = "vertical")    # Keys stacked (default for side legends)

# ── legend.box ────────────────────────────────────────────────────────────────
# Controls the arrangement when there are MULTIPLE legends.
# Options: "horizontal" (legends side by side) or "vertical" (legends stacked).


# =============================================================================
# CODING CHALLENGE 2
# =============================================================================
# Goal: Style the legend AND rename the drive-type labels to human-readable text.
# Use this plot as your starting point:
#   base_drv <- ggplot(mpg, aes(displ, hwy, colour = drv)) + geom_point(size = 2)
#
# Target legend styling:
#   - Legend title: "Drive Type" (bold, size 15)
#   - Legend labels: rename "4" → "4-wheel", "f" → "Front-wheel", "r" → "Rear-wheel"
#   - Legend background: lemonchiffon fill, grey50 border, size 1
#   - Legend key size: 30 points
#   - Legend text size: 13
#   - Hint: use scale_color_discrete() to rename the labels!
#
# Try it yourself! Solution at the end of the file.

base_drv <- ggplot(mpg, aes(displ, hwy, colour = drv)) +
  geom_point(size = 2) +
  labs(x = "Engine Displacement (L)", y = "Highway MPG")

# YOUR CODE HERE:
# base_drv + theme(...) + scale_color_discrete(...)

base_drv + theme(
  legend.title = element_text(size = 15, face = "bold"),
  legend.background = element_rect(fill = "lemonchiffon", colour = "grey50", size = 1),
  legend.key.size = unit(30, "pt"),
  legend.text = element_text(size = 13)
) + scale_colour_discrete(labels = c("4-wheel", "Front-wheel", "Rear-wheel")
)

# =============================================================================
# PART 9: Panel elements (background and gridlines)
# =============================================================================
# Panel elements control the plotting area itself (where your data lives):
#
#   panel.background      — fill behind data (element_rect)
#   panel.border          — border drawn ON TOP of data (element_rect)
#   panel.grid.major      — major gridlines (element_line)
#   panel.grid.major.x    — vertical major gridlines only
#   panel.grid.major.y    — horizontal major gridlines only
#   panel.grid.minor      — minor gridlines (element_line)
#   panel.grid.minor.x    — vertical minor gridlines only
#   panel.grid.minor.y    — horizontal minor gridlines only
#   aspect.ratio          — force a specific width:height ratio (numeric)

# Panel background (sits UNDER the data):
base + theme(
  panel.background = element_rect(
    colour   = "red",         # Red border/outline around the panel
    linetype = 2,             # Dashed border style
    fill     = "white"        # White fill (instead of default grey)
  )
)

# Customise gridlines:
base + theme(
  panel.grid.major   = element_line(colour = "steelblue", linewidth = 0.8),
  panel.grid.minor   = element_blank(),     # Remove minor gridlines entirely
  panel.grid.major.x = element_blank()      # Remove vertical major gridlines
)

# Force a square aspect ratio:
base + theme(aspect.ratio = 1)             # Width == Height (square panel)
base + theme(aspect.ratio = 0.5)           # Width is twice the height


# =============================================================================
# PART 10: Facet strip elements
# =============================================================================
# When using facet_wrap() or facet_grid(), each panel has a STRIP label.
# These facet-related theme elements control that area:
#
#   strip.background    — background box of the strip label (element_rect)
#   strip.text          — text in strips, both axes (element_text)
#   strip.text.x        — horizontal strip text (top of each panel)
#   strip.text.y        — vertical strip text (right of each panel)
#   panel.spacing       — space between facet panels (unit())
#   panel.spacing.x     — horizontal spacing between panels
#   panel.spacing.y     — vertical spacing between panels

# Create a FACETED base plot using the mpg dataset.
# We facet by "drv" (drive type: f = front, r = rear, 4 = 4-wheel).
# Each panel shows displacement vs highway MPG for one drive type.

base_f <- ggplot(mpg, aes(x = displ, y = hwy, colour = class)) +
  geom_point(size = 2) +
  facet_wrap(~drv,
             labeller = labeller(drv = c("4" = "4-wheel drive",
                                         "f" = "Front-wheel drive",
                                         "r" = "Rear-wheel drive"))) +
  labs(x = "Engine Displacement (L)", y = "Highway MPG", colour = "Car Class")

base_f                           # View the default faceted plot

# Increase spacing between panels:
base_f + theme(panel.spacing = unit(0.5, "in"))   # Half-inch gap between panels

# Style the facet strip label background and text:
base_f + theme(
  strip.background = element_rect(
    fill   = "grey20",       # Dark grey background for the strip label
    color  = "grey80",       # Light grey border around the strip
    size   = 1
  ),
  strip.text = element_text(colour = "white")   # White text on dark background
)

# Style only horizontal strip text (top labels):
base_f + theme(
  strip.text.x = element_text(size = 14, face = "bold", colour = "darkblue")
)



# =============================================================================
# KEY TAKEAWAYS
# =============================================================================
#
# 1. Themes control non-data appearance: backgrounds, gridlines, text, borders.
#
# 2. Built-in complete themes (theme_bw, theme_minimal, etc.) give you a quick
#    overall look — apply them with + theme_xxx().
#
# 3. Fine-tune individual elements with theme(element.name = setter(args)):
#      element_text()  — for any text element
#      element_rect()  — for any rectangle/background
#      element_line()  — for any line (gridlines, axes, ticks)
#      element_blank() — to REMOVE an element entirely
#
# 4. Theme inheritance means changes at a parent level (e.g. "text") cascade
#    down to children (e.g. "axis.text.x") unless children are set explicitly.
#
# 5. Legend layout is controlled by four properties:
#      legend.position, legend.justification, legend.direction, legend.box

# =============================================================================
# FURTHER READING
# =============================================================================
# - ggplot2 theme documentation:
#     https://ggplot2.tidyverse.org/reference/theme.html
# - ggplot2 complete themes:
#     https://ggplot2.tidyverse.org/reference/ggtheme.html
# - ggthemes package (extra themes like Economist, FiveThirtyEight, etc.):
#     https://yutannihilation.github.io/allYourFigureAreBelongToUs/ggthemes/
# - Hadley Wickham's ggplot2 book (free online):
#     https://ggplot2-book.org/themes
