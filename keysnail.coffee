###{{%PRESERVE%### # Site local keymap
local = {}
plugins.options["site_local_keymap.local_keymap"] = local

fake   = (k, i) -> -> key.feed k, i
pass   = (k, i) -> [k, (fake k, i)]
ignore = (k) -> [k, null]

local["^https?://(\w+\.)*slashdot.jp/"] = [
    ignore('h'),
    ignore('j'),
    ignore('k'),
    ignore('l'),
    # ignore('w'),
    # ignore('a'),
    # ignore('s'),
    # ignore('d'),
    # ignore('q'),
    # ignore('e'),
    # ignore('f'),
    # ignore('p'),
    # ignore('v'),
    # ignore('t'),
]
###}}%PRESERVE%###

view = ->
    a = Array.prototype.slice.call arguments
    key.setViewKey.apply key, ([a[0], a[a.length-1]].concat a[1..a.length-2])
edit = ->
    a = Array.prototype.slice.call arguments
    key.setEditKey.apply key, ([a[0], a[a.length-1]].concat a[1..a.length-2])

key.quitKey              = "C-["
key.helpKey              = "undefined"
key.escapeKey            = "C-v"
key.macroStartKey        = "undefined"
key.macroEndKey          = "undefined"
key.universalArgumentKey = "undefined"
key.negativeArgument1Key = "undefined"
key.negativeArgument2Key = "undefined"
key.negativeArgument3Key = "undefined"
key.suspendKey           = "C-z"

# Hit a hint
view 'e', 'Hok - Foreground hint mode', true, (ev, arg) -> ext.exec "hok-start-foreground-mode", arg
view 'E', 'HoK - Background hint mode', true, (ev, arg) -> ext.exec "hok-start-background-mode", arg
view ';',   'Start extended hint mode', true, (ev, arg) -> ext.exec "hok-start-extended-mode", arg
view ['C-c', 'C-e'], 'Start continuous HaH', true, (ev, arg) -> ext.exec "hok-start-continuous-mode", arg
view 'c', 'Hok - Foreground yank hint mode', true, (ev, arg) -> ext.exec "hok-yank-foreground-mode", arg

# scroll
view 'h', 'Scroll left',      (ev) -> key.generateKey ev.originalTarget, KeyEvent.DOM_VK_LEFT, true
view 'j', 'Scroll line down', (ev) -> key.generateKey ev.originalTarget, KeyEvent.DOM_VK_DOWN, true
view 'k', 'Scroll line up',   (ev) -> key.generateKey ev.originalTarget, KeyEvent.DOM_VK_UP, true
view 'l', 'Scroll right',     (ev) -> key.generateKey ev.originalTarget, KeyEvent.DOM_VK_RIGHT, true
view ['g', 'g'], 'Scroll to the top of the page', true, -> goDoCommand "cmd_scrollTop"
view 'G',     'Scroll to the bottom of the page', true, -> goDoCommand "cmd_scrollBottom"

# jump to a page
view 'r', 'Reload the page', true, -> BrowserReload()
view 'H', 'Back',    -> BrowserBack()
view 'L', 'Forward', -> BrowserForward()
view 'd', 'Close tab / window', -> BrowserCloseTabOrWindow()
view 'u', 'Undo closed tab', -> undoCloseTab()

# tabs
view 'w', 'Select next tab',     -> getBrowser().mTabContainer.advanceSelectedTab  1, true
view 'b', 'Select previous tab', -> getBrowser().mTabContainer.advanceSelectedTab -1, true

view 'W', 'Move selected tab to left', (ev) ->
    browser = getBrowser()
    pos = (-> if @previousSibling then @_tPos + 1 else 0).call browser.mCurrentTab
    browser.moveTabTo browser.mCurrentTab, pos

view 'B', 'Move selected tab to left', (ev) ->
    browser = getBrowser()
    pos = (-> if @previousSibling then @_tPos - 1 else @childNodes.length - 1).call browser.mCurrentTab
    browser.moveTabTo browser.mCurrentTab, pos

# find
view '/', 'Incremental search forward',  -> command.iSearchForward()
view '?', 'Incremental search backward', -> command.iSearchBackward()

view 'f', 'Forcus to the first textarea', true, (ev) ->
    command.focusElement command.elementsRetrieverTextarea, 0

# misc
view ':', 'List and execute commands', true, (ev, arg) ->
    shell.input null, arg

view 'i', 'Toggle caret mode', true, (ev, arg) ->
    util.setBoolPref "accessibility.browsewithcaret", (not util.getBoolPref "accessibility.browsewithcaret")

view 'y', 'Yank current page address', true, (ev, arg) ->
    command.setClipboardText content.document.location.href
    display.echoStatusBar ("Yanked " + content.document.location.href)

view 'p','Open yanked address or google it', true, (ev, arg) ->
    url = command.getClipboardText()
    if url.match(/\s/) or url.indexOf("://") is -1
        url = "http://www.google.com/search?q=" + encodeURIComponent(url) + "&ie=utf-8&oe=utf-8&aq=t"
    getBrowser().loadOneTab url, null, null, null, false

# edit
edit 'C-h', 'Delete backward char', -> goDoCommand "cmd_deleteCharBackward"
edit 'C-d', 'Delete forward char',  -> goDoCommand "cmd_deleteCharForward"
edit 'C-k', 'Kill the rest of the line', (ev) -> command.killLine ev
edit 'C-a', 'Beginning of the line',     (ev) -> command.beginLine ev
edit 'C-e', 'End of the line',           (ev) -> command.endLine ev
