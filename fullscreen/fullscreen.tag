//live
// tagui fullscreen.tag -edge
// unfortunately Chrome cannot do fullscreen easily on TagUI due to shortcuts stuck on []

// assume primary monitor used, need to click to focus the keyboard
click (500,500)
echo  `get_env('HOME')`
home_dir = get_env('HOME')
if (home_dir contains "/Users")
    echo mac detected
    wait 3
    keyboard [ctrl][cmd][f]
else
    wait 1
    echo windows assumed on chrome and edge 
    keyboard [f11]

