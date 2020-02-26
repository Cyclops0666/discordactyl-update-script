#!/bin/bash

    echo "Starting theme update.... Please do not leave."
    sleep 1

    echo "Installing zip"
    apt install zip unzip


    echo "Backing up Pterodactyl directory just in case."
    zip -r Ptero-Backup-$(date +"%Y-%m-%d").zip /var/www/pterodactyl


    echo "Checking if you installed the theme"
    cd /root
    FILE=/root/discordactyl_v1.1.zip
    if [ -f "$FILE" ]; then
    echo "The update is installed, continuing..."
    sleep 2

    # SCRIPT START
        echo "Updating theme..."
    cd /root
    cd /var/www/pterodactyl/


    echo "Unzipping theme"
    cd /root
    unzip discordactyl_v1.1.zip -d /root/tempunzip
    sleep 1

    
    echo "Copying the themes.php file"
    cd /root/tempunzip
    cp -r /root/tempunzip/discordactyl_v1.1/config/themes.php /var/www/pterodactyl/config/ # Copies over the themes.php file

    echo "Making neccesarry directories"
    cd /var/www/pterodactyl/public/themes
    mkdir -p discordactyl

    cd /var/www/pterodactyl/resources/themes
    mkdir -p discordactyl

    
    echo "Copying the public theme"
    cp -r /root/tempunzip/discordactyl_v1.1/public/themes/discordactyl/* /var/www/pterodactyl/public/themes/discordactyl


    echo "Copying the resources theme"
    cp -r /root/tempunzip/discordactyl_v1.1/resources/themes/discordactyl/* /var/www/pterodactyl/resources/themes/discordactyl




    echo "Files have been copied over!"
    sleep 2


    echo "Removing the temp folders created in the copy process"
    sleep 2

    rm -rf /root/tempunzip
    rm -rf /root/discordactyl_v1.1.zip


    echo "Clearing pterodactyl views and cache"
    cd /var/www/pterodactyl
    php artisan cache:clear 
    php artisan view:clear

    sleep 3

    clear
    echo "Discordactyl has been succesfully updated!"
    echo "IMPORTANT"
    echo "Edit your .env file in /var/www/pterodactyl/ and change the APP_THEME value to discordactyl"
    sleep 3

    #SCRIPT END



    else 
    echo "You have not installed the update file. Please install it and run the command again"
    fi
    
fi
