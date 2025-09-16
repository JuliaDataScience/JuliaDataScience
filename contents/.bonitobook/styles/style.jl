# Julia Data Science Book Styling
# Theme control: true = light, false = dark, nothing = auto (browser preference)
light_theme = nothing

# Define reusable variables for dimensions and transitions
editor_width = "90ch"
max_height_large = "80vh"
max_height_medium = "60vh"
border_radius_small = "3px"
border_radius_large = "5px"
transition_fast = "0.1s ease-out"
transition_slow = "0.2s ease-in"
font_family_clean = "system-ui, -apple-system, 'Segoe UI', 'Roboto', 'Ubuntu', 'Cantarell', 'Noto Sans', sans-serif"

# Set Makie theme and Monaco editor based on system preference
# Define theme media queries based on light_theme setting
light_media_query = if light_theme === nothing
    BonitoBook.monaco_theme!("default")  # Auto-detect in JS
    Makie.set_theme!(size = (650, 450))
    "@media (prefers-color-scheme: light), (prefers-color-scheme: no-preference)"
elseif light_theme === true
    BonitoBook.monaco_theme!("vs")  # Force light Monaco theme
    Makie.set_theme!(size = (650, 450))
    "@media screen"  # Apply directly to root
else
    Makie.set_theme!(Makie.theme_dark(), size = (650, 450))
    BonitoBook.monaco_theme!("vs-dark")  # Force dark Monaco theme
    "@media (max-width: 0px)"  # Never apply
end

dark_media_query = if light_theme === nothing
    "@media (prefers-color-scheme: dark)"
elseif light_theme === false
    "@media screen" # Apply directly to root
else
    "@media (max-width: 0px)"  # Never apply
end

on(@Book().theme_preference) do browser_preference
    theme = light_theme === nothing ? browser_preference : (light_theme ? "light" : "dark")
    if theme == "light"
        Makie.set_theme!(size = (650, 450))
    else
        Makie.set_theme!(Makie.theme_dark(), size = (650, 450))
    end
end

