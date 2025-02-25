#!/usr/bin/env python3

from rich.console import Console
from rich.panel import Panel
from rich.text import Text

console = Console()

# Manually create styled text
help_text = Text()
help_text.append("i3 Keybindings\n", style="bold bright_white")
help_text.append("─────────────────────────────────────────────────────────────────────────\n", style="bright_black")

help_text.append("Mod+Enter                                ", style="cyan")
help_text.append("- Open terminal\n", style="white")

help_text.append("Mod+d                                    ", style="cyan")
help_text.append("- Open application launcher (rofi)\n", style="white")

help_text.append("Mod+Shift+q                              ", style="cyan")
help_text.append("- Open power menu\n", style="white")

help_text.append("Mod+q                                    ", style="cyan")
help_text.append("- Close window\n", style="white")

help_text.append("Mod+h/j/k/l                              ", style="cyan")
help_text.append("- Move focus left/down/up/right\n", style="white")

help_text.append("Mod+Shift+h/j/k/l                        ", style="cyan")
help_text.append("- Move window left/down/up/right\n", style="white")

help_text.append("Mod+f                                    ", style="cyan")
help_text.append("- Toggle fullscreen\n", style="white")

help_text.append("Mod+space                                ", style="cyan")
help_text.append("- Toggle floating mode\n", style="white")

help_text.append("Mod+1-9                                  ", style="cyan")
help_text.append("- Switch to workspace 1-9\n", style="white")

help_text.append("Mod+Shift+1-9                            ", style="cyan")
help_text.append("- Move window to workspace 1-9\n", style="white")

help_text.append("Mod+Shift+e                              ", style="cyan")
help_text.append("- Exit i3\n", style="white")

help_text.append("─────────────────────────────────────────────────────────────────────────\n", style="bright_black")
help_text.append("(Press 'q' or 'Esc' to close)\n", style="magenta")

# Display the help panel with a title
console.print(
    Panel(
        help_text,
        title="[bold yellow]i3 Help[/bold yellow]",
        expand=False,
        border_style="blue",
    )
)

# Wait for user to press Enter before closing
input("\nPress Enter to exit...")

