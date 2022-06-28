sub init()
    'Field to control view that must be created once
    'Names inside viewControl must be the component names that must only have one "instance" running
    m.viewControl={
        PopularMoviesView: false
        DetailView: false
        VideoView: false
        FullScreenView: false
    }
    m.viewStack = [] 'Field to store the previous screen in the app
    showView("PopularMoviesView") 'Show/Create the first view of the app
    m.top.observeField("selectedContentNode","onSelectedContentNodeChanged")
    print "m.top.observeField(playContent,onPlayContentChanged): "m.top.observeField("playContent","onPlayContentChanged")
    m.top.observeField("playContent","onPlayContentChanged")
end sub

sub onSelectedContentNodeChanged(ev)
    print"onSelectedContentNodeChanged(ev): "ev
    if ev.getData().subtype() = "FullScreenView"
        showView("FullScreenView",ev.getData().content) 'display the fullscreen view
    else     
        showView("DetailView",ev.getData())
    end if
end sub

sub onPlayContentChanged(ev)
    print"onPlayContentChanged(ev): "ev
    showView("VideoView", ev.getData())
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
  handled = false
  if press then
    if (key = "back") then
      handled = restorePreviousView()
    ' else if (key = "options")
    '   showView("SearchView")
    '   handled = true
    end if
  end if
  return handled
end function

function showView(viewName, itemContent = invalid)

    if canCreateView(viewName) then 'commented for testing
        storePreviousView()
        
        m.currentView = m.top.CreateChild(viewName) 'Add each child view as needed, PopularMoviesView as first view
        
        'Control the created views that must only be open one instance per moment
        if m.viewControl.doesExist(m.currentView.subType()) then
            m.viewControl[m.currentView.subType()] = true
        end if
        
        'Set content if view can receive a contentNode and if we received content to set on it
        if itemContent <> invalid and m.currentView.hasField("itemContent") then
            m.currentView.itemContent = itemContent
        end if

        m.currentView.setFocus(true) 'Set Focus in the View
    end if

end function

function canCreateView(viewName)
    if m.viewControl.doesExist(viewName) then return not m.viewControl[viewName]
    return true
end function

function storePreviousView()
    if m.currentView <> invalid then
        m.viewStack.push({view: m.currentView, focusedChild: m.currentView.focusedChild}) 'Store previous View before open the new one
        m.top.removeChild(m.currentView) 'Remove previous view from the screen
    end if
end function

function restorePreviousView()
      if m.viewStack.Count() > 0 then
            m.top.removeChild(m.currentView)
            
            'Control the created views that must only be open one instance per moment
            'Here we put the creation status false to allow create the view again if necessary
            if m.viewControl.doesExist(m.currentView.subType()) then
                m.viewControl[m.currentView.subType()] = false
                print"m.currentView.subType(): "m.currentView.subType()
            end if

            m.previousStoredView = m.viewStack.Pop() 'Get previous view form the array and remove it from the stack
            m.currentView = m.previousStoredView.view
            m.top.appendChild(m.currentView)
            if m.previousStoredView.focusedChild <> invalid then
                m.previousStoredView.focusedChild.setFocus(true) 'Recover focus in the correct child in the view
            else
                m.currentView.setFocus(true) 'Set focus in the recovered previous view
            end if
            return true
      end if
      return false
end function