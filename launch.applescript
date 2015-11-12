# Launch new iTerm window using default profile

on run argv
    if length of argv is equal to 0
        set cmd to ""
    else
        set cmd to item 1 of argv
    end if

    tell application "iTerm"
        activate

        -- New terminal window
        set t to (make new terminal)

        tell t
            activate current session
            launch session "Default session"
            tell the last session
                write text cmd
            end tell
        end tell
    end tell
end run

