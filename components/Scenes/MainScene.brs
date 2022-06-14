'Flow
'Get API Token
'Then create SearchView (without token we are not able to run Search API call)

sub init()
    print "Init MainScene"
    m.top.backgroundUri = "pkg:/images/backgrounds/bg1.jpg"
    createFirstScreen()
end sub

sub createFirstScreen()
'Create screen
m.ViewManager = m.top.CreateChild("ViewManager") 'Add view which is the manager of views
m.ViewManager.setFocus(true) 'Set Focus in the View
end sub