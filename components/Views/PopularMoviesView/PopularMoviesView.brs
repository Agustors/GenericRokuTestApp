function init()
    m.top.setFocus(true)

    'Title Label
    m.popularMoviesLabel = m.top.findNode("popularMoviesLabel")
    m.popularMoviesLabel.font.size=30
    m.popularMoviesLabel.color="0x72D7EEFF"

    'RowList
    m.rowList = m.top.findNode("popularMoviesRowList")
    m.rowList.observeField("rowItemSelected","onItemSelectedChanged")
    m.rowList.observeField("rowItemFocused","onItemFocusedChanged")

    'ApiTask
    m.apiTask = CreateObject("roSGNode","ApiTask")
    m.apiTask.observeField("content","setPopularMoviesRowListContent")

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
    example = m.top.findNode("exampleScrollingLabel")
    examplerect = example.boundingRect()
    centerx = (1280 - examplerect.width) / 2
    centery = (720 - examplerect.height) / 2 + 100
    example.translation = [ centerx, centery ]
    m.top.setFocus(true)


end function

sub executeShowsAPICall(callParams)
    m.apiTask.callID = "shows"
    m.apiTask.callParams = callParams 
    m.apiTask.control = "RUN"
end sub

sub setPopularMoviesRowListContent(ev)
    data = ev.getData()
    m.rowList.focusable = false
    if data.getChildCount() > 0 then
        page = m.global.page.toInt()
        if page = 1
            rowListContent = CreateObject("roSGNode","ContentNode")
            rowListContent.appendChild(data)
            m.rowList.content = rowListContent
        else if m.rowList.content <> invalid and m.rowList.content.getChild(0) <> invalid
            m.rowList.content.getChild(0).appendChildren(data.getChildren(-1,0))
        end if
        m.rowList.visible = true
        m.rowList.focusable = true
        m.rowList.setFocus(true)
    end if
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
    if focusedItem > numberOfItemsInRow - 230 
        previousPage = m.global.page.toInt()
        nextPage = (previousPage + 1).toStr()
        m.global.page = nextPage
        'print"nextPage: "nextPage
        callParams = {page: nextPage} 'next page
        executeShowsAPICall(callParams)
    end if
end sub