Styles(
    CSS(
        "body",
        "margin" => "0px",
    ),

    # Light theme colors
    CSS(
        light_media_query,
        CSS(
            ":root",
            "--bg-primary" => "#ffffff",
            "--text-primary" => "#333333",
            "--text-secondary" => "#666666",
            "--text-muted" => "#999999",
            "--border-primary" => "#e1e4e8",
            "--border-secondary" => "#d1d5da",
            "--shadow-soft" => "0 1px 3px rgba(0, 0, 0, 0.1)",
            "--shadow-button" => "0 1px 2px rgba(0, 0, 0, 0.1)",
            "--shadow-inset" => "inset 1px 1px 2px rgba(0, 0, 0, 0.1)",
            "--hover-bg" => "#f6f8fa",
            "--menu-hover-bg" => "#f0f0f0",
            "--accent-blue" => "#0366d6",
            "--accent-hover" => "#0366d6",
            "--animation-glow" => "0 0 10px rgba(3, 102, 214, 0.3)",
            "--icon-color" => "#666666",
            "--icon-hover-color" => "#333333",
            "--icon-filter" => "none",
            "--icon-hover-filter" => "brightness(0.8)",
            "--scrollbar-track" => "#f8f9fa",
            "--scrollbar-thumb" => "#c1c8ce",
            "--scrollbar-thumb-hover" => "#a1a7aa",
            # Simplified book colors - neutral theme
            "--book-bg" => "#f8f9fa",
            "--toc-hover" => "#f0f0f0",
            "--code-bg" => "#f6f8fa",
            "--code-border" => "#e1e4e8",
        )
    ),

    # Dark theme colors
    CSS(
        dark_media_query,
        CSS(
            ":root",
            "--bg-primary" => "#0d1117",
            "--text-primary" => "#e6edf3",
            "--text-secondary" => "#8d96a0",
            "--text-muted" => "#656d76",
            "--border-primary" => "#30363d",
            "--border-secondary" => "#21262d",
            "--shadow-soft" => "0 1px 3px rgba(0, 0, 0, 0.3)",
            "--shadow-button" => "0 1px 2px rgba(0, 0, 0, 0.2)",
            "--shadow-inset" => "inset 1px 1px 2px rgba(0, 0, 0, 0.4)",
            "--hover-bg" => "#21262d",
            "--menu-hover-bg" => "#161b22",
            "--accent-blue" => "#58a6ff",
            "--accent-hover" => "#58a6ff",
            "--animation-glow" => "0 0 10px rgba(88, 166, 255, 0.3)",
            "--icon-color" => "#8d96a0",
            "--icon-hover-color" => "#e6edf3",
            "--icon-filter" => "none",
            "--icon-hover-filter" => "brightness(1.2)",
            "--scrollbar-track" => "#21262d",
            "--scrollbar-thumb" => "#484f58",
            "--scrollbar-thumb-hover" => "#656d76",
            # Simplified book colors - dark neutral theme
            "--book-bg" => "#161b22",
            "--toc-hover" => "#21262d",
            "--code-bg" => "#161b22",
            "--code-border" => "#30363d",
        )
    ),

    CSS(
        "@media print",
        # Preserve all colors and styles
        CSS(
            "*",
            "-webkit-print-color-adjust" => "exact !important",
            "print-color-adjust" => "exact !important",
            "color-adjust" => "exact !important",
            "filter" => "none !important"
        ),
        CSS(
            "@page",
            "margin" => "0.5in",
            "size" => "A4"
        ),
        CSS(
            "@page :first",
            "margin-top" => "0.3in"
        ),

        # Hide non-essential elements, but keep the content path visible
        CSS(
            ".book-main-menu, .cell-logging, .sidebar-main-container, .sidebar-tabs, .sidebar-content-container, .book-bottom-panel, .new-cell-menu, .hover-buttons",
            "display" => "none !important"
        ),
        # Ensure main structure is visible and flows properly, eliminating empty space
        CSS(
            ".book-wrapper, .book-document, .book-main-content, .book-content",
            "display" => "block !important",
            "height" => "auto !important",
            "max-height" => "none !important",
            "overflow" => "visible !important",
            "position" => "static !important",
            "flex" => "none !important",
            "margin" => "0 !important",
            "padding" => "0 !important"
        ),

    ),

    # Export mode styles - hide interactive elements when BONITO_EXPORT_MODE is true
    CSS(
        "body.bonito-export-mode .hover-buttons, body.bonito-export-mode .cell-menu-proximity-area",
        "display" => "none !important"
    ),

    # Global styling
    CSS(
        "html",
        "background-color" => "var(--bg-primary)",
        "color" => "var(--text-primary)"
    ),
    CSS(
        "body",
        "background-color" => "var(--bg-primary)",
        "color" => "var(--text-primary)"
    ),
    CSS(
        "*",
        "color" => "inherit"
    ),
    # Fix for Markdown list
    CSS("li p", "display" => "inline"),
    CSS(
        "pre",
        "margin-block" => "5px 0px",
        "font-family" => "'Consolas', 'Monaco', 'Courier New', monospace"
    ),
    CSS(
        "mjx-container[jax='CHTML'][display='true']",
        "display" => "inline"
    ),

    # Monaco Widgets (find/command palette)
    CSS(
        ".quick-input-widget",
        "position" => "fixed !important",
        "top" => "10px !important",
        "background-color" => "var(--bg-primary)",
        "color" => "var(--text-primary)"
    ),
    CSS(
        ".find-widget",
        "position" => "fixed !important",
        "top" => "10px !important",
        "background-color" => "var(--bg-primary)",
        "color" => "var(--text-primary)"
    ),
    CSS(
        ".monaco-list",
        "max-height" => max_height_medium,
        "overflow-y" => "auto !important",
        "background-color" => "var(--bg-primary)",
        "color" => "var(--text-primary)"
    ),

    # Julia Data Science Book Specific Styles
    CSS(
        ".julia-data-science-book",
        "font-family" => font_family_clean,
        "line-height" => "1.6",
        "color" => "var(--text-primary)",
        "max-width" => "none",
        "margin" => "0",
        "display" => "flex",
        "min-height" => "100vh",
        "background-color" => "var(--bg-primary)"
    ),

    CSS(
        ".book-sidebar",
        "width" => "280px",
        "background" => "var(--bg-primary)",
        "border-right" => "1px solid var(--border-primary)",
        "padding" => "24px 20px",
        "position" => "fixed",
        "height" => "100vh",
        "overflow-y" => "auto",
        "top" => "0",
        "left" => "0",
        "z-index" => "100",
        "box-sizing" => "border-box"
    ),

    CSS(
        ".book-content",
        "flex" => "1",
        "padding" => "40px 60px",
        "margin-left" => "280px",
        "max-width" => "calc(100% - 280px)",
        "background-color" => "var(--bg-primary)",
        "box-sizing" => "border-box"
    ),

    CSS(
        ".book-header",
        "margin-bottom" => "40px",
        "padding-bottom" => "20px",
        "border-bottom" => "1px solid var(--border-primary)"
    ),

    CSS(
        ".book-title",
        "font-size" => "1.5em",
        "color" => "var(--text-primary)",
        "margin-bottom" => "8px",
        "font-weight" => "600",
        "letter-spacing" => "-0.02em"
    ),

    CSS(
        ".book-subtitle",
        "font-size" => "0.9em",
        "color" => "var(--text-secondary)",
        "font-weight" => "normal",
        "margin" => "0"
    ),

    CSS(
        ".toc-title",
        "color" => "var(--text-primary)",
        "font-size" => "1.1em",
        "margin-bottom" => "20px",
        "font-weight" => "600",
        "letter-spacing" => "-0.01em"
    ),

    CSS(
        ".toc-list",
        "list-style" => "none",
        "padding" => "0",
        "margin" => "0"
    ),

    CSS(
        ".toc-item",
        "margin-bottom" => "2px"
    ),

    CSS(
        ".toc-link",
        "display" => "block",
        "padding" => "6px 12px",
        "color" => "var(--text-secondary)",
        "text-decoration" => "none",
        "border-radius" => "4px",
        "transition" => "all 0.15s ease",
        "font-size" => "0.9em",
        "line-height" => "1.4"
    ),

    CSS(
        ".toc-link:hover",
        "background-color" => "var(--toc-hover)",
        "color" => "var(--text-primary)",
        "text-decoration" => "none"
    ),

    CSS(
        ".toc-link.active",
        "background-color" => "var(--toc-hover)",
        "color" => "var(--text-primary)",
        "font-weight" => "500"
    ),

    # Chapter content styling
    CSS(
        ".julia-data-science-chapter",
        "max-width" => "800px",
        "font-size" => "16px",
        "line-height" => "1.6"
    ),

    CSS(
        ".julia-data-science-chapter h1",
        "color" => "var(--text-primary)",
        "font-size" => "2.2em",
        "margin-bottom" => "24px",
        "margin-top" => "40px",
        "font-weight" => "700",
        "letter-spacing" => "-0.02em",
        "line-height" => "1.2"
    ),

    CSS(
        ".julia-data-science-chapter h2",
        "color" => "var(--text-primary)",
        "font-size" => "1.6em",
        "margin-top" => "40px",
        "margin-bottom" => "16px",
        "font-weight" => "600",
        "letter-spacing" => "-0.01em",
        "line-height" => "1.3"
    ),

    CSS(
        ".julia-data-science-chapter h3",
        "color" => "var(--text-primary)",
        "font-size" => "1.3em",
        "margin-top" => "32px",
        "margin-bottom" => "12px",
        "font-weight" => "600"
    ),

    CSS(
        ".julia-data-science-chapter h4",
        "color" => "var(--text-primary)",
        "font-size" => "1.1em",
        "margin-top" => "24px",
        "margin-bottom" => "8px",
        "font-weight" => "600"
    ),

    CSS(
        ".julia-data-science-chapter p",
        "margin-bottom" => "16px",
        "color" => "var(--text-primary)"
    ),

    CSS(
        ".julia-data-science-chapter ul, .julia-data-science-chapter ol",
        "margin-bottom" => "16px",
        "padding-left" => "24px"
    ),

    CSS(
        ".julia-data-science-chapter li",
        "margin-bottom" => "4px",
        "color" => "var(--text-primary)"
    ),

    # Code styling - clean design
    CSS(
        ".julia-data-science-chapter pre",
        "background" => "var(--code-bg)",
        "border" => "1px solid var(--code-border)",
        "border-radius" => "6px",
        "padding" => "16px",
        "overflow-x" => "auto",
        "font-size" => "14px",
        "font-family" => "'JuliaMono', 'SF Mono', 'Monaco', 'Consolas', monospace",
        "line-height" => "1.45",
        "margin" => "16px 0"
    ),

    CSS(
        ".julia-data-science-chapter code",
        "background" => "var(--code-bg)",
        "padding" => "2px 6px",
        "border-radius" => "3px",
        "font-size" => "14px",
        "font-family" => "'JuliaMono', 'SF Mono', 'Monaco', 'Consolas', monospace",
        "color" => "var(--text-primary)",
        "border" => "1px solid var(--code-border)"
    ),

    CSS(
        ".julia-data-science-chapter pre code",
        "background" => "transparent",
        "padding" => "0",
        "border" => "none",
        "border-radius" => "0"
    ),

    # Mobile responsiveness
    CSS(
        "@media (max-width: 768px)",
        CSS(
            ".julia-data-science-book",
            "flex-direction" => "column"
        ),
        CSS(
            ".book-sidebar",
            "position" => "static",
            "width" => "100%",
            "height" => "auto",
            "border-right" => "none",
            "border-bottom" => "1px solid var(--border-primary)"
        ),
        CSS(
            ".book-content",
            "margin-left" => "0",
            "max-width" => "100%",
            "padding" => "24px 20px"
        ),
        CSS(
            ".julia-data-science-chapter",
            "max-width" => "none"
        )
    ),

    # Scrollbar styling
    CSS(
        "::-webkit-scrollbar",
        "width" => "12px"
    ),
    CSS(
        "::-webkit-scrollbar-track",
        "background" => "var(--scrollbar-track)"
    ),
    CSS(
        "::-webkit-scrollbar-thumb",
        "background-color" => "var(--scrollbar-thumb)",
        "border-radius" => "6px",
        "border" => "2px solid var(--scrollbar-track)"
    ),
    CSS(
        "::-webkit-scrollbar-thumb:hover",
        "background-color" => "var(--scrollbar-thumb-hover)"
    ),
    # Firefox scrollbar
    CSS(
        "*",
        "scrollbar-width" => "thin",
        "scrollbar-color" => "var(--scrollbar-thumb) var(--scrollbar-track)"
    ),

    # Editor containers with Julia branding
    CSS(
        ".cell-editor-container",
        "width" => editor_width,
        "min-width" => "400px",
        "max-width" => "95vw",
        "position" => "relative",
        "background-color" => "var(--bg-primary)",
        "color" => "var(--text-primary)"
    ),

    CSS(
        ".cell-menu-proximity-area",
        "position" => "absolute",
        "top" => "-20px",
        "left" => "0px",
        "height" => "20px",
        "width" => "100%",
        "background-color" => "transparent",
        "pointer-events" => "auto",
        "z-index" => "-1"
    ),
    # Special styling for collapsed editors - use container-level class
    CSS(
        ".cell-editor-container.editor-collapsed .cell-menu-proximity-area",
        "position" => "absolute",
        "top" => "0px",
        "left" => "0px",
        "height" => "6px",
        "width" => "100%",
        "background-color" => "transparent",
        "border" => "none",
        "border-radius" => "2px",
        "pointer-events" => "auto",
        "z-index" => "1",
        "transition" => "all 0.2s ease",
        "opacity" => "0"
    ),
    # Add visual feedback on hover for collapsed state
    CSS(
        ".cell-editor-container.editor-collapsed .cell-menu-proximity-area:hover",
        "background-color" => "var(--hover-bg)",
        "border-style" => "solid",
        "opacity" => "1",
        "transform" => "scaleY(1.2)"
    ),
    CSS(
        ".cell-editor",
        "width" => editor_width,
        "max-width" => "95vw",
        "position" => "relative",
        "padding" => "8px",
        "border-radius" => border_radius_small,
        "border" => "1px solid var(--border-primary)",
        "background-color" => "var(--bg-primary)",
        "color" => "var(--text-primary)"
    ),
    CSS(
        ".monaco-editor-div",
        "background-color" => "var(--bg-primary)",
        "padding" => "0px",
        "margin" => "0px",
        "color" => "var(--text-primary)"
    ),

    # Logging output
    CSS(
        ".cell-logging",
        "min-height" => "0px",
        "max-height" => "500px",
        "max-width" => editor_width,
        "overflow-y" => "auto",
        "height" => "fit-content",
        "margin" => "0",
        "padding" => "0",
        "background-color" => "var(--bg-primary)",
        "color" => "var(--text-primary)",
        "white-space" => "pre-wrap",
        "word-wrap" => "break-word",
        "height" => "auto",
        "flex" => "0 0 auto"
    ),

    CSS(
        ".logging-widget",
        "height" => "100%",
        "width" => "100%",
        "overflow-y" => "auto",
        "margin" => "0",
        "padding" => "8px",
        "background-color" => "var(--bg-primary)",
        "color" => "var(--text-primary)",
        "font-family" => "monospace",
        "font-size" => "12px",
        "line-height" => "1.4",
        "white-space" => "pre-wrap",
        "word-wrap" => "break-word"
    ),
    CSS(
        ".logging-widget pre",
        "margin" => "0",
        "padding" => "0",
        "background-color" => "transparent",
        "color" => "inherit",
        "font-family" => "inherit",
        "font-size" => "inherit",
        "line-height" => "inherit",
        "white-space" => "pre-wrap",
        "word-wrap" => "break-word"
    ),

    # Cell output styling
    CSS(
        ".cell-output",
        "width" => "100%",
        "margin" => "5px",
        "max-height" => "1000px",
        "overflow-y" => "auto",
        "overflow-x" => "visible",
        "background-color" => "var(--bg-primary)",
        "color" => "var(--text-primary)"
    ),
    # Remove max-height for markdown outputs
    CSS(
        ".cell-output-markdown.cell-output",
        "max-height" => "none",
        "overflow-y" => "visible"
    ),
    # Visibility controls
    CSS(".hide-vertical", "display" => "none"),
    CSS(".show-vertical", "display" => "block"),
    CSS(
        ".hide-horizontal",
        "height" => "6px",
        "overflow" => "hidden",
        "position" => "relative"
    ),
    CSS(
        ".show-horizontal",
        "display" => "block",
    ),

    # Hover buttons with Julia colors
    CSS(
        ".hover-buttons",
        "position" => "absolute",
        "right" => "-10px",
        "top" => "-23px",
        "z-index" => 50,
        "opacity" => 0.0,
        "pointer-events" => "auto",
    ),

    # Small buttons with Julia theme
    CSS(
        ".small-button",
        "background-color" => "var(--bg-primary)",
        "border" => "none",
        "border-radius" => "8px",
        "color" => "var(--text-secondary)",
        "cursor" => "pointer",
        "box-shadow" => "var(--shadow-button)",
        "transition" => "background-color 0.2s",
        "padding" => "8px",
        "margin-right" => "5px",
        "display" => "inline-flex",
        "align-items" => "center",
        "justify-content" => "center"
    ),

    CSS(
        ".small-button:hover",
        "background-color" => "var(--hover-bg)",
    ),

    # Loading animation
    CSS(
        ".loading-cell",
        "box-shadow" => "var(--shadow-soft)",
        "animation" => "shadow-pulse 1.5s ease-in-out infinite",
    ),
    CSS(
        "@keyframes shadow-pulse",
        CSS("0%", "box-shadow" => "var(--shadow-soft)"),
        CSS("50%", "box-shadow" => "var(--animation-glow)"),
        CSS("100%", "box-shadow" => "var(--shadow-soft)")
    ),

    # Language icon
    CSS(
        ".small-language-icon",
        "position" => "absolute",
        "bottom" => "4px",
        "right" => "8px",
        "opacity" => "0.8",
        "pointer-events" => "none",
        "color" => "var(--icon-color)",
        "filter" => "var(--icon-filter)"
    ),

    # Codicon system
    CSS(
        ".codicon",
        "display" => "inline-block",
        "text-decoration" => "none",
        "text-rendering" => "auto",
        "text-align" => "center",
        "text-transform" => "none",
        "-webkit-font-smoothing" => "antialiased",
        "-moz-osx-font-smoothing" => "grayscale",
        "user-select" => "none",
        "-webkit-user-select" => "none",
        "flex-shrink" => "0",
        "color" => "var(--icon-color)",
        "filter" => "var(--icon-filter)"
    ),
    CSS(
        ".codicon svg",
        "display" => "block",
        "fill" => "currentColor"
    ),
    CSS(
        ".codicon:hover",
        "color" => "var(--icon-hover-color)",
        "filter" => "var(--icon-hover-filter)"
    ),

    # Only apply filters to specific icon contexts, not general content
    CSS(
        ".small-button img:not([src*='python-logo']):not([src*='julia-logo']), .small-button svg",
        "filter" => "var(--icon-filter)"
    ),
    CSS(
        ".small-button:hover img:not([src*='python-logo']):not([src*='julia-logo']), .small-button:hover svg",
        "filter" => "var(--icon-hover-filter)"
    ),
    # Only apply filter to small icons in codicon system, not content SVGs
    CSS(
        ".codicon svg, .small-language-icon svg, .codicon img",
        "filter" => "var(--icon-filter)"
    ),

    # Colored icons - handle separately for dark theme
    CSS(
        dark_media_query,
        CSS(
            "img[src*='python-logo'], img[src*='julia-logo']",
            "filter" => "brightness(1.3) contrast(1.1)"
        )
    ),

    # Menu and Buttons
    CSS(
        ".small-menu-bar",
        "z-index" => "1001",
        "background-color" => "var(--bg-primary)",
        "border" => "1px solid var(--border-primary)",
        "border-radius" => "8px",
        "box-shadow" => "var(--shadow-soft)",
        "padding" => "6px",
        "display" => "flex",
        "gap" => "4px",
        "align-items" => "center"
    ),
    CSS(
        ".small-button.toggled",
        "color" => "var(--text-primary)",
        "border" => "none",
        "filter" => "grayscale(100%)",
        "opacity" => "0.5",
        "box-shadow" => "var(--shadow-inset)",
    ),
    CSS(
        ".toggle-button.active",
        "box-shadow" => "var(--shadow-inset)",
        "color" => "var(--text-primary)",
    ),
    CSS(
        ".small-button.inactive",
        "opacity" => "0.4",
        "cursor" => "not-allowed",
    ),
    CSS(
        ".small-button.inactive:hover",
        "background-color" => "var(--bg-primary)",
    ),

    CSS(
        ".file-tabs-container",
        "display" => "flex",
        "background-color" => "var(--bg-primary)",
        "border-bottom" => "1px solid var(--border-primary)",
        "overflow-x" => "auto",
        "flex-shrink" => "0",
    ),
    CSS(
        ".file-tab",
        "display" => "flex",
        "align-items" => "center",
        "padding" => "8px 4px",
        "border-bottom" => "2px solid transparent",
        "background-color" => "var(--bg-primary)",
        "color" => "var(--text-secondary)",
        "cursor" => "pointer",
        "transition" => "all 0.2s ease",
        "border-radius" => "6px 6px 0 0",
        "margin-right" => "2px",
        "user-select" => "none",
    ),
    CSS(
        ".file-tab:hover",
        "background-color" => "var(--hover-bg)",
        "color" => "var(--text-primary)",
    ),
    CSS(
        ".file-tab.active",
        "background-color" => "var(--bg-primary)",
        "color" => "var(--text-primary)",
        "border-bottom-color" => "var(--julia-purple)",
        "font-weight" => "500",
    ),
    CSS(
        ".file-tab-content",
        "display" => "flex",
        "align-items" => "center",
        "gap" => "6px",
    ),
    CSS(
        ".file-tab-name",
        "font-size" => "13px",
        "max-width" => "150px",
        "overflow" => "hidden",
        "text-overflow" => "ellipsis",
        "white-space" => "nowrap",
    ),
    CSS(
        ".file-tab-close",
        "display" => "flex",
        "align-items" => "center",
        "justify-content" => "center",
        "width" => "16px",
        "height" => "16px",
        "border-radius" => "50%",
        "background-color" => "transparent",
        "border" => "none",
        "color" => "var(--text-secondary)",
        "cursor" => "pointer",
        "font-size" => "12px",
        "line-height" => "1",
        "transition" => "all 0.2s ease",
    ),
    CSS(
        ".file-tab-close:hover",
        "background-color" => "var(--hover-bg)",
        "color" => "var(--text-primary)",
    ),
    CSS(
        ".file-tab-add",
        "display" => "flex",
        "align-items" => "center",
        "justify-content" => "center",
        "padding" => "8px 12px",
        "background-color" => "transparent",
        "border" => "none",
        "color" => "var(--text-secondary)",
        "cursor" => "pointer",
        "font-size" => "16px",
        "line-height" => "1",
        "transition" => "all 0.2s ease",
        "border-radius" => "6px",
    ),
    CSS(
        ".file-tab-add:hover",
        "background-color" => "var(--hover-bg)",
        "color" => "var(--text-primary)",
    ),

    CSS(
        ".file-editor",
        "padding" => "0px",
        "margin" => "0px",
        "width" => "100%",
        "min-width" => editor_width,
        "height" => "calc(100vh - 20px)",
        "background-color" => "var(--bg-primary)",
        "color" => "var(--text-primary)"
    ),

    CSS(
        ".sidebar-widget-content .monaco-editor-div.hide-horizontal",
        "display" => "block !important",
    ),
    # Utility classes
    CSS(".flex-row", "display" => "flex", "flex-direction" => "row"),
    CSS(".flex-column", "display" => "flex", "flex-direction" => "column"),
    CSS(".center-content", "justify-content" => "center", "align-items" => "center"),
    CSS(".inline-block", "display" => "inline-block"),
    CSS(".fit-content", "width" => "fit-content"),
    CSS(".max-width-90ch", "max-width" => "90ch"),
    CSS(".gap-10", "gap" => "10px"),
    CSS(".full-width", "width" => "100%"),

    # Focus states
    CSS(
        ".cell-editor.focused",
        "border-color" => "var(--accent-blue)",
        "box-shadow" => "0 0 0 2px rgba(3, 102, 214, 0.1)",
    ),
)
