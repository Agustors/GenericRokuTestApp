sub init()
    'Actors asset
    m.image = m.top.findNode("image")
    m.imageTitle = m.top.findNode("imageTitle")
    m.description = m.top.findNode("description")
end sub

sub OnNewContent()
    m.image = m.top.content.person.image.medium
    m.imageTitle = m.top.content.person.name
    'm.description = m.top.content 'no description for now
    m.top.setFocus(true)
end sub