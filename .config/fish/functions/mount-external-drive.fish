function mount-external-drive
    set mountpoint "/mount/usb0"
    set mount_location (lsblk | grep -Eo "sd[a-z]1")
    sudo mount /dev/$mount_location $mountpoint
    cd $mountpoint
end
