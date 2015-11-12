#!/usr/bin/env sh

# From:
# http://stackoverflow.com/questions/4404242/programmatically-launch-terminal-app-with-a-specified-command-and-custom-colors

echo '
on run argv
    if length of argv is equal to 0
        set command to ""
    else
        set command to item 1 of argv
    end if

    if length of argv is greater than 1
        set profile to item 2 of argv
        runWithProfile(command, profile)
    else
        runSimple(command)
    end if
end run

on runSimple(command)
    tell application "Terminal"
        activate
        set shell to do script(command) in window 1
    end tell
end runSimple

on runWithProfile(command, profile)
    runSimple(command)
    tell application "Terminal" to set current settings of window 1 to (first settings set whose name is profile)
end runWithProfile
' | osascript - "$@" > /dev/null

