config.load_autoconfig(True)

c.content.proxy = "http://192.168.4.10:4444/"
c.content.javascript.enabled = False

# Anything typed without a scheme gets passed to DEFAULT.
# Example: example.com -> DEFAULT -> http://example.com
c.url.auto_search = "schemeless"

# Prepend plain HTTP without URL-encoding slashes/path.
c.url.searchengines = {
    "DEFAULT": "http://{unquoted}",
}

config.bind("o", "cmd-set-text -s :open")
config.bind("O", "cmd-set-text -s :open -t")

START_PAGE = "http://notbob.i2p/"
c.url.default_page = START_PAGE
c.url.start_pages = [START_PAGE]

# get python-adblock for this
# note that there's no reason to use this if using just for i2p
# c.content.blocking.method = "both"
# c.content.blocking.adblock.lists = [
#     "https://easylist.to/easylist/easylist.txt",
#     "https://easylist.to/easylist/easyprivacy.txt",
# ]

c.fonts.default_family = ["Iosevka", "monospace"]

c.fonts.web.family.standard = "Iosevka"
c.fonts.web.family.serif = "Iosevka Slab"
c.fonts.web.family.sans_serif = "Iosevka"
c.fonts.web.family.fixed = "Iosevka Nerd Font"

c.content.headers.user_agent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/{upstream_browser_version_short} Safari/537.36"
