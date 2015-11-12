# Launch new iTerm 2 window using default profile

# References:
# http://stackoverflow.com/questions/4404242/programmatically-launch-terminal-app-with-a-specified-command-and-custom-colors
# http://superuser.com/questions/299482/how-do-i-set-up-an-applescript-to-open-a-new-iterm2-tab-and-change-the-directory


echo '
on run argv
    if length of argv is equal to 0
        set command to ""
    else
        set command to item 1 of argv
    end if

    runSimple(command)
end run

on runSimple(command)
    tell application "iTerm"
        activate
        set t to (make new terminal)
        tell t
            activate current session
            launch session "Default session"
            tell the last session
                write text command
            end tell
        end tell
    end tell
end runSimple
' | osascript - "$@" > /dev/null

