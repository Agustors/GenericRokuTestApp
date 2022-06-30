sub init()
    'Actors asset
    m.actorImage = m.top.findNode("actorImage")
    m.actorName = m.top.findNode("actorName")
    m.actorCharacter = m.top.findNode("actorCharacter")
end sub

sub setContent(ev)
    data = ev.getdata()
    'verify this validation no if condition is needed here, this is a quick fix for now
    if data.itemContent <> invalid
        itemContentArray = {}
        itemContentArray.data = {
            name: data.itemContent.person.name,
            poster: data.itemContent.person.image.original
            character: data.itemContent.character.name
        }
    else 
        itemContentArray = {}
        itemContentArray.data = {
            name: data.person.name,
            poster: data.person.image.original
            character: data.character.name
        } 
    end if
    
    m.actorImage.uri = itemContentArray.data.poster
    m.actorName.text = itemContentArray.data.name
    m.actorCharacter.text = itemContentArray.data.character
end sub