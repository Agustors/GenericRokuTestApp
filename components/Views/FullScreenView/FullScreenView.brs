sub init()
    'Actors asset
    m.actorImage = m.top.findNode("actorImage")
    m.actorName = m.top.findNode("actorName")
    m.actorCharacterName = m.top.findNode("actorCharacterName")
    m.actorCharacterImage = m.top.findNode("actorCharacterImage")
end sub

sub setContent(ev)
    data = ev.getdata()
    'verify this validation no if condition is needed here, this is a quick fix for now
    if data.itemContent <> invalid
        itemContentArray = {}
        itemContentArray.data = {
            actorName: data.itemContent.person.name,
            actorPoster: data.itemContent.person.image.original
            characterName: data.itemContent.character.name
            characterPoster: data.itemContent.character.image.original
        }
    else 
        'quick fix due to invalid character image coming from remote api
        'near future task: a better data validation is to be obtained regarding all data
        if data.character.image = invalid or data.person.image = invalid
            if data.person.image <> invalid
                actorImage = data.person.image.original
            else
                actorImage = "pkg:/images/placeholders/placeholder_square.png"
            end if
            characterImage = "pkg:/images/placeholders/placeholder_square.png"
        else 
            actorImage = data.person.image.original
            characterImage = data.character.image.original
        end if
        itemContentArray = {}
        itemContentArray.data = {
            actorName: data.person.name,
            actorPoster: actorImage
            characterName: data.character.name
            characterPoster: characterImage
        } 
    end if
    
    m.actorName.text = itemContentArray.data.actorName
    m.actorImage.uri = itemContentArray.data.actorPoster
    m.actorCharacterName.text = itemContentArray.data.characterName
    m.actorCharacterImage.uri = itemContentArray.data.characterPoster
end sub