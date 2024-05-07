function init()
    m.top.setFocus(true)

    'contentHighlightTitle
    m.contentHighlightTitle = m.top.findNode("contentHighlightTitle")
    m.contentHighlightTitle.color = "0x72D7EEFF"

    'contentHighlightText
    m.contentHighlightText = m.top.findNode("contentHighlightText")

    'contentHighlightImage
    m.contentHighlightImage = m.top.findNode("contentHighlightImage")

    'Title Label
    m.contentRowsLabel = m.top.findNode("contentRowsLabel")
    m.contentRowsLabel.font.size = 20
    m.contentRowsLabel.color = "0x72D7EEFF"


    'RowList
    m.rowList = m.top.findNode("popularMoviesRowList")
    m.rowList.observeField("rowItemSelected","onItemSelectedChanged")
    m.rowList.observeField("rowItemFocused","onItemFocusedChanged")
    ' m.rowList.focusBitmapUri = "pkg:/images/backgrounds/nav_focus_off_footprint_fhd.9.png"
    m.rowList.focusBitmapUri = "pkg:/images/backgrounds/button_topnav_focused_fhd.9.png"

    'ApiTask
    m.apiTask = CreateObject("roSGNode","ApiTask")
    m.apiTask.observeField("content","setHomeScreenContent")

    'Initial Call Parameters
    initialCallparams = {page: "1"}
    m.global.addfields({page: "1"})
    executeShowsAPICall(initialCallparams)

    ' 'Search button
    ' example = m.top.findNode("searchButton")
    ' examplerect = example.boundingRect()
    ' centerx = (1280 - examplerect.width) / 2
    ' centery = (720 - examplerect.height) / 2 + 100
    ' example.translation = [ centerx, centery ]
    ' m.top.setFocus(true)

    'scrolling label
    'm.top.backgroundURI = "pkg:/images/btt_back.png"
    ' example = m.top.findNode("exampleScrollingLabel")
    ' examplerect = example.boundingRect()
    ' centerx = (1280 - examplerect.width) / 2 + 10
    ' centery = (720 - examplerect.height) / 2 + 100
    ' example.translation = [ centerx, centery ]

    'FocusedChild
    m.top.observeField("FocusedChild","onFocusedChildChanged")

    m.top.observeField("itemContent","populateContentHighlight")

    m.top.setFocus(true)


end function

sub executeShowsAPICall(callParams)
    m.apiTask.callID = "shows"
    m.apiTask.callParams = callParams 
    m.apiTask.control = "RUN"
end sub

sub setHomeScreenContent(ev)
    data = ev.getData()
    m.rowList.focusable = false
    if data.getChildCount() > 0 then
        page = m.global.page.toInt()
        if page = 1
            rowListContent = CreateObject("roSGNode","ContentNode")
            rowListContent.appendChild(data)
            m.rowList.content = rowListContent
            m.contentRowsLabel.visible = true
        else if m.rowList.content <> invalid and m.rowList.content.getChild(0) <> invalid
            m.rowList.content.getChild(0).appendChildren(data.getChildren(-1,0))
        end if
        m.rowList.visible = true
        m.rowList.focusable = true
        m.rowList.setFocus(true)
    end if
    
    item = data.getchildren(-1,0)[0]
    m.top.itemContent = item
end sub

sub onItemSelectedChanged(ev)
    content = ev.getRoSGNode().content
    row = ev.getData()[0]
    item = ev.getData()[1]
    m.global.addfields({movieIndex: ""}) 'reference for each movie cast api call
    m.top.movieIndex = (item + 1).toStr() 'item + 1 CAST call endpoint starts at "1", rowList first item starts with "0"
    selectedItemContent = content.getChild(row).getChild(item)
    if content <> invalid and selectedItemContent <> invalid and m.top.getParent() <> invalid then
        'm.top.getParent() is the ViewManager component
        m.top.getParent().selectedContentNode = selectedItemContent
    end if
end sub

sub onMovieIndexChanged()
    m.global.setFields({movieIndex: m.top.movieIndex}) 'reference for each movie cast api call
    print"m.top.movieIndex: "m.top.movieIndex
end sub

sub onItemFocusedChanged(ev) 
    if m.apiTask.state = "run" then 
        'print "Already fetching the next page.. "
        return
    end if
    content = ev.getRoSGNode().content
    focusedRow = ev.getData()[0]
    focusedItem = ev.getData()[1]
    numberOfItemsInRow = content.getChild(focusedRow).getChildCount()
    ' if focusedItem > numberOfItemsInRow '- 30 
    '     previousPage = m.global.page.toInt()
    '     nextPage = (previousPage + 1).toStr()
    '     m.global.page = nextPage
    '     'print"nextPage: "nextPage
    '     callParams = {page: nextPage} 'next page
    '     executeShowsAPICall(callParams)
    ' end if
    item = content.getchildren(-1,0)[0].getchildren(-1,0)[focusedItem]
    
    m.top.itemContent = item
    populateContentHighlight()
end sub

sub populateContentHighlight()
    item = m.top.itemContent
    if item <> invalid then
        descriptionStr = item.summary
    end if

    'code to delete html tags present in description text
    comboReplaceCases = [["<b>",""], ["</b>",""], ["<p>",""], ["</p>",""], ["<i>",""], ["</i>",""], ["<br />",""], ["/"," "]]
    for each combo in comboReplaceCases
        descriptionStr = descriptionStr.replace(combo[0],combo[1])
    end for
    item = m.top.itemContent
    m.contentHighlightTitle.text = item?.name 
    m.contentHighlightText.text = descriptionStr
    m.contentHighlightImage.uri = item?.image?.original
end sub