sub init()
    print "Init AssetDetailView"
    'Actors Label
    m.actorsLabel = m.top.findNode("actorsLabel")
    m.actorsLabel.font.size=30
    m.actorsLabel.color="0x72D7EEFF"

    m.assetTitleText = m.top.findNode("assetTitleText")
    m.assetImage = m.top.findNode("assetImage")
    m.assetDescriptionText = m.top.findNode("assetDescriptionText")
    m.assetDescription = m.top.findNode("assetDescription")

    m.playButton = m.top.findNode("playButton")
    m.playButton.observeField("buttonSelected", "onShowVodButtonSelected")
    
    m.actorsRowList = m.top.findNode("actorsRowList")

    'ApiTask
    m.apiTask = CreateObject("roSGNode","ApiTask")
    m.apiTask.observeField("content","setActorsRowListContent")
    executeCastAPICall()

end sub

sub executeCastAPICall()
    m.apiTask.callID = "Cast"
    m.apiTask.control = "RUN"
end sub

sub setActorsRowListContent(ev)
    data = ev.getData()
    actorsRowListContent = CreateObject("roSGNode","ContentNode")
    actorsRowListContent.appendChild(data)
    m.actorsRowList.content = actorsRowListContent
    m.actorsRowList.visible = true
    m.actorsRowList.focusable = true
    m.actorsRowList.setFocus(true)
    ' stop
end sub

sub onButtonSelectedChanged(ev)
    if m.top.getParent() <> invalid then
        m.top.getParent().playContent = true
    end if
end sub


sub setContent(ev)
    data = ev.getData()
    m.top.itemContent = data
    print"assetDetailView showContent: "m.top.itemContent
    
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
    
    m.assetTitleText.text = itemContentArray.data.title
    m.assetImage.uri = itemContentArray.data.poster
    m.assetDescriptionText.text = itemContentArray.data.description
    
    if itemContentArray.data.description = invalid or itemContentArray.data.description = ""
        m.assetDescriptionText.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
    end if
    
end sub

sub onShowVodButtonSelected() 
    m.top.getParent().playContent = true
end sub