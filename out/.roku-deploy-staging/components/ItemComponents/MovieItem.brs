sub init()
    m.top.id = "RowListItem"
    m.itemPoster = m.top.findNode("itemPoster") 
    m.itemMask = m.top.findNode("itemMask")
    m.itemLabel = m.top.findNode("itemLabel")

  end sub

  sub showContent()
    itemContentArray = {}
    if m.top.itemContent.image <> invalid and m.top.itemContent.name <> invalid 'm.top.itemContent.contentType <> invalid and m.top.itemContent.contentType = "popularMoviesRowListContent"
        itemContentArray.data = {
            poster: m.top.itemContent.image.medium,
            title: m.top.itemContent.name,
        }
        'ToDo: the following m.top.itemContent.person.image may be invalid in some cases, better validation is required
    else if m.top.itemContent.DoesExist("person") and m.top.itemContent.person <> invalid and m.top.itemContent.person.name <> invalid 'm.top.itemContent.contentType <> invalid and m.top.itemContent.contentType = "actorsRowListContent"
        itemContentArray.data = {
            poster: m.top.itemContent.person.image.medium, 'm.top.itemContent.getchild(0).getchildren(-1,0)[0].person.image.medium
            title: m.top.itemContent.person.name,
        }
    else if m.top.itemContent.DoesExist("show") <> invalid and m.top.itemContent.show.image <> invalid and m.top.itemContent.show.name <> invalid 'm.top.itemContent.contentType <> invalid and m.top.itemContent.contentType = "actorsRowListContent"
        itemContentArray.data = {
            poster: m.top.itemContent.show.image.medium, 'm.top.itemContent.getchild(0).getchildren(-1,0)[0].person.image.medium
            title: m.top.itemContent.show.name,
        }
    else
      itemContentArray.data = {
        poster: "pkg:/images/channel-poster_hd.png",
        title: "default name",
      }
    end if

    m.itemLabel.text = itemContentArray.data.title
    
    m.itemPoster.uri = itemContentArray.data.poster
  end sub