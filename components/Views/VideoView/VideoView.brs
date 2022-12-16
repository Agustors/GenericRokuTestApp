sub init()
    videocontent = createObject("RoSGNode", "ContentNode")

    videocontent.title = "Player"
    videocontent.streamformat = "hls"
    videocontent.url = "http://qthttp.apple.com.edgesuite.net/1010qwoeiuryfg/sl.m3u8"

    video = m.top.findNode("videoPlayer")
    video.content = videocontent

    video.setFocus(true)
    video.control = "play"
end sub