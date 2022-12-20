sub init()
    'print "Init SearchView"

    'searchOptionsGroup 'test
    m.searchOptionsGroup = m.top.findNode("searchOptionsGroup")
    m.searchOptionsGroup.buttons = [ "Search Movies", "Search Series" ] 
    m.searchOptionsGroup.focusedTextColor = "0x72D7EEFF" 
    m.searchOptionsGroup.iconUri = "pkg:/images/stars/x_square_icon.png" 
    m.searchOptionsGroup.focusedIconUri = "pkg:/images/stars/x_square_icon.png" 
    m.searchOptionsGroup.itemSpacings = 15 
    m.searchOptionsGroup.focusButton = 0 
    m.searchOptionsGroup.focusFootprintBitmapUri = "pkg:/images/stars/focusFootprint.png"
    m.searchOptionsGroup.focusBitmapUri = "pkg:/images/stars/focus.png"
    
    m.searchOptionsGroup.observeField("buttonSelected", "onSearchOptionsGroupButtonSelected")

    'Actors Label
    m.searchResultLabel = m.top.findNode("searchResultLabel")
    m.searchResultLabel.font.size=30
    m.searchResultLabel.color="0x72D7EEFF"

    m.assetTitleText = m.top.findNode("assetTitleText")
    m.assetImage = m.top.findNode("assetImage")
    m.assetDescriptionText = m.top.findNode("assetDescriptionText")
    m.assetDescription = m.top.findNode("assetDescription")

    ' m.playButton = m.top.findNode("playButton")
    ' m.playButton.visible = false
    ' m.playButton.observeField("buttonSelected", "onShowVodButtonSelected")
    
    m.actorsRowList = m.top.findNode("actorsRowList")

    'ApiTask
    m.apiTask = CreateObject("roSGNode","ApiTask")
    m.apiTask.observeField("content","setActorsRowListContent")
    
    movieIndex = onCallParamsMovieIndexChanged()
    executeCastAPICall(movieIndex)

    'RowList
    m.actorsRowList = m.top.findNode("actorsRowList")
    m.actorsRowList.observeField("rowItemSelected","onActorsRowListItemSelectedChanged")

    'FocusedChild
    m.top.observeField("FocusedChild","onFocusedChildChanged")

end sub

sub onSearchOptionsGroupButtonSelected()
    stop
    m.searchOptionsGroup.iconUri = "pkg:/images/stars/confirm-large-light.png"
end sub

' *************************************************
' Function that returns movieIndex
' @param no params
' @return - movieIndex
' *************************************************
function onCallParamsMovieIndexChanged() 
    return m.global.movieIndex
end function

' *************************************************
' Function that sets focus
' @param no params
' @return no params
' *************************************************
sub onFocusedChildChanged() 
    m.top.setfocus(true)
end sub

' *************************************************
' Function that executes Cast api call with movieIndex param
' @param - movieIndex
' @return no params
' *************************************************
sub executeCastAPICall(movieIndex)
    callParams = {movieIndex: movieIndex}
    m.apiTask.callID = "Cast"
    m.apiTask.callParams = callParams
    m.apiTask.control = "RUN"
end sub

' *************************************************
' Sub that sets full Screen content according to Actor's RowList ItemSelected
' @param - event
' @return no params
' *************************************************
sub onActorsRowListItemSelectedChanged(ev)
    content = ev.getRoSGNode().content
    row = ev.getData()[0]
    item = ev.getData()[1]
    selectedItemContent = content.getChild(row).getChild(item)
    if content <> invalid and selectedItemContent <> invalid and m.top.getParent() <> invalid then
        m.top.getParent().selectedContentNode = selectedItemContent
    end if
end sub

' *************************************************
' Sub that sets ActorsRowList content
' @param - event
' @return no params
' *************************************************
sub setActorsRowListContent(ev)
    data = ev.getData()
    actorsRowListContent = CreateObject("roSGNode","ContentNode")
    actorsRowListContent.appendChild(data)
    m.actorsRowList.content = actorsRowListContent
    m.actorsRowList.content.addfields({"contentType":"actorsRowListContent"})
    m.actorsRowList.visible = true
    m.actorsRowList.focusable = true
    m.actorsRowList.setFocus(true)
end sub

' *************************************************
' Sub to play VOD content (work in progress)
' @param - event
' @return no params
' *************************************************
sub onButtonSelectedChanged(ev)
    if m.top.getParent() <> invalid then
        m.top.getParent().playContent = true
    end if
end sub

' *************************************************
' Sub that sets content of DetailView
' @param - event
' @return no params
' *************************************************
sub setContent(ev)
    data = ev.getData()
    m.top.itemContent = data
    
    if data.content <> invalid and data.content.person <> invalid and data.content.character <> invalid and type(data.content.person) = "roAssociativeArray" and type(data.content.character) = "roAssociativeArray"
        itemContentArray = {}
        itemContentArray.data = {
            title: data.content.person.name,
            poster: data.content.person.image.medium,
        }
    else
        'code to delete html tags present in description text
        descriptionStr = data.summary
        comboReplaceCases = [["<b>",""], ["</b>",""], ["<p>",""], ["</p>",""], ["<i>",""], ["</i>",""], ["<br />",""], ["/"," "]]
        for each combo in comboReplaceCases
            descriptionStr = descriptionStr.replace(combo[0],combo[1])
        end for
        
        itemContentArray = {}
        itemContentArray.data = {
            title: data.name,
            poster: data.image.original,
            description: descriptionStr
        }
    end if
    
    m.assetTitleText.text = itemContentArray.data.title
    m.assetImage.uri = itemContentArray.data.poster
    if itemContentArray.data.description = invalid
        m.assetDescriptionText.text = ""
    else
        m.assetDescriptionText.text = itemContentArray.data.description
    end if
    
    if itemContentArray.data.description = invalid or itemContentArray.data.description = ""
        m.assetDescriptionText.text = "Lorem Ipsum is simply dummy text of the 'printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown 'printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
    end if
    
end sub