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
    m.top.observeField("playContent","onPlayContentChanged")
end sub

sub onSelectedContentNodeChanged(ev)
    
    if ev.getData().character <> invalid and ev.getData().person <> invalid 
        
        showView("FullScreenView",ev.getData()) 'display the fullscreen view
    else     
        showView("DetailView",ev.getData())
    end if
end sub

sub onPlayContentChanged(ev)
    showView("VideoView", ev.getData())
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
  handled = false
  if press then
    if (key = "back") then
        handled = restorePreviousView()
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
        if itemContent <> invalid and m.currentView.hasField("itemContent") and m.currentView.hasField("itemContent") <> invalid then
            if itemContent.subtype() = "FullScreenView"
                content = itemContent.itemContent
                m.currentView.itemContent = content
            else
                m.currentView.itemContent = itemContent
            end if
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
            end if
            
            m.previousStoredView = m.viewStack.Pop() 'Get previous view form the array and remove it from the stack
            m.currentView = m.previousStoredView.view
            m.top.appendChild(m.currentView)
            previousViewFocusedItem = m.previousStoredView.focusedChild.getchildren(-1,0)[1]
            if previousViewFocusedItem <> invalid then 'm.previousStoredView.focusedChild.getchildren(-1,0)[1].focusedChild
                previousViewFocusedItem.focusable = true 'works
                previousViewFocusedItem.setFocus(true) 'works
            else
                m.previousStoredView.focusedChild.focusable = true 'Recover focus in the correct child in the view
                m.previousStoredView.focusedChild.setFocus(true) 'Recover focus in the correct child in the view
            end if
            return true
      end if
      return false
end function