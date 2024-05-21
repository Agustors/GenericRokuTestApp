function theme() as object
    if m.theme = invalid then
        m.theme = {
            colors: {
                paraBlueHigh: "0x0064ffff"
                paraBlueLow: "0x0023a0ff"

                laguna: "0x1056c9ff"
                blueMyMind: "0x0092f3ff"
                persianRed: "0xe42121ff"
                singularity: "0x000000ff"
                darkMatter: "0x1d1d1dff"
                galaxy: "0x121212ff"
                nigel: "0x393939ff"
                celestialSphere: "0x666666ff"
                fiftyShadesOfCBS: "0x999999ff"
                meteor: "0xaaaaaaff"
                solarCloud: "0xcdcdcdff"
                jupiter: "0xefefefff"
                milkyWay: "0xeeeeeeff"
                plasma: "0xfafafaff"
                snowWhite: "0xffffffff"
                alertGreen: "0x00d86dff"
            }
            fontPath: "pkg:/fonts/Proxima Nova A {WEIGHT}.ttf"
            fonts: {
                heading01: {
                    size: 94
                    lineHeight: 72
                    lineSpacing: -45
                    weight: "black"
                }
                heading02: {
                    size: 72
                    lineHeight: 80
                    lineSpacing: -10
                    weight: "bold"
                }
                heading03: {
                    size: 56
                    lineHeight: 60
                    lineSpacing: -10
                    weight: "semibold"
                }
                heading04: {
                    size: 40
                    lineHeight: 46
                    lineSpacing: -4
                    weight: "semibold"
                }
                body01: {
                    size: 32
                    lineHeight: 38
                    lineSpacing: -3
                    weight: "semibold"
                }
                body02: {
                    size: 28
                    lineHeight: 34
                    lineSpacing: -2
                    weight: "regular"
                }
                body03: {
                    size: 24
                    lineHeight: 32
                    lineSpacing: 0
                    weight: "regular"
                }
                caption01: {
                    size: 22
                    lineHeight: 28
                    lineSpacing: -1
                    weight: "regular"
                }
                caption02: {
                    size: 18
                    lineHeight: 24
                    lineSpacing: 0
                    weight: "regular"
                }
                caption03: {
                    size: 16
                    lineHeight: 22
                    lineSpacing: 0
                    weight: "semibold"
                }
                atto12: {
                    size: 12
                    lineHeight: 16
                    lineSpacing: 0
                    weight: "semibold"
                }
                atto08: {
                    size: 8
                    lineHeight: 12
                    lineSpacing: 0
                    weight: "semibold"
                }
            }
        }
    end if
    return m.theme
end function

function getThemeColor(name as string, opacity = "ff" as string) as string
    color = theme().colors[name]
    if color <> invalid and opacity <> "ff" then
        color = color.mid(0, color.len() - 2) + opacity
    end if
    return color
end function

function getThemeFont(style as string, weight = "" as string) as object
    font = createObject("roSGNode", "CBSFont")
    fontInfo = getThemeFontInfo(style, weight)
    if fontInfo <> invalid then
        font.fontInfo = fontInfo
    end if
    return font
end function

function getThemeFontInfo(style as string, weight = "" as string) as object
    fontInfo = {}
    fontInfo.append(theme().fonts[style])
    if weight <> invalid and weight <> "" then
        fontInfo.weight = weight
    end if
    fontInfo.uri = getThemeFontUri(fontInfo.weight)
    return fontInfo
end function

function getThemeFontUri(weight = "" as string) as string
    return theme().fontPath.replace("{WEIGHT}", (" " + weight).trim())
end function

function getThemeFontSize(style as string) as integer
end function

function getAccentColor(opacity = "ff" as string) as string
    config = getGlobalField("config")
    if config <> invalid and config.appSplit <> invalid then
        return getThemeColor(config.appSplit.accentColor, opacity)
    end if
    return getThemeColor("paraBlueHigh", opacity)
end function
