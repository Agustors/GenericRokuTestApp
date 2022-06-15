sub init()
    m.top.id = "RowListItem"
    m.itemposter = m.top.findNode("itemPoster") 
    m.itemmask = m.top.findNode("itemMask")
    m.itemLabel = m.top.findNode("itemLabel")

  end sub

  sub showcontent()
    print"m.top.itemContent: "m.top.itemContent
    
    itemContentArray = {}
    if m.top.itemContent.image <> invalid and m.top.itemContent.name <> invalid
      itemContentArray.data = {
        poster: m.top.itemContent.image.medium,
        title: m.top.itemContent.name,
      }
    else
      itemContentArray.data = {
        poster: "pkg:/images/channel-poster_hd.png",
        title: "default name",
      }
    end if

    m.itemLabel.text = itemContentArray.data.title
    print"m.itemLabel.text: "m.itemLabel.text
    
    m.itemPoster.uri = itemContentArray.data.poster
    print"m.itemPoster.uri: "m.itemPoster.uri
  end sub