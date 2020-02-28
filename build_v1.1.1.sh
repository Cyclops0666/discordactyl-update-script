#!/bin/bash

    clear
    echo "WARNING: THIS UPDATE WILL OVERWRITE THE THEME. IF YOU WOULD LIKE TO ABORT, DO CTRL+C"
    sleep 5


    clear
    echo "Checking if you installed the theme..."
    cd /root
    FILE=/root/discordactyl_v1.1.1.zip
    [ -f "$FILE" ] && {

    echo "The update file is installed, continuing..."
    sleep 2

    # SCRIPT START

    echo "Starting  theme update.... Please do not leave."
    sleep 1

    echo "Installing zip"
    apt install zip unzip --yes
    sleep 1


    echo "Backing up Pterodactyl directory just in case."
    zip -r ptero-backup-$(date +"%Y-%m-%d").zip /var/www/pterodactyl
    sleep 1

    echo "Unzipping theme"
    cd /root
    unzip discordactyl_v1.1.1.zip -d /root/tempunzip
    sleep 1

    
    echo "Copying the themes.php file"
    cd /root/tempunzip
    cp -r /root/tempunzip/discordactyl_v1.1.1/config/themes.php /var/www/pterodactyl/config/ # Copies over the themes.php file
    sleep 1

    echo "Making neccesarry directories"
    cd /var/www/pterodactyl/public/themes
    mkdir -p discordactyl
    sleep 1
    
    cd /var/www/pterodactyl/resources/themes
    mkdir -p discordactyl
    sleep 1

    
    echo "Copying the public theme"
    cp -r /root/tempunzip/discordactyl_v1.1.1/public/themes/discordactyl/* /var/www/pterodactyl/public/themes/discordactyl
    sleep 1

    echo "Copying the resources theme"
    cp -r /root/tempunzip/discordactyl_v1.1.1/resources/themes/discordactyl/* /var/www/pterodactyl/resources/themes/discordactyl
    sleep 1

    echo "Files have been copied over!"
    sleep 2


    echo "Removing the temp folders created in the copy process"
    sleep 2

    rm -rf /root/tempunzip
    rm -rf /root/discordactyl_v1.1.1.zip


    echo "Clearing pterodactyl views and cache"
    cd /var/www/pterodactyl
    php artisan cache:clear 
    php artisan view:clear

    sleep 3

    clear

    [ -f /var/www/pterodactyl/public/themes/discordactyl/css/custom.css ] && echo "custom.css file exists... skipping creating one" || cd /var/www/pterodactyl/public/themes/discordactyl/css/ && touch custom.css

    echo "Discordactyl has been succesfully updated!"
    echo "IMPORTANT"
    echo "Edit your .env file in /var/www/pterodactyl/ and change the APP_THEME value to discordactyl"
    sleep 3
    } || echo "You have not installed the update file. Please install it and run the command again"

    
    #SCRIPT END
