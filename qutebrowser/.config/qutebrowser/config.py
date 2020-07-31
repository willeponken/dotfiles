config.source("theme-nord.py")

c.auto_save.session = True

c.content.autoplay = False

c.downloads.location.directory = "~/downloads/"

c.fonts.default_family = "Consolas"
c.fonts.default_size = "13px"

c.tabs.padding = {"bottom": 1, "left": 5, "right": 5, "top": 1}

c.url.searchengines = {"DEFAULT": "https://google.com/search?q={}"}
c.url.default_page = "about:blank"
c.url.start_pages = "about:blank"

c.input.insert_mode.auto_leave = (
    False  # Do not leave insert mode if non-editable element is clicked.
)
c.input.insert_mode.auto_load = (
    True  # Switch to insert mode if editable element is focused.
)
c.input.insert_mode.plugins = (
    True  # Switch to insert mode when clicking plugin elements, e.g. Flash.
)

config.unbind("J", mode="normal")
config.unbind("K", mode="normal")
config.unbind("H", mode="normal")
config.unbind("L", mode="normal")

config.bind("H", "tab-prev")
config.bind("L", "tab-next")

config.bind("J", "back")
config.bind("K", "forward")

config.bind("<Ctrl-v>", "spawn mpv {url}")
config.bind("sc", "config-source")
