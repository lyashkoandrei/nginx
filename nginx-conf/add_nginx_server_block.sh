#!/bin/bash
echo Enter Domain Name
read -r DOMAIN
sudo mkdir /var/www/"$DOMAIN"
echo Catalog Created
sudo chown -R www-data:www-data /var/www/"$DOMAIN"
sudo chmod -R 777 /var/www/"$DOMAIN"
echo permission changed
cp nginx_example_config "$DOMAIN"
sed -i "s/domain/${DOMAIN}/g" "$DOMAIN"
sudo mv "$DOMAIN" /etc/nginx/sites-available/"$DOMAIN"
echo Config file moved
sudo ln -s /etc/nginx/sites-available/"$DOMAIN" /etc/nginx/sites-enabled
echo Symlink created
sudo nginx -t
echo "Do you wish to continue?"
select yn in "Yes" "No"; do
	case $yn in
		Yes ) 
            sudo service nginx restart;
			echo Virtual block succefully created
            sudo sed -i "1i127.0.0.1    $DOMAIN" /etc/hosts
			break;;
		No ) exit;;
	esac
done
