sub init()
    'VideoPlayer
    m.videoPlayer = m.top.findNode("videoPlayer")

    'VideoOptionsButtons
    m.videoOptionsButtons = m.top.findNode("videoOptionsButtons")
    m.videoOptionsButtons = m.top.findNode("videoOptionsButtons")
    'm.videoOptionsButtons.focusBitmapUri = "pkg:/images/backgrounds/button_topnav_focused_fhd.9.png"
    'm.videoOptionsButtons.focusBitmapUri = "pkg:/images/backgrounds/button_topnav_focused_fhd.9.png"

    'RowList
    m.rowList = m.top.findNode("popularMoviesRowList")

    m.top.setFocus(true)
end sub


sub setContent()
    videocontent = createObject("RoSGNode", "ContentNode")
    
    videocontent.title = "Player"
    videocontent.streamformat = "hls"
    videocontent.url = "http://qthttp.apple.com.edgesuite.net/1010qwoeiuryfg/sl.m3u8"
    
    video = m.top.findNode("videoPlayer")
    video.content = videocontent
    
    video.setFocus(true)
    
    video.control = "play"
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
    
    handled = false
    if press then
        if (key = "back" and m.rowList.visible = true and m.VideoOptionsButtons.visible = true)
            m.rowList.visible = false
            m.VideoOptionsButtons.visible = false
            m.videoPlayer.setFocus(true)
            handled = true
        else if (key = "down" and m.rowList.visible = false and m.VideoOptionsButtons.visible = false)
            m.VideoOptionsButtons.visible = true
            m.VideoOptionsButtons.setFocus(true)
            m.rowList.visible = true
            m.rowList.setFocus(true)
            handled = true
        else if (key = "up" and m.rowList.hasFocus())
            m.VideoOptionsButtons.setFocus(true)
            handled = true
        else if (key = "up" and m.VideoOptionsButtons.hasFocus())
            m.VideoOptionsButtons.visible = false
            m.VideoOptionsButtons.setFocus(false)
            m.rowList.visible = false
            m.rowList.setFocus(false)
            m.videoPlayer.setFocus(true)
            handled = true
        end if
    end if
    return handled
  end function