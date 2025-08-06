sub init()
    'RowList
    m.rowList = m.top.findNode("popularMoviesRowList")
    m.rowList.observeField("rowItemSelected","onItemSelectedChanged")
    m.rowList.observeField("rowItemFocused","onItemFocusedChanged")
    ' m.rowList.focusBitmapUri = "pkg:/images/backgrounds/nav_focus_off_footprint_fhd.9.png"
    m.rowList.focusBitmapUri = "pkg:/images/backgrounds/button_topnav_focused_fhd.9.png"

    'ApiTask
    m.apiTask = CreateObject("roSGNode","ApiTask")
    m.apiTask.observeField("content","setVideoOptionsTrayContent")
    
    'Initial Call Parameters
    initialCallParams = {page: "1"}
    m.global.addFields({page: "1"})
    executeShowsAPICall(initialCallParams)
end sub
    

sub executeShowsAPICall(callParams)
    m.apiTask.callID = "shows"
    m.apiTask.callParams = callParams 
    m.apiTask.control = "RUN"
end sub

sub setVideoOptionsTrayContent(ev)
    data = ev.getData()
    m.rowList.focusable = false
    if data.getChildCount() > 0 then
        page = m.global.page.toInt()
        if page = 1
            rowListContent = CreateObject("roSGNode","ContentNode")
            rowListContent.appendChild(data)
            m.rowList.content = rowListContent
            'm.contentRowsLabel.visible = true
        else if m.rowList.content <> invalid and m.rowList.content.getChild(0) <> invalid
            m.rowList.content.getChild(0).appendChildren(data.getChildren(-1,0))
        end if
        m.rowList.visible = false
        m.rowList.focusable = true
        m.rowList.setFocus(true)
    end if
    
    item = data.getChildren(-1,0)[0]
    m.top.itemContent = item
end sub